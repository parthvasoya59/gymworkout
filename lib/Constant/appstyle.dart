
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors.dart';

double getHorizontalSize(double px) {
  return px * ((MediaQuery.of(Get.context!).size.width) / 375);
}

double getFontSize(double px) {
  return px * ((MediaQuery.of(Get.context!).size.width) / 375);
}

double getVerticalSize(double px) {
  return px * ((MediaQuery.of(Get.context!).size.height) / 890);
}


const familyLatoBlack = 'Lato-Black';
const familyLatoBlackItalic = 'Lato-BlackItalic';
const familyLatoBold= 'NotoSans-Bold';
const familyLatoBoldItalic = 'NotoSans-BoldItalic';
const familyLatoItalic = 'NotoSans-Italic';
const familyLatoLight = 'Lato-Light';
const familyLatoLightItalic = 'Lato-LightItalic';
const familyLatoMedium= 'NotoSans-Regular';
const familyLatoMediumItalic = 'Lato-MediumItalic';
const familyLatoRegular = 'Lato-Regular';
const familyLatoThin = 'Lato-Thin';
const familyLatoThinItalic = 'Lato-ThinItalic';

class AppStyle {

  /// DEFINE FONT FAMILY
  static TextStyle textStyleFamilyLatoBlack = const TextStyle(fontFamily: familyLatoBlack);
  static TextStyle textStyleFamilyLatoBlackItalic = const TextStyle(fontFamily: familyLatoBlackItalic);
  static TextStyle textStyleFamilyLatoBold = const TextStyle(fontFamily: familyLatoBold);
  static TextStyle textStyleFamilyLatoBoldItalic = const TextStyle(fontFamily: familyLatoBoldItalic);
  static TextStyle textStyleFamilyLatoItalic = const TextStyle(fontFamily: familyLatoItalic);
  static TextStyle textStyleFamilyLatoLight = const TextStyle(fontFamily: familyLatoLight);
  static TextStyle textStyleFamilyLatoLightItalic = const TextStyle(fontFamily: familyLatoLightItalic);
  static TextStyle textStyleFamilyLatoMedium = const TextStyle(fontFamily: familyLatoMedium);
  static TextStyle textStyleFamilyLatoMediumItalic = const TextStyle(fontFamily: familyLatoMediumItalic);
  static TextStyle textStyleFamilyLatoRegular = const TextStyle(fontFamily: familyLatoRegular);
  static TextStyle textStyleFamilyLatoThin = const TextStyle(fontFamily: familyLatoThin);
  static TextStyle textStyleFamilyLatoThinItalic = const TextStyle(fontFamily: familyLatoThinItalic);


  /// DEFINE FONT COLOR AND FONT SIZE
  static TextStyle textStyleLatoMedium25 = textStyleFamilyLatoMedium.copyWith(fontSize: getFontSize(25),color: cBlack);
  static TextStyle textStyleLatoBold15 = textStyleFamilyLatoBold.copyWith(fontSize: getFontSize(15),color: cBlack);
  static TextStyle textStyleLatoLight35 = textStyleFamilyLatoLight.copyWith(fontSize: getFontSize(35),color: cBlack);
  static TextStyle textStyleLatoBold35 = textStyleFamilyLatoBold.copyWith(fontSize: getFontSize(35),color: cBlack);
  static TextStyle textStyleLatoBoldWhite20 = textStyleFamilyLatoBold.copyWith(fontSize: getFontSize(20),color: cWhite);
  static TextStyle textStyleLatoBoldWhite18 = textStyleFamilyLatoBold.copyWith(fontSize: getFontSize(18),color: cWhite);
  static TextStyle textStyleLatoBoldWhite25 = textStyleFamilyLatoBold.copyWith(fontSize: getFontSize(25),color: cWhite);
  static TextStyle textStyleLatoBoldWhite30 = textStyleFamilyLatoBold.copyWith(fontSize: getFontSize(30),color: cWhite);
  static TextStyle textStyleLatoBoldWhite35 = textStyleFamilyLatoBold.copyWith(fontSize: getFontSize(35),color: cWhite);
  static TextStyle textStyleLatoBoldWhite60 = textStyleFamilyLatoBold.copyWith(fontSize: getFontSize(60),color: cWhite);
  static TextStyle textStyleLatoBoldBlack18 = textStyleFamilyLatoBold.copyWith(fontSize: getFontSize(18),color: cBlack);
  static TextStyle textStyleLatoBoldBlack20 = textStyleFamilyLatoBold.copyWith(fontSize: getFontSize(20),color: cBlack);
  static TextStyle textStyleLatoBoldBlack25 = textStyleFamilyLatoBold.copyWith(fontSize: getFontSize(25),color: cBlack);
  static TextStyle textStyleLatoBoldBlack30 = textStyleFamilyLatoBold.copyWith(fontSize: getFontSize(30),color: cBlack);
  static TextStyle textStyleLatoBoldGrey20 = textStyleFamilyLatoBold.copyWith(fontSize: getFontSize(20),color: cGrey);

  static TextStyle textStyleLatoMediumBlack15 = textStyleFamilyLatoMedium.copyWith(fontSize: getFontSize(15),color: cBlack);
  static TextStyle textStyleLatoMediumBlack20 = textStyleFamilyLatoMedium.copyWith(fontSize: getFontSize(20),color: cBlack);
  static TextStyle textStyleLatoMediumBlack35 = textStyleFamilyLatoMedium.copyWith(fontSize: getFontSize(35),color: cBlack);
  static TextStyle textStyleLatoLightBlack35 = textStyleFamilyLatoLight.copyWith(fontSize: getFontSize(35),color: cBlack);
  static TextStyle textStyleLatoMediumWhite15 = textStyleFamilyLatoMedium.copyWith(fontSize: getFontSize(15),color: cWhite);
  static TextStyle textStyleLatoMediumWhite18 = textStyleFamilyLatoMedium.copyWith(fontSize: getFontSize(18),color: cWhite);
  static TextStyle textStyleLatoMediumWhite20 = textStyleFamilyLatoMedium.copyWith(fontSize: getFontSize(20),color: cWhite);
  static TextStyle textStyleLatoMediumWhite25 = textStyleFamilyLatoMedium.copyWith(fontSize: getFontSize(25),color: cWhite);

  static TextStyle textStyleLatoMediumGrey20 = textStyleFamilyLatoMedium.copyWith(fontSize: getFontSize(20),color: cGrey);
  static TextStyle textStyleLatoMediumGrey25 = textStyleFamilyLatoMedium.copyWith(fontSize: getFontSize(25),color: cGrey);

}