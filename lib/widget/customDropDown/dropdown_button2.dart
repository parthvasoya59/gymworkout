

import 'dart:math' as math;
import 'dart:ui' show window;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const Duration _kDropdownMenuDuration = Duration(milliseconds: 300);
const double _kMenuItemHeight = kMinInteractiveDimension;
const double _kDenseButtonHeight = 24.0;
const EdgeInsets _kMenuItemPadding = EdgeInsets.symmetric(horizontal: 16.0);
const EdgeInsetsGeometry _kAlignedButtonPadding = EdgeInsetsDirectional.only(start: 16.0, end: 4.0);
const EdgeInsets _kUnalignedButtonPadding = EdgeInsets.zero;

class _DropdownMenuPainter extends CustomPainter {
  _DropdownMenuPainter({
    this.color,
    this.elevation,
    this.selectedIndex,
    required this.resize,
    required this.getSelectedItemOffset,
    required this.itemHeight,
    this.dropdownDecoration,
  })  : _painter = dropdownDecoration
                ?.copyWith(
                  color: dropdownDecoration.color ?? color,
                  boxShadow: dropdownDecoration.boxShadow ?? kElevationToShadow[elevation])
                .createBoxPainter() ??
            BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(2.0)),
              boxShadow: kElevationToShadow[elevation],
            ).createBoxPainter(),
        super(repaint: resize);

  final Color? color;
  final int? elevation;
  final int? selectedIndex;
  final Animation<double> resize;
  final ValueGetter<double> getSelectedItemOffset;
  final double itemHeight;
  final BoxDecoration? dropdownDecoration;

  final BoxPainter _painter;

  @override
  void paint(Canvas canvas, Size size) {
    final double selectedItemOffset = getSelectedItemOffset();
    final Tween<double> top = Tween<double>(begin: selectedItemOffset.clamp(0.0, math.max(size.height - itemHeight, 0.0)), end: 0.0);

    final Tween<double> bottom = Tween<double>(begin: (top.begin! + itemHeight).clamp(math.min(itemHeight, size.height), size.height), end: size.height);

    final Rect rect = Rect.fromLTRB(0.0, top.evaluate(resize), size.width, bottom.evaluate(resize));

    _painter.paint(canvas, rect.topLeft, ImageConfiguration(size: rect.size));
  }

  @override
  bool shouldRepaint(_DropdownMenuPainter oldPainter) {
    return oldPainter.color != color ||
        oldPainter.elevation != elevation ||
        oldPainter.selectedIndex != selectedIndex ||
        oldPainter.dropdownDecoration != dropdownDecoration ||
        oldPainter.itemHeight != itemHeight ||
        oldPainter.resize != resize;
  }
}

class _DropdownMenuItemButton<T> extends StatefulWidget {
  const _DropdownMenuItemButton({
    Key? key,
    this.padding,
    required this.borderRadius,
    required this.route,
    required this.buttonRect,
    required this.constraints,
    required this.itemIndex,
    required this.enableFeedback,
    this.customItemsIndexes,
    this.customItemsHeight,
  }) : super(key: key);

  final _DropdownRoute<T> route;
  final EdgeInsets? padding;
  final Rect buttonRect;
  final BoxConstraints constraints;
  final int itemIndex;
  final bool enableFeedback;
  final BorderRadius borderRadius;
  final List<int>? customItemsIndexes;
  final double? customItemsHeight;

  @override
  _DropdownMenuItemButtonState<T> createState() => _DropdownMenuItemButtonState<T>();
}

class _DropdownMenuItemButtonState<T>
    extends State<_DropdownMenuItemButton<T>> {
  void _handleFocusChange(bool focused) {
    final bool inTraditionalMode;
    switch (FocusManager.instance.highlightMode) {
      case FocusHighlightMode.touch:
        inTraditionalMode = false;
        break;
      case FocusHighlightMode.traditional:
        inTraditionalMode = true;
        break;
    }

    if (focused && inTraditionalMode) {
      final _MenuLimits menuLimits = widget.route.getMenuLimits(
        widget.buttonRect,
        widget.constraints.maxHeight,
        widget.itemIndex);
      widget.route.scrollController!.animateTo(
        menuLimits.scrollOffset,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 100),
      );
    }
  }

  void _handleOnTap() {
    final DropdownMenuItem<T> dropdownMenuItem = widget.route.items[widget.itemIndex].item!;

    dropdownMenuItem.onTap?.call();

    Navigator.pop(context, _DropdownRouteResult<T>(dropdownMenuItem.value));
  }

  static const Map<ShortcutActivator, Intent> _webShortcuts = <ShortcutActivator, Intent>{
    SingleActivator(LogicalKeyboardKey.arrowDown): DirectionalFocusIntent(TraversalDirection.down),
    SingleActivator(LogicalKeyboardKey.arrowUp): DirectionalFocusIntent(TraversalDirection.up),
  };

  @override
  Widget build(BuildContext context) {
    final DropdownMenuItem<T> dropdownMenuItem = widget.route.items[widget.itemIndex].item!;
    final CurvedAnimation opacity;
    final double unit = 0.5 / (widget.route.items.length + 1.5);
    if (widget.itemIndex == widget.route.selectedIndex) {
      opacity = CurvedAnimation(parent: widget.route.animation!, curve: const Threshold(0.0));
    } else {
      final double start = (0.5 + (widget.itemIndex + 1) * unit).clamp(0.0, 1.0);
      final double end = (start + 1.5 * unit).clamp(0.0, 1.0);
      opacity = CurvedAnimation(parent: widget.route.animation!, curve: Interval(start, end));
    }
    Widget child = Container(
      padding: widget.padding,
      height: widget.customItemsIndexes == null
          ? widget.route.itemHeight
          : widget.customItemsIndexes!.contains(widget.itemIndex)
              ? widget.customItemsHeight ?? _kMenuItemHeight
              : widget.route.itemHeight,
      child: widget.route.items[widget.itemIndex],
    );
    final BorderRadius itemBorderRadius;
    if (widget.route.items.length == 1) {
      itemBorderRadius = widget.borderRadius;
    } else if (widget.itemIndex == 0) {
      itemBorderRadius = BorderRadius.only(topLeft: widget.borderRadius.topLeft, topRight: widget.borderRadius.topRight);
    } else if (widget.itemIndex == widget.route.items.length - 1) {
      itemBorderRadius = BorderRadius.only(bottomLeft: widget.borderRadius.bottomLeft, bottomRight: widget.borderRadius.bottomRight);
    } else {
      itemBorderRadius = BorderRadius.zero;
    }
    // An [InkWell] is added to the item only if it is enabled
    if (dropdownMenuItem.enabled) {
      child = InkWell(
        autofocus: widget.itemIndex == widget.route.selectedIndex,
        enableFeedback: widget.enableFeedback,
        onTap: _handleOnTap,
        onFocusChange: _handleFocusChange,
        borderRadius: itemBorderRadius,
        child: child,
      );
    }
    child = FadeTransition(opacity: opacity, child: child);
    if (kIsWeb && dropdownMenuItem.enabled) {
      child = Shortcuts(
        shortcuts: _webShortcuts,
        child: child,
      );
    }
    return child;
  }
}

class _DropdownMenu<T> extends StatefulWidget {
  const _DropdownMenu({
    Key? key,
    this.padding,
    required this.route,
    required this.buttonRect,
    required this.constraints,
    required this.enableFeedback,
    required this.itemHeight,
    this.dropdownDecoration,
    this.dropdownPadding,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    required this.offset,
    this.customItemsIndexes,
    this.customItemsHeight,
  }) : super(key: key);

  final _DropdownRoute<T> route;
  final EdgeInsets? padding;
  final Rect buttonRect;
  final BoxConstraints constraints;
  final bool enableFeedback;
  final double itemHeight;
  final BoxDecoration? dropdownDecoration;
  final EdgeInsetsGeometry? dropdownPadding;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;
  final List<int>? customItemsIndexes;
  final double? customItemsHeight;

  @override
  _DropdownMenuState<T> createState() => _DropdownMenuState<T>();
}

class _DropdownMenuState<T> extends State<_DropdownMenu<T>> {
  late CurvedAnimation _fadeOpacity;
  late CurvedAnimation _resize;

  @override
  void initState() {
    super.initState();

    _fadeOpacity = CurvedAnimation(
      parent: widget.route.animation!,
      curve: const Interval(0.0, 0.25),
      reverseCurve: const Interval(0.75, 1.0),
    );
    _resize = CurvedAnimation(
      parent: widget.route.animation!,
      curve: const Interval(0.25, 0.5),
      reverseCurve: const Threshold(0.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final _DropdownRoute<T> route = widget.route;
    final List<Widget> children = <Widget>[
      for (int itemIndex = 0; itemIndex < route.items.length; ++itemIndex)
        _DropdownMenuItemButton<T>(
          route: widget.route,
          padding: widget.padding,
          buttonRect: widget.buttonRect,
          constraints: widget.constraints,
          itemIndex: itemIndex,
          enableFeedback: widget.enableFeedback,
          borderRadius: widget.dropdownDecoration?.borderRadius?.resolve(null) ?? BorderRadius.zero,
          customItemsIndexes: widget.customItemsIndexes,
          customItemsHeight: widget.customItemsHeight,
        ),
    ];

    return FadeTransition(
      opacity: _fadeOpacity,
      child: CustomPaint(
        painter: _DropdownMenuPainter(
          color: Theme.of(context).canvasColor,
          elevation: route.elevation,
          selectedIndex: route.selectedIndex,
          resize: _resize,
          getSelectedItemOffset: () => route.getItemOffset(0),
          itemHeight: widget.itemHeight,
          dropdownDecoration: widget.dropdownDecoration,
        ),
        child: Semantics(
          scopesRoute: true,
          namesRoute: true,
          explicitChildNodes: true,
          label: localizations.popupMenuLabel,
          child: Material(
            type: MaterialType.transparency,
            textStyle: route.style,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false,
                overscroll: false,
                physics: const ClampingScrollPhysics(),
                platform: Theme.of(context).platform,
              ),
              child: PrimaryScrollController(
                controller: widget.route.scrollController!,
                child: Scrollbar(
                  radius: widget.scrollbarRadius,
                  thickness: widget.scrollbarThickness,
                  isAlwaysShown: widget.scrollbarAlwaysShow,
                  child: ListView(
                    padding: widget.dropdownPadding ?? kMaterialListPadding,
                    shrinkWrap: true,
                    children: children,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DropdownMenuRouteLayout<T> extends SingleChildLayoutDelegate {
  _DropdownMenuRouteLayout({
    required this.buttonRect,
    required this.route,
    required this.textDirection,
    required this.itemHeight,
    this.itemWidth,
    required this.offset,
  });

  final Rect buttonRect;
  final _DropdownRoute<T> route;
  final TextDirection? textDirection;
  final double itemHeight;
  final double? itemWidth;
  final Offset offset;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = math.max(0.0, constraints.maxHeight - 2 * itemHeight);
    if (route.menuMaxHeight != null && route.menuMaxHeight! <= maxHeight) {
      maxHeight = route.menuMaxHeight!;
    }

    final double width = itemWidth ?? math.min(constraints.maxWidth, buttonRect.width);
    return BoxConstraints(minWidth: width, maxWidth: width, maxHeight: maxHeight);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final _MenuLimits menuLimits =
        route.getMenuLimits(buttonRect, size.height, route.selectedIndex);

    assert(() {
      final Rect container = Offset.zero & size;
      if (container.intersect(buttonRect) == buttonRect) {
        assert(menuLimits.top >= 0.0);
        assert(menuLimits.top + menuLimits.height <= size.height);
      }
      return true;
    }());
    assert(textDirection != null);
    final double left;
    switch (textDirection!) {
      case TextDirection.rtl:
        left = (buttonRect.right + offset.dx).clamp(0.0, size.width) - childSize.width;
        break;
      case TextDirection.ltr:
        left = (buttonRect.left + offset.dx).clamp(0.0, size.width - childSize.width);
        break;
    }

    return Offset(left, menuLimits.top);
  }

  @override
  bool shouldRelayout(_DropdownMenuRouteLayout<T> oldDelegate) {
    return buttonRect != oldDelegate.buttonRect || textDirection != oldDelegate.textDirection;
  }
}

@immutable
class _DropdownRouteResult<T> {
  const _DropdownRouteResult(this.result);

  final T? result;

  @override
  bool operator ==(Object other) {
    return other is _DropdownRouteResult<T> && other.result == result;
  }

  @override
  int get hashCode => result.hashCode;
}

class _MenuLimits {
  const _MenuLimits(this.top, this.bottom, this.height, this.scrollOffset);

  final double top;
  final double bottom;
  final double height;
  final double scrollOffset;
}

class _DropdownRoute<T> extends PopupRoute<_DropdownRouteResult<T>> {
  _DropdownRoute({
    required this.items,
    required this.padding,
    required this.buttonRect,
    required this.selectedIndex,
    this.elevation = 8,
    required this.capturedThemes,
    required this.style,
    this.barrierLabel,
    required this.enableFeedback,
    required this.itemHeight,
    this.itemWidth,
    this.menuMaxHeight,
    this.dropdownDecoration,
    this.dropdownPadding,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    required this.offset,
    required this.showAboveButton,
    this.customItemsIndexes,
    this.customItemsHeight,
  }) : itemHeights = List<double>.filled(items.length, itemHeight);

  final List<_MenuItem<T>> items;
  final EdgeInsetsGeometry padding;
  final Rect buttonRect;
  final int selectedIndex;
  final int elevation;
  final CapturedThemes capturedThemes;
  final TextStyle style;
  final bool enableFeedback;
  final double itemHeight;
  final double? itemWidth;
  final double? menuMaxHeight;
  final BoxDecoration? dropdownDecoration;
  final EdgeInsetsGeometry? dropdownPadding;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;
  final bool showAboveButton;
  final List<int>? customItemsIndexes;
  final double? customItemsHeight;

  final List<double> itemHeights;
  ScrollController? scrollController;

  @override
  Duration get transitionDuration => _kDropdownMenuDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Color? get barrierColor => null;

  @override
  final String? barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return _DropdownRoutePage<T>(
          route: this,
          constraints: constraints,
          items: items,
          padding: padding,
          buttonRect: buttonRect,
          selectedIndex: selectedIndex,
          elevation: elevation,
          capturedThemes: capturedThemes,
          style: style,
          enableFeedback: enableFeedback,
          dropdownDecoration: dropdownDecoration,
          dropdownPadding: dropdownPadding,
          menuMaxHeight: menuMaxHeight,
          itemHeight: itemHeight,
          itemWidth: itemWidth,
          scrollbarRadius: scrollbarRadius,
          scrollbarThickness: scrollbarThickness,
          scrollbarAlwaysShow: scrollbarAlwaysShow,
          offset: offset,
          customItemsIndexes: customItemsIndexes,
          customItemsHeight: customItemsHeight,
        );
      },
    );
  }

  void _dismiss() {
    if (isActive) {
      navigator?.removeRoute(this);
    }
  }

  double getItemOffset(int index) {
    double offset = kMaterialListPadding.top;
    if (items.isNotEmpty && index > 0) {
      assert(items.length == itemHeights.length);
      offset += itemHeights.sublist(0, index).reduce((double total, double height) => total + height);
    }
    return offset;
  }


  _MenuLimits getMenuLimits(Rect buttonRect, double availableHeight, int index) {
    double computedMaxHeight = availableHeight - 2.0 * itemHeight;
    if (menuMaxHeight != null) {
      computedMaxHeight = math.min(computedMaxHeight, menuMaxHeight!);
    }
    final double buttonTop = buttonRect.top;
    final double buttonBottom = math.min(buttonRect.bottom, availableHeight);
    final double selectedItemOffset = getItemOffset(index);


    final double topLimit = math.min(itemHeight, buttonTop);
    final double bottomLimit = math.max(availableHeight, buttonBottom);
    double menuTop = showAboveButton ? buttonTop - offset.dy : buttonBottom - offset.dy;
    double preferredMenuHeight = dropdownPadding != null ? dropdownPadding!.vertical : kMaterialListPadding.vertical;
    if (items.isNotEmpty) {
      preferredMenuHeight += itemHeights.reduce((double total, double height) => total + height);
    }


    final double menuHeight = math.min(computedMaxHeight, preferredMenuHeight);
    double menuBottom = menuTop + menuHeight;

    if (menuTop < topLimit) {
      menuTop = math.min(buttonTop, topLimit);
      menuBottom = menuTop + menuHeight;
    }

    if (menuBottom > bottomLimit) {
      menuBottom = math.max(buttonBottom, bottomLimit);
      menuTop = menuBottom - menuHeight;
    }

    if (menuBottom - itemHeights[selectedIndex] / 2.0 < buttonBottom - buttonRect.height / 2.0) {
      menuBottom = math.max(buttonBottom, bottomLimit);
      menuTop = menuBottom - menuHeight;
    }

    double scrollOffset = 0;

    if (preferredMenuHeight > computedMaxHeight) {
      scrollOffset = math.max(0.0, selectedItemOffset - (menuHeight / 2) + (itemHeights[selectedIndex] / 2));

      scrollOffset = math.min(scrollOffset, preferredMenuHeight - menuHeight);
    }

    assert((menuBottom - menuTop - menuHeight).abs() < precisionErrorTolerance);
    return _MenuLimits(menuTop, menuBottom, menuHeight, scrollOffset);
  }
}

class _DropdownRoutePage<T> extends StatelessWidget {
  const _DropdownRoutePage({
    Key? key,
    required this.route,
    required this.constraints,
    this.items,
    required this.padding,
    required this.buttonRect,
    required this.selectedIndex,
    this.elevation = 8,
    required this.capturedThemes,
    this.style,
    required this.enableFeedback,
    this.dropdownDecoration,
    this.dropdownPadding,
    this.menuMaxHeight,
    required this.itemHeight,
    this.itemWidth,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    required this.offset,
    this.customItemsIndexes,
    this.customItemsHeight,
  }) : super(key: key);

  final _DropdownRoute<T> route;
  final BoxConstraints constraints;
  final List<_MenuItem<T>>? items;
  final EdgeInsetsGeometry padding;
  final Rect buttonRect;
  final int selectedIndex;
  final int elevation;
  final CapturedThemes capturedThemes;
  final TextStyle? style;
  final bool enableFeedback;
  final BoxDecoration? dropdownDecoration;
  final EdgeInsetsGeometry? dropdownPadding;
  final double? menuMaxHeight;
  final double itemHeight;
  final double? itemWidth;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;
  final List<int>? customItemsIndexes;
  final double? customItemsHeight;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));


    if (route.scrollController == null) {
      final _MenuLimits menuLimits = route.getMenuLimits(buttonRect, constraints.maxHeight, selectedIndex);
      route.scrollController = ScrollController(initialScrollOffset: menuLimits.scrollOffset);
    }

    final TextDirection? textDirection = Directionality.maybeOf(context);
    final Widget menu = _DropdownMenu<T>(
      route: route,
      padding: padding.resolve(textDirection),
      buttonRect: buttonRect,
      constraints: constraints,
      enableFeedback: enableFeedback,
      itemHeight: itemHeight,
      dropdownDecoration: dropdownDecoration,
      dropdownPadding: dropdownPadding,
      scrollbarRadius: scrollbarRadius,
      scrollbarThickness: scrollbarThickness,
      scrollbarAlwaysShow: scrollbarAlwaysShow,
      offset: offset,
      customItemsIndexes: customItemsIndexes,
      customItemsHeight: customItemsHeight,
    );

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return CustomSingleChildLayout(
            delegate: _DropdownMenuRouteLayout<T>(
              buttonRect: buttonRect,
              route: route,
              textDirection: textDirection,
              itemHeight: itemHeight,
              itemWidth: itemWidth,
              offset: offset),
            child: capturedThemes.wrap(menu),
          );
        },
      ),
    );
  }
}

class _MenuItem<T> extends SingleChildRenderObjectWidget {
  const _MenuItem({
    Key? key,
    required this.onLayout,
    required this.item,
  }) : super(key: key, child: item);

  final ValueChanged<Size> onLayout;
  final DropdownMenuItem<T>? item;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderMenuItem(onLayout);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _RenderMenuItem renderObject) {
    renderObject.onLayout = onLayout;
  }
}

class _RenderMenuItem extends RenderProxyBox {
  _RenderMenuItem(this.onLayout, [RenderBox? child]) : super(child);

  ValueChanged<Size> onLayout;

  @override
  void performLayout() {
    super.performLayout();
    onLayout(size);
  }
}

class _DropdownMenuItemContainer extends StatelessWidget {
  const _DropdownMenuItemContainer({
    Key? key,
    this.alignment = AlignmentDirectional.centerStart,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: _kMenuItemHeight),
      alignment: alignment,
      child: child,
    );
  }
}

class DropdownButton2<T> extends StatefulWidget {
  DropdownButton2({
    Key? key,
    required this.items,
    this.selectedItemBuilder,
    this.value,
    this.hint,
    this.disabledHint,
    this.onChanged,
    this.onTap,
    this.dropdownElevation = 8,
    this.style,
    this.underline,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24.0,
    this.isDense = false,
    this.isExpanded = false,
    this.itemHeight = kMinInteractiveDimension,
    this.focusColor,
    this.focusNode,
    this.autofocus = false,
    this.dropdownMaxHeight,
    this.enableFeedback,
    this.alignment = AlignmentDirectional.centerStart,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.itemWidth,
    this.itemPadding,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset,
    this.dropdownOverButton = false,
    this.customButton,
    this.customItemsIndexes,
    this.customItemsHeight,
    this.openWithLongPress = false,
    this.validator

  })  : assert(
          items == null ||
              items.isEmpty ||
              value == null ||
              items.where((DropdownMenuItem<T> item) {
                    return item.value == value;
                  }).length ==
                  1,
          "There should be exactly one item with [DropdownButton]'s value: "
          '$value. \n'
          'Either zero or 2 or more [DropdownMenuItem]s were detected '
          'with the same value',
        ),
        super(key: key);


  final double? buttonHeight;
  final double? buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final double? itemWidth;
  final EdgeInsetsGeometry? itemPadding;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset? offset;
  final bool dropdownOverButton;
  final Widget? customButton;
  final List<int>? customItemsIndexes;
  final double? customItemsHeight;
  final bool openWithLongPress;
  FormFieldValidator<String>? validator;


  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final Widget? hint;
  final Widget? disabledHint;
  final ValueChanged<T?>? onChanged;
  final VoidCallback? onTap;
  final DropdownButtonBuilder? selectedItemBuilder;
  final int dropdownElevation;
  final TextStyle? style;
  final Widget? underline;
  final Widget? icon;
  final Color? iconDisabledColor;
  final Color? iconEnabledColor;
  final double iconSize;
  final bool isDense;
  final bool isExpanded;
  final double itemHeight;
  final Color? focusColor;
  final FocusNode? focusNode;
  final bool autofocus;
  final double? dropdownMaxHeight;
  final bool? enableFeedback;
  final AlignmentGeometry alignment;

  @override
  State<DropdownButton2<T>> createState() => _DropdownButton2State<T>();
}

class _DropdownButton2State<T> extends State<DropdownButton2<T>>
    with WidgetsBindingObserver {
  int? _selectedIndex;
  _DropdownRoute<T>? _dropdownRoute;
  Orientation? _lastOrientation;
  FocusNode? _internalNode;

  FocusNode? get focusNode => widget.focusNode ?? _internalNode;
  bool _hasPrimaryFocus = false;
  late Map<Type, Action<Intent>> _actionMap;
  late FocusHighlightMode _focusHighlightMode;

  // Only used if needed to create _internalNode.
  FocusNode _createFocusNode() {
    return FocusNode(debugLabel: '${widget.runtimeType}');
  }

  @override
  void initState() {
    super.initState();
    _updateSelectedIndex();
    if (widget.focusNode == null) {
      _internalNode ??= _createFocusNode();
    }
    _actionMap = <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: (ActivateIntent intent) => _handleTap(),
      ),
      ButtonActivateIntent: CallbackAction<ButtonActivateIntent>(
        onInvoke: (ButtonActivateIntent intent) => _handleTap(),
      ),
    };
    focusNode!.addListener(_handleFocusChanged);
    final FocusManager focusManager = WidgetsBinding.instance!.focusManager;
    _focusHighlightMode = focusManager.highlightMode;
    focusManager.addHighlightModeListener(_handleFocusHighlightModeChange);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _removeDropdownRoute();
    WidgetsBinding.instance!.focusManager
        .removeHighlightModeListener(_handleFocusHighlightModeChange);
    focusNode!.removeListener(_handleFocusChanged);
    _internalNode?.dispose();
    super.dispose();
  }

  void _removeDropdownRoute() {
    _dropdownRoute?._dismiss();
    _dropdownRoute = null;
    _lastOrientation = null;
  }

  void _handleFocusChanged() {
    if (_hasPrimaryFocus != focusNode!.hasPrimaryFocus) {
      setState(() {
        _hasPrimaryFocus = focusNode!.hasPrimaryFocus;
      });
    }
  }

  void _handleFocusHighlightModeChange(FocusHighlightMode mode) {
    if (!mounted) {
      return;
    }
    setState(() {
      _focusHighlightMode = mode;
    });
  }

  @override
  void didUpdateWidget(DropdownButton2<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_handleFocusChanged);
      if (widget.focusNode == null) {
        _internalNode ??= _createFocusNode();
      }
      _hasPrimaryFocus = focusNode!.hasPrimaryFocus;
      focusNode!.addListener(_handleFocusChanged);
    }
    _updateSelectedIndex();
  }

  void _updateSelectedIndex() {
    if (widget.items == null || widget.items!.isEmpty ||
        (widget.value == null && widget.items!.where((DropdownMenuItem<T> item) => item.enabled && item.value == widget.value).isEmpty)) {
      _selectedIndex = null;
      return;
    }

    assert(widget.items!.where((DropdownMenuItem<T> item) => item.value == widget.value).length == 1);
    for (int itemIndex = 0; itemIndex < widget.items!.length; itemIndex++) {
      if (widget.items![itemIndex].value == widget.value) {
        _selectedIndex = itemIndex;
        return;
      }
    }
  }

  TextStyle? get _textStyle => widget.style ?? Theme.of(context).textTheme.subtitle1;

  void _handleTap() {
    final TextDirection? textDirection = Directionality.maybeOf(context);
    const EdgeInsetsGeometry menuMargin = EdgeInsets.zero;

    final List<_MenuItem<T>> menuItems = <_MenuItem<T>>[
      for (int index = 0; index < widget.items!.length; index += 1)
        _MenuItem<T>(
          item: widget.items![index],
          onLayout: (Size size) {
            if (_dropdownRoute == null) return;

            _dropdownRoute!.itemHeights[index] = size.height;
          },
        ),
    ];

    final NavigatorState navigator = Navigator.of(context);
    assert(_dropdownRoute == null);
    final RenderBox itemBox = context.findRenderObject()! as RenderBox;
    final Rect itemRect = itemBox.localToGlobal(Offset.zero, ancestor: navigator.context.findRenderObject()) & itemBox.size;
    _dropdownRoute = _DropdownRoute<T>(
      items: menuItems,
      buttonRect: menuMargin.resolve(textDirection).inflateRect(itemRect),
      padding: widget.itemPadding ?? _kMenuItemPadding.resolve(textDirection),
      selectedIndex: _selectedIndex ?? 0,
      elevation: widget.dropdownElevation,
      capturedThemes: InheritedTheme.capture(from: context, to: navigator.context),
      style: _textStyle!,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      enableFeedback: widget.enableFeedback ?? true,
      itemHeight: widget.itemHeight,
      itemWidth: widget.itemWidth,
      menuMaxHeight: widget.dropdownMaxHeight,
      dropdownDecoration: widget.dropdownDecoration,
      dropdownPadding: widget.dropdownPadding,
      scrollbarRadius: widget.scrollbarRadius,
      scrollbarThickness: widget.scrollbarThickness,
      scrollbarAlwaysShow: widget.scrollbarAlwaysShow,
      offset: widget.offset ?? const Offset(0, 0),
      showAboveButton: widget.dropdownOverButton,
      customItemsIndexes: widget.customItemsIndexes,
      customItemsHeight: widget.customItemsHeight,
    );

    focusNode?.requestFocus();
    navigator.push(_dropdownRoute!).then<void>((_DropdownRouteResult<T>? newValue) {
      _removeDropdownRoute();
      if (!mounted || newValue == null) return;
      widget.onChanged?.call(newValue.result);
    });

    widget.onTap?.call();
  }


  double get _denseButtonHeight {
    final double fontSize = _textStyle!.fontSize ?? Theme.of(context).textTheme.subtitle1!.fontSize!;
    return math.max(fontSize, math.max(widget.iconSize, _kDenseButtonHeight));
  }

  Color get _iconColor {

    if (_enabled) {
      if (widget.iconEnabledColor != null) return widget.iconEnabledColor!;

      switch (Theme.of(context).brightness) {
        case Brightness.light:
          return Colors.grey.shade700;
        case Brightness.dark:
          return Colors.white70;
      }
    } else {
      if (widget.iconDisabledColor != null) return widget.iconDisabledColor!;

      switch (Theme.of(context).brightness) {
        case Brightness.light:
          return Colors.grey.shade400;
        case Brightness.dark:
          return Colors.white10;
      }
    }
  }

  bool get _enabled => widget.items != null && widget.items!.isNotEmpty && widget.onChanged != null;

  Orientation _getOrientation(BuildContext context) {
    Orientation? result = MediaQuery.maybeOf(context)?.orientation;
    if (result == null) {
      // If there's no MediaQuery, then use the window aspect to determine
      // orientation.
      final Size size = window.physicalSize;
      result = size.width > size.height ? Orientation.landscape : Orientation.portrait;
    }
    return result;
  }

  bool get _showHighlight {
    switch (_focusHighlightMode) {
      case FocusHighlightMode.touch:
        return false;
      case FocusHighlightMode.traditional:
        return _hasPrimaryFocus;
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    final Orientation newOrientation = _getOrientation(context);
    _lastOrientation ??= newOrientation;
    if (newOrientation != _lastOrientation) {
      _removeDropdownRoute();
      _lastOrientation = newOrientation;
    }

    // The width of the button and the menu are defined by the widest
    // item and the width of the hint.
    // We should explicitly type the items list to be a list of <Widget>,
    // otherwise, no explicit type adding items maybe trigger a crash/failure
    // when hint and selectedItemBuilder are provided.
    final List<Widget> items = widget.selectedItemBuilder == null
        ? (widget.items != null ? List<Widget>.from(widget.items!) : <Widget>[])
        : List<Widget>.from(widget.selectedItemBuilder!(context));

    int? hintIndex;
    if (widget.hint != null || (!_enabled && widget.disabledHint != null)) {
      Widget displayedHint =
          _enabled ? widget.hint! : widget.disabledHint ?? widget.hint!;
      if (widget.selectedItemBuilder == null) {
        displayedHint = _DropdownMenuItemContainer(
          child: displayedHint,
          alignment: widget.alignment);
      }

      hintIndex = items.length;
      items.add(DefaultTextStyle(
        style: _textStyle!.copyWith(color: Theme.of(context).hintColor),
        child: IgnorePointer(ignoringSemantics: false, child: displayedHint),
      ));
    }

    final EdgeInsetsGeometry padding = ButtonTheme.of(context).alignedDropdown
        ? _kAlignedButtonPadding
        : _kUnalignedButtonPadding;

    // If value is null (then _selectedIndex is null) then we
    // display the hint or nothing at all.
    final Widget innerItemsWidget;
    if (items.isEmpty) {
      innerItemsWidget = Container();
    } else {
      innerItemsWidget = IndexedStack(
        index: _selectedIndex ?? hintIndex,
        alignment: widget.alignment,
        children: widget.isDense
            ? items
            : items.map((Widget item) {
                return SizedBox(height: widget.itemHeight, child: item);
              }).toList(),
      );
    }

    const Icon defaultIcon = Icon(Icons.arrow_drop_down);

    Widget result = DefaultTextStyle(
      style: _enabled
          ? _textStyle!
          : _textStyle!.copyWith(color: Theme.of(context).disabledColor),
      child: widget.customButton ??
          Container(
            decoration: widget.buttonDecoration?.copyWith(
                  color: _showHighlight
                      ? widget.focusColor ?? Theme.of(context).focusColor
                      : widget.buttonDecoration!.color ??
                          Theme.of(context).canvasColor,
                  boxShadow: kElevationToShadow[widget.buttonElevation ?? 0],
                ) ??
                (_showHighlight
                    ? BoxDecoration(
                        color: widget.focusColor ?? Theme.of(context).focusColor,
                        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                      )
                    : null),
            padding: widget.buttonPadding ?? padding.resolve(Directionality.of(context)),
            height: widget.buttonHeight ?? (widget.isDense ? _denseButtonHeight : null),
            width: widget.buttonWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (widget.isExpanded)
                  Expanded(child: innerItemsWidget)
                else
                  innerItemsWidget,
                IconTheme(
                  data: IconThemeData(color: _iconColor, size: widget.iconSize),
                  child: widget.icon ?? defaultIcon,
                ),
              ],
            ),
          ),
    );

    if (!DropdownButtonHideUnderline.at(context)) {
      final double bottom = widget.isDense ? 0.0 : 8.0;
      result = Stack(
        children: <Widget>[
          result,
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: bottom,
            child: widget.underline ??
                Container(
                  height: 1.0,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFBDBDBD),
                        width: 0.0,
                      ),
                    ),
                  ),
                ),
          ),
        ],
      );
    }

    final MouseCursor effectiveMouseCursor = MaterialStateProperty.resolveAs<MouseCursor>(
      MaterialStateMouseCursor.clickable, <MaterialState>{
        if (!_enabled) MaterialState.disabled,
      },
    );

    return Semantics(
      button: true,
      child: Actions(
        actions: _actionMap,
        child: Focus(
          canRequestFocus: _enabled,
          focusNode: focusNode,
          autofocus: widget.autofocus,
          child: MouseRegion(
            cursor: effectiveMouseCursor,
            child: GestureDetector(
              onTap: _enabled && !widget.openWithLongPress ? _handleTap : null,
              onLongPress: _enabled && widget.openWithLongPress ? _handleTap : null,
              behavior: HitTestBehavior.opaque,
              child: result,
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownButtonFormField2<T> extends FormField<T> {
  DropdownButtonFormField2({
    Key? key,
    required List<DropdownMenuItem<T>>? items,
    DropdownButtonBuilder? selectedItemBuilder,
    T? value,
    Widget? hint,
    Widget? disabledHint,
    this.onChanged,
    VoidCallback? onTap,
    int dropdownElevation = 8,
    TextStyle? style,
    Widget? icon,
    Color? iconDisabledColor,
    Color? iconEnabledColor,
    double iconSize = 24.0,
    bool isDense = true,
    bool isExpanded = false,
    double itemHeight = kMinInteractiveDimension,
    Color? focusColor,
    FocusNode? focusNode,
    bool autofocus = false,
    InputDecoration? decoration,
    FormFieldSetter<T>? onSaved,
    FormFieldValidator<T>? validator,
    AutovalidateMode? autovalidateMode,
    double? dropdownMaxHeight,
    bool? enableFeedback,
    AlignmentGeometry alignment = AlignmentDirectional.centerStart,
    double? buttonHeight,
    double? buttonWidth,
    EdgeInsetsGeometry? buttonPadding,
    BoxDecoration? buttonDecoration,
    int? buttonElevation,
    double? itemWidth,
    EdgeInsetsGeometry? itemPadding,
    EdgeInsetsGeometry? dropdownPadding,
    BoxDecoration? dropdownDecoration,
    Radius? scrollbarRadius,
    double? scrollbarThickness,
    bool? scrollbarAlwaysShow,
    Offset? offset,
    bool dropdownOverButton = false,
    Widget? customButton,
    List<int>? customItemsIndexes,
    double? customItemsHeight,
    bool openWithLongPress = false,
  })  : assert(
          items == null ||
              items.isEmpty ||
              value == null ||
              items.where((DropdownMenuItem<T> item) {
                    return item.value == value;
                  }).length ==
                  1,
          "There should be exactly one item with [DropdownButton]'s value: "
          '$value. \n'
          'Either zero or 2 or more [DropdownMenuItem]s were detected '
          'with the same value',
        ),
        decoration = decoration ?? InputDecoration(focusColor: focusColor),
        super(
          key: key,
          onSaved: onSaved,
          initialValue: value,
          validator: validator,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          builder: (FormFieldState<T> field) {
            final _DropdownButtonFormFieldState<T> state = field as _DropdownButtonFormFieldState<T>;
            final InputDecoration decorationArg = decoration ?? InputDecoration(focusColor: focusColor);
            final InputDecoration effectiveDecoration = decorationArg.applyDefaults(Theme.of(field.context).inputDecorationTheme);

            final bool showSelectedItem = items != null && items.where((DropdownMenuItem<T> item) => item.value == state.value).isNotEmpty;
            bool isHintOrDisabledHintAvailable() {
              final bool isDropdownDisabled = onChanged == null || (items == null || items.isEmpty);
              if (isDropdownDisabled) {
                return hint != null || disabledHint != null;
              } else {
                return hint != null;
              }
            }

            final bool isEmpty = !showSelectedItem && !isHintOrDisabledHintAvailable();

            return Focus(
              canRequestFocus: false,
              skipTraversal: true,
              child: Builder(builder: (BuildContext context) {
                return InputDecorator(
                  decoration: effectiveDecoration.copyWith(errorText: field.errorText),
                  isEmpty: isEmpty,
                  isFocused: Focus.of(context).hasFocus,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<T>(
                      items: items,
                      selectedItemBuilder: selectedItemBuilder,
                      value: state.value,
                      hint: hint,
                      disabledHint: disabledHint,
                      onChanged: onChanged == null ? null : state.didChange,
                      onTap: onTap,
                      dropdownElevation: dropdownElevation,
                      style: style,
                      icon: icon,
                      iconDisabledColor: iconDisabledColor,
                      iconEnabledColor: iconEnabledColor,
                      iconSize: iconSize,
                      isDense: isDense,
                      isExpanded: isExpanded,
                      itemHeight: itemHeight,
                      focusColor: focusColor,
                      focusNode: focusNode,
                      autofocus: autofocus,
                      dropdownMaxHeight: dropdownMaxHeight,
                      enableFeedback: enableFeedback,
                      alignment: alignment,
                      buttonHeight: buttonHeight,
                      buttonWidth: buttonWidth,
                      buttonPadding: buttonPadding,
                      buttonDecoration: buttonDecoration,
                      buttonElevation: buttonElevation,
                      itemWidth: itemWidth,
                      itemPadding: itemPadding,
                      dropdownPadding: dropdownPadding,
                      dropdownDecoration: dropdownDecoration,
                      scrollbarRadius: scrollbarRadius,
                      scrollbarThickness: scrollbarThickness,
                      scrollbarAlwaysShow: scrollbarAlwaysShow,
                      offset: offset,
                      dropdownOverButton: dropdownOverButton,
                      customButton: customButton,
                      customItemsIndexes: customItemsIndexes,
                      customItemsHeight: customItemsHeight,
                      openWithLongPress: openWithLongPress,
                    ),
                  ),
                );
              }),
            );
          },
        );

  final ValueChanged<T?>? onChanged;
  final InputDecoration decoration;

  @override
  FormFieldState<T> createState() => _DropdownButtonFormFieldState<T>();
}

class _DropdownButtonFormFieldState<T> extends FormFieldState<T> {
  @override
  DropdownButtonFormField2<T> get widget =>
      super.widget as DropdownButtonFormField2<T>;

  @override
  void didChange(T? value) {
    super.didChange(value);
    assert(widget.onChanged != null);
    widget.onChanged!(value);
  }

  @override
  void didUpdateWidget(DropdownButtonFormField2<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      setValue(widget.initialValue);
    }
  }
}
