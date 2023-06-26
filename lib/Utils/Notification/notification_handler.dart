
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../AppRoute/app_route.dart';

class NotificationHandler {
  static final flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();

  static BuildContext? myContext;

  static void initNotification(BuildContext context) async {
    myContext = context;
    debugPrint("NotificationHandler ----> initNotification");
    var initAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initSetting = InitializationSettings(android: initAndroid,);
    await flutterLocalNotificationPlugin.initialize(initSetting,onDidReceiveBackgroundNotificationResponse: onDidReceiveNotificationResponse, onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }


  static void onDidReceiveNotificationResponse(NotificationResponse notificationResponse)  async {
    final String? payload = notificationResponse.payload;
    debugPrint('payload : ${payload.toString()}');
    if(payload != null) {
      debugPrint('onSelectNotification payload : ${payload.toString()}');
      try {
        Get.toNamed(AppRoutes.dashboardScreen);
      } catch (e) { 
        debugPrint('onSelectNotification => ERROR : $e');
      }
    }
  }

  static Future onDidReceiveLocalNotification(int? id,String? title, String? body, String? payload) async {
    debugPrint('onDidReceiveLocalNotification => id : $id');
    debugPrint('onDidReceiveLocalNotification => title : $title');
    debugPrint('onDidReceiveLocalNotification => body : $body');
    debugPrint('onDidReceiveLocalNotification => payload : $payload');
  }

}
