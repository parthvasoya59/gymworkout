
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Constant/appstyle.dart';
import '../../Constant/colors.dart';
import '../../widget/customDropDown/dropdown_button2.dart';

import 'customDropDown/dropdown_button2.dart';

class CustomDropDownWidget<T> extends StatefulWidget {
  String? hintText;
  var onChanged;
  RxList<String>? items;
  var selectedValue;
  var onTap;
  dynamic showBorder;

  FormFieldValidator<T>? validator;
  // var validator;
  CustomDropDownWidget(
      {Key? key, this.hintText, this.onChanged,
        this.items, this.selectedValue,this.onTap,
        this.showBorder,this.validator,
        // this.contentPadding
      })
      : super(key: key);

  @override
  _CustomDropDownWidgetState createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    var w = MediaQuery.of(context).size.width;
    return Obx(() {
      return DropdownButtonFormField2(
        isExpanded: true,//text overflow error solved
        isDense: false,
        validator: widget.validator,
        alignment: Alignment.center,

        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: h * 0.001,left: w * 0.04,right: w * 0.04),
          filled: true,
          isDense: true,
          // enabledBorder: InputBorder,
          fillColor: cWhite,// vpnBlueOpacity,
          errorMaxLines: 2,

          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: widget.showBorder == true ? cWhite : cBlack)),

          disabledBorder: InputBorder.none,

          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: widget.showBorder == true ? cWhite : cBlack)),

          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          errorStyle: AppStyle.textStyleFamilyLatoRegular,
          counterText: "",
        ),

        icon: const Icon(Icons.keyboard_arrow_down),
        iconSize: 20,
        iconDisabledColor: cGrey,
        iconEnabledColor: cGreen,
        onTap: widget.onTap,
        value: widget.selectedValue ,//?? selectedValue,
        onChanged: widget.onChanged,
        dropdownElevation: 1,
        items: widget.items?.map((String value) {
          return DropdownMenuItem<RxString>(
              value: value.obs,
              child: Text(value,
                  style: value == widget.hintText ? AppStyle.textStyleLatoMediumWhite15 : AppStyle.textStyleLatoMediumBlack15, overflow: TextOverflow.ellipsis));
        }).toList(),
      );
    });
  }
}
