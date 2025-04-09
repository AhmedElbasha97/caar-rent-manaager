// ignore_for_file: library_private_types_in_public_api, file_names, use_build_context_synchronously

import 'dart:async';

import 'package:carrentmanger/UI/homeScreen/home_screen.dart';
import 'package:carrentmanger/UI/otp/otp_sceen.dart';
import 'package:carrentmanger/UI/welcomeScreen/welcome_screen.dart';
import 'package:carrentmanger/Utils/localization_services.dart';
import 'package:carrentmanger/Utils/memory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _notificationTimer;
  @override
  void initState() {
    super.initState();
    startRepeatingCheck();
  }



  void startRepeatingCheck() {
    _notificationTimer =  Timer.periodic(const Duration(seconds: 3), (timer) {
      checkNotificationPermission();
    });
  }
  Future<void> checkNotificationPermission() async {
    var status = await Permission.notification.status;

    if (status.isGranted) {
      navigateToNextScreen();
    } else if (status.isDenied) {

    } else if (status.isPermanentlyDenied) {
      final snackBar = SnackBar(content:
      Row(children: [
        const Icon(Icons.close, color: Colors.white,),
        const SizedBox(width: 10,),
        Text(Get
            .find<StorageService>()
            .activeLocale ==
            SupportedLocales.english
            ? 'you must allow the notifications \n so the app can work properly'
            : 'يجب عليك السماح بالإشعارات حتى \nيتمكن التطبيق من العمل بشكل صحيح', style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
        ),
      ],),
          backgroundColor: Colors.red
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Future.delayed(
        const Duration(seconds: 3),
            () async =>   await openAppSettings(),

      );


    }
  }

  navigateToNextScreen() {
     stopRepeatingCheck();
    if (Get
        .find<StorageService>()
        .checkUserHasOtpAlready) {
      Get.offAll(() =>
          OtpScreen(comingFromSignUp: Get
              .find<StorageService>()
              .getCheckerSigningUp));
    }  else {
      if (Get
          .find<StorageService>()
          .getId != "0") {
        Get.offAll(() => const HomeScreen());
      } else {
        Get.offAll(() => const WelcomeScreen());
      }
    }
  }
  void stopRepeatingCheck() {
    _notificationTimer?.cancel();
    _notificationTimer = null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg_image.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Image.asset(
                      "assets/images/app_logo.png",
                      width: constraints.maxWidth * 0.85,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CircularProgressIndicator(
                    backgroundColor: Color(0xFF66A5B4),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
