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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:carrentmanger/UI/Splash_Screen.dart';
import 'package:carrentmanger/Utils/colors.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:firebase_analytics/observer.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  var type = message.data["page"];
  var typeId = message.data["page_id"];
  await Get.find<StorageService>().saveNotificationPage("${type ?? 0}");
  await Get.find<StorageService>().saveNotificationPageId("${typeId ?? 0}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Get.putAsync(() => StorageService.init(), permanent: true);
  Get.put(LocalizationService.init(), permanent: true);
  await PushNotificationService().setupInteractedMessage();

  FirebaseMessaging.instance.requestPermission();
  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  // ✅ إعداد ألوان الـ StatusBar و NavigationBar
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: kDarkGreenColor,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: kDarkGreenColor,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
      await Get.find<StorageService>().saveNotificationPage("${type ?? 0}");
      await Get.find<StorageService>().saveNotificationPageId("${typeId ?? 0}");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      var type = message.data["page"];
      var typeId = message.data["page_id"];
      await Get.find<StorageService>().saveNotificationPage("${type ?? 0}");
      await Get.find<StorageService>().saveNotificationPageId("${typeId ?? 0}");
    });
  }

  @override
  Widget build(BuildContext context) {
    // ✅ فرض الوضع العمودي فقط
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetMaterialApp(
      navigatorKey: navigatorKey,
      navigatorObservers: [observer],
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: Get.find<LocalizationService>().activeLocale,
      supportedLocales: SupportedLocales.all,
      fallbackLocale: SupportedLocales.english,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(
          backgroundColor: kDarkGreenColor,
          iconTheme: IconThemeData(color: Colors.white),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: kDarkGreenColor,
            systemNavigationBarColor: kDarkGreenColor,
            systemNavigationBarDividerColor: kDarkGreenColor,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarContrastEnforced: true,
            systemStatusBarContrastEnforced: true,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}