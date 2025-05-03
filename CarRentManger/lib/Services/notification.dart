

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';




class PushNotificationService {
  Future<void> setupInteractedMessage() async {
    await Firebase.initializeApp();

    // ✅ اطلب الإذن بشكل سليم
    final settings = await FirebaseMessaging.instance.requestPermission();
    print('User granted permission: ${settings.authorizationStatus}');

    // ✅ تعامل مع الحالة اللي التطبيق كان مقفول وفتح من الإشعار
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      var type = initialMessage.data["page"];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("route", type);
    }

    // ✅ تعامل مع حالة onMessageOpenedApp
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      var type = message.data["page"];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("route", type);
    });

    await enableIOSNotifications();
    await registerNotificationListeners();
  }

  registerNotificationListeners() async {
    AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    var androidSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSSettings = const DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    var initSetttings = InitializationSettings(android: androidSettings, iOS: iOSSettings);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
      onDidReceiveNotificationResponse: (message) async {
        notificationSelectingAction(message);
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      RemoteNotification? notification = message!.notification;
      AndroidNotification? android = message.notification?.android;
      var type = message.data["page"];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("route", type);

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: android.smallIcon,
              playSound: true,
            ),
          ),
        );
      }
    });
  }

  enableIOSNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<void> notificationSelectingAction(message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userType = prefs.getString("type");
    print('${userType ?? ""} userType');

    String? screenType = prefs.getString("route");
    print('${screenType ?? ""} screenType');
  }

  androidNotificationChannel() => const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.max,
  );
}