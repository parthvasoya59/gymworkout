

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer' as logger;

class Const {


  /// SAVE PREFERENCE KEY ///
  static const prefGender = 'gender';
  static const prefSelectedArea = 'selectedArea';
  static const prefHeight = 'height';
  static const prefWeight = 'weight';

  static const prefEmail = 'email';
  static const prefPass = 'password';
  static const prefFCMToken = 'fcmToken';

  static const prefName = 'name';
  static const prefPhone = 'phone';
  static const prefPhoneCode = 'phonecode';
  static const prefAddress = 'address';
  static const prefRememberMe = 'rememberMe';
  static const prefUserRoleId = 'userroleid';
  static const prefUserId = 'userid';
  static const prefUserRoleName = 'userrolename';
  static const prefUserProfileImage = 'userProfileImage';
  static const prefNotificationRoutesSet = 'prefNotificationRoutesSet';


  static const prefAPIToken = 'apiToken';
  static const prefIsLoggedIn = 'isLogin';

  static const lblSelect = 'Select';
  static const lblGenderMale = 'Male';
  static const lblGenderFemale = 'Female';
  static const lblGenderOther = 'Other';
  static const lblRoleCustomer = 'Customer';
  static const lblRoleDriver = 'Driver';
  static const lblRoleCompany = 'Company';



  static const currySymbol = "₦";
  static const countries = ['NG','GH','UG','ZA','KE','SL','CM','US','CA','GB'];


  /// REGULAR EXPRESSION VALIDATION PATTERN ///
  static const emailPattern =  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const nameWithSpecialCharacterPattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
  static const nameWithNumericPattern = r'[0-9]+';
  static const cardNumber = r'[0-9]';
  static const alfaNumeric = r'^[A-Za-z]{4}\d{7}$';

  /// Toast for default time
  void toast(
      String? value, {
        ToastGravity? gravity,
        length = Toast.LENGTH_SHORT,
        Color? bgColor,
        Color? textColor,
        bool print = false,
      }) {
    if (value!.isEmpty) {
      logger.log(value);
    } else {
      Fluttertoast.showToast(
        msg: value.toString(),
        gravity: gravity,
        toastLength: length,
        backgroundColor: bgColor,
        textColor: textColor,
      );
      if (print) logger.log(value);
    }
  }

}


///App Roles
class UserRoles {
  static const int mr = 1;
  static const int areamanager = 2;
  static const int retailer = 3;
  static const int stocklist = 4;
  static const int hradmin = 5;
}

class Gender {
  static const int male = 0;
  static const int feMale = 1;
  static const int others = 2;
}

class BodyArea {
  static const String fullBody = "Full Body";
  static const String shoulder = "Shoulder";
  static const String back = "Back";
  static const String chest = "Chest";
  static const String abs = "Abs";
  static const String leg = "Legs";
  static const String arms = "Arms";
  static const String butt = "Butt";
}