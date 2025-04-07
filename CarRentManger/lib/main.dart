// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:carrentmanger/Services/notification.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Utils/localization_services.dart';
import 'Utils/memory.dart';
import 'Utils/transelation/app_transelation.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:carrentmanger/UI/Splash_Screen.dart';
import 'package:carrentmanger/Utils/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:firebase_analytics/observer.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  var type = message.data["page"];
  var typeId = message.data["page_id"];
  await Get.find<StorageService>().saveNotificationPage(
      "${type ?? 0}");
  await Get.find<StorageService>().saveNotificationPageId(
      "${typeId ?? 0}");



}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => StorageService.init(), permanent: true);
  Get.put(LocalizationService.init(), permanent: true);
  await PushNotificationService().setupInteractedMessage();
  FirebaseMessaging.instance.requestPermission();
  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  }
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: kDarkGreenColor, // navigation bar color
    statusBarColor: kWhiteColor, // status bar color
  ));
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF66A5B4), // navigation bar color
    statusBarColor: Color(0xFF66A5B4), // status bar color
  ));
  runApp(const MyApp());
}



class MyApp extends StatefulWidget {

  const MyApp({super.key,});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      var type = message.data["page"];
      var typeId = message.data["page_id"];
      await Get.find<StorageService>().saveNotificationPage(
          "${type ?? 0}");
      await Get.find<StorageService>().saveNotificationPageId(
          "${typeId ?? 0}");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      var type = message.data["page"];
      var typeId = message.data["page_id"];
      await Get.find<StorageService>().saveNotificationPage(
          "${type ?? 0}");
      await Get.find<StorageService>().saveNotificationPageId(
          "${typeId ?? 0}");
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      translations: AppTranslations(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          systemOverlayStyle: SystemUiOverlayStyle( //<-- SEE HERE
            statusBarColor:  kDarkGreenColor,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
      ),

      locale:  Get.find<LocalizationService>().activeLocale,
      supportedLocales: SupportedLocales.all,
      fallbackLocale: SupportedLocales.english,
      localizationsDelegates:  const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),

    );
  }
}

