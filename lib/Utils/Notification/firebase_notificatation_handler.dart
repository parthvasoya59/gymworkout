import 'dart:io';

import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../AppRoute/app_route.dart';
import '../../Utils/Notification/notification_handler.dart';
import '../../main.dart';

class FirebaseNotifications {
  FirebaseMessaging? _messaging;
  BuildContext? myContext;

  void setupFirebase() {
    _messaging = FirebaseMessaging.instance;
    NotificationHandler.initNotification(navigatorKey.currentState!.context);
    firebaseCloudMessageListener(navigatorKey.currentState!.context);
    myContext = navigatorKey.currentState!.context;
  }

  void firebaseCloudMessageListener(BuildContext context)  async {
      NotificationSettings setting = await _messaging!.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true
    );
    _messaging!.getToken().then((token) async{
      debugPrint('firebaseCloudMessageListener => Token : ${token.toString()}');
      _messaging!.subscribeToTopic('flutter_demo').whenComplete(() {
        // debugPrint('subscribe OK');
      }).onError((error, stackTrace) {
        debugPrint('subscribeToTopic error : ${error.toString()}');
      });


      //handle message
      FirebaseMessaging.onMessage.listen((remoteMessage) {
        debugPrint('1. body : ${remoteMessage.notification!.body.toString()}');
        debugPrint('2. title : ${remoteMessage.notification!.title.toString()}');
        debugPrint('3. data : ${remoteMessage.data.toString()}');
        // handleMessage(remoteMessage);
        // debugPrint('4. roomId : ${remoteMessage.data['roomId'].toString()}');
        // debugPrint('titleLocArgs : ${remoteMessage.notification!.titleLocArgs.toString()}');
        // debugPrint('titleLocKey : ${remoteMessage.notification!.titleLocKey.toString()}');
        // debugPrint('bodyLocArgs : ${remoteMessage.notification!.bodyLocArgs.toString()}');
        // debugPrint('bodyLocKey : ${remoteMessage.notification!.bodyLocKey.toString()}');
        // debugPrint('android : ${remoteMessage.notification!.android.toString()}');
        // debugPrint('apple : ${remoteMessage.notification!.apple.toString()}');
        if(Platform.isAndroid) {
          showNotification(remoteMessage.notification!.title,remoteMessage.notification!.body,remoteMessage.data);
        }
        else if(Platform.isIOS) {
          showNotification(remoteMessage.notification!.title,remoteMessage.notification!.body,remoteMessage.data);
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
      // FirebaseMessaging.onBackgroundMessage((message) {
      //   handleMessage(message);
      // });
    });
  }

  void handleMessage(RemoteMessage message) {
    debugPrint('handleMessage =>  message : $message');
    Get.toNamed(AppRoutes.dashboardScreen);;
  }

  static void showNotification(title,body,data) async {
    // debugPrint('title : ${title.toString()} \nbody : ${body.toString()}');
    debugPrint('showNotification title : ${title.toString()}');
    debugPrint('showNotification body : ${body.toString()}');
    debugPrint('showNotification data : ${data.toString()}');
    // debugPrint('showNotification data : ${data['type'].toString()}');
    // debugPrint('showNotification data : ${data['roomId'].toString()}');
    var androidChannel =  AndroidNotificationDetails(
      channel!.id,
      channel!.name,
      channelDescription: channel!.description,
        // autoCancel: true,
        // ongoing: true,
        importance: Importance.max,
        priority: Priority.high,
        // fullScreenIntent: false
    );

    var platform = NotificationDetails(android: androidChannel);
    // var token = sharedPreferences.getString('Token');
    // debugPrint('showNotification => token : $token');
    await NotificationHandler.flutterLocalNotificationPlugin.show(0, title, body, platform,payload: data.toString());
  }

}