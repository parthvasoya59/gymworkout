
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Constant/appstyle.dart';
import '../../Constant/colors.dart';


class TextInputFindOut extends StatelessWidget {
  TextInputFindOut({this.label, this.iconData, this.textInputType,this.onChange,this.controller, this.validator,
    this.inputFormatters,this.floatingLabelBehavior,
    this.enbleBorderColor,
    this.textInputAction,this.fillColor,
    this.obsecureCVV,this.obscuringCharacter = '•',
    this.onSaved,
    this.style,
    this.labelStyle,
    this.maxLines,this.alignLabelWithHint
  });
  String? label;
  IconData? iconData;
  TextInputType? textInputType;
  FloatingLabelBehavior? floatingLabelBehavior;
  var enbleBorderColor;
  var onChange;
  var controller;
  var fillColor;
  var obsecureCVV;
  late String obscuringCharacter;
  var onSaved;
  TextStyle? style,labelStyle;
  int? maxLines;
  bool? alignLabelWithHint;


  FormFieldValidator<String>? validator; TextInputAction? textInputAction;
  List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;


    var w = MediaQuery.of(context).size.width;
    final isPassword = textInputType == TextInputType.visiblePassword;
    final outlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: enbleBorderColor ?? cDarkGreyBorder, width: 2));
    final hidePasswordNotifier = ValueNotifier(true);
    return ValueListenableBuilder(
      valueListenable: hidePasswordNotifier,
      builder: (context, dynamic value, child) {
        return TextFormField(
          controller: controller,
          validator: validator,
          // maxLines: 1,
          // cursorHeight: h * 0.03,
          inputFormatters: inputFormatters,
          obscuringCharacter: obscuringCharacter,
          // textAlignVertical: TextAlignVertical.center,

          keyboardType: textInputType,
          obscureText: obsecureCVV ?? isPassword ? value : false,
          style: style ?? AppStyle.textStyleLatoMediumGrey20,
          onChanged: onChange,
          textInputAction: textInputAction ?? TextInputAction.next,
          // onSaved: onSaved,
          onFieldSubmitted: onSaved,
          // textAlign: TextAlign.center,
          maxLines: maxLines ?? 1,
          // textAlign: TextAlign.left,
          // textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            filled: true,
            // isDense: true,
            // isCollapsed: true,
            alignLabelWithHint: alignLabelWithHint,
            errorMaxLines: 2,


            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            errorStyle: AppStyle.textStyleLatoMediumWhite11,
            contentPadding: EdgeInsets.only(top: h * 0.02,left: w * 0.04,right: w * 0.04),
            fillColor: fillColor ?? cWhite,
            suffixIcon: isPassword
                ? IconButton(
                onPressed: () => hidePasswordNotifier.value = !hidePasswordNotifier.value,
                icon: Icon(
                  value ? Icons.visibility : Icons.visibility_off,
                  color: cWhite,))
                : null,
            enabledBorder: outlineInputBorder,
            floatingLabelBehavior: floatingLabelBehavior,
            hintText: label,

            // labelText: applyLabel! == false ? "" : label,
            labelText: label,

            labelStyle: labelStyle ?? AppStyle.textStyleLatoMediumWhite15,
            // focusedBorder: outlineInputBorder.copyWith(borderSide: BorderSide(color: cGrey, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: cWhite)),
            hintStyle:  AppStyle.textStyleLatoMediumGrey15,
            // prefixIcon: iconData != null ? Icon(iconData, color: cGrey, size: 23) : SizedBox(),
          ),
        );
      },
    );
  }
}

//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:package_delivery/Constant/appstyle.dart';
// import 'package:package_delivery/Constant/colors.dart';
//
//
// class TextInputFindOut extends StatelessWidget {
//    TextInputFindOut({this.label, this.iconData, this.textInputType,this.onChange,this.controller, this.validator,
//      this.inputFormatters,this.floatingLabelBehavior,
//      this.enbleBorderColor,
//      this.textInputAction,this.fillColor,
//     this.obsecureCVV,this.obscuringCharacter = '•'
//    });
//    String? label;
//    IconData? iconData;
//    TextInputType? textInputType;
//    FloatingLabelBehavior? floatingLabelBehavior;
//    var enbleBorderColor;
//    var onChange;
//    var controller;
//    var fillColor;
//    var obsecureCVV;
//    late String obscuringCharacter;
//
//
//    FormFieldValidator<String>? validator; TextInputAction? textInputAction;
//    List<TextInputFormatter>? inputFormatters;
//
//   @override
//   Widget build(BuildContext context) {
//     var h = MediaQuery.of(context).size.height;
//
//
//     var w = MediaQuery.of(context).size.width;
//     final isPassword = textInputType == TextInputType.visiblePassword;
//     final outlineInputBorder = OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12),
//       borderSide: BorderSide(color: enbleBorderColor ?? cGrey, width: 2));
//     final hidePasswordNotifier = ValueNotifier(true);
//     return ValueListenableBuilder(
//       valueListenable: hidePasswordNotifier,
//       builder: (context, dynamic value, child) {
//         return TextFormField(
//           controller: controller,
//           validator: validator,
//           // maxLines: 1,
//           // cursorHeight: h * 0.03,
//           inputFormatters: inputFormatters,
//           obscuringCharacter: obscuringCharacter,
//           // textAlignVertical: TextAlignVertical.center,
//
//           keyboardType: textInputType,
//           obscureText: obsecureCVV ?? isPassword ? value : false,
//           style: AppStyle.textStyleRobotoMediumBlack15,
//           onChanged: onChange,
//           textInputAction: textInputAction ?? TextInputAction.next,
//
//           // textAlign: TextAlign.center,
//           decoration: InputDecoration(
//             filled: true,
//             // isDense: true,
//             // isCollapsed: true,
//             errorMaxLines: 2,
//
//             errorBorder: InputBorder.none,
//             focusedErrorBorder: InputBorder.none,
//             errorStyle: AppStyle.textStyleRobotoRegular11,
//             contentPadding: EdgeInsets.only(top: h * 0.02,left: w * 0.04,right: w * 0.04),
//             fillColor: fillColor ?? cWhite,
//             suffixIcon: isPassword
//                 ? IconButton(
//                   onPressed: () => hidePasswordNotifier.value = !hidePasswordNotifier.value,
//                   icon: Icon(
//                      value ? Icons.visibility : Icons.visibility_off,
//                      color: cGrey,))
//                : null,


//             enabledBorder: outlineInputBorder,
//             floatingLabelBehavior: floatingLabelBehavior,
//             hintText: label,
//             labelText: label,
//             labelStyle: AppStyle.textStyleRobotoMediumGrey15,
//             // focusedBorder: outlineInputBorder.copyWith(borderSide: BorderSide(color: cGrey, width: 2)),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.0),
//               borderSide: BorderSide(color: cBlack)),
//             hintStyle: AppStyle.textStyleRobotoMediumGrey15,
//             // prefixIcon: iconData != null ? Icon(iconData, color: cGrey, size: 23) : SizedBox(),
//           ),
//         );
//       },
//     );
//   }
// }
