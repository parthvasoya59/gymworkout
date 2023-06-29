import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gymworkout/Constant/app_constant.dart';
import 'package:gymworkout/Utils/preference.dart';
import '../AppRoute/app_route.dart';
import '../../Utils/Notification/firebase_notificatation_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

bool isDashboard = false;
Future getRedirect() async {
  // we check is goal selected or not based on that we redirect, because it's last screen for user form
  int t = await Preference().readInt(Const.prefGoalIndex) ?? 10;
  debugPrint("getRedirect ==> t : ${t}");

  if(t != 10){
    isDashboard = true;
  }else{
    isDashboard = false;
  }
  debugPrint("getRedirect ==> isDashboard : ${isDashboard}");
}


FirebaseNotifications firebaseNotifications = FirebaseNotifications();
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
AndroidNotificationChannel? channel;

Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    firebaseNotifications.setupFirebase();
  });

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin!.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel!);
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: false, sound: true);
  }


  // //Crashlytics
  // FlutterError.onError = (errorDetails) {
  //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  // };
  // // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  await getRedirect();

  runApp(const MyApp());
}

var navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

// changeScreen(){
//   isDashboard = isDashboard;
//   if(isDashboard){
//     debugPrint("changeScreen");
//     Get.offAllNamed(AppRoutes.dashboardScreen);
//   }
// }

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRedirect();
  }

  @override
  Widget build(BuildContext context) {
    // changeScreen();
    // setState(() {
    //
    // });
    return GetMaterialApp(
        title: 'Gym Workout',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        getPages: AppRoutes.pages,
        initialRoute: isDashboard ?  AppRoutes.dashboardScreen : AppRoutes.genderSelScreen
    );
  }
}
