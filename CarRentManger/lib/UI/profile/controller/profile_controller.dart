// ignore_for_file: avoid_print

import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carrentmanger/Services/auth_services.dart';
import 'package:carrentmanger/UI/welcomeScreen/welcome_screen.dart';
import 'package:carrentmanger/models/profile_model.dart';
import 'package:carrentmanger/models/response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Services/biomatrics_auth_services.dart';
import '../../../Utils/colors.dart';
import '../../../Utils/constant.dart';
import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../../Widget/custom_text_widget.dart';

class ProfileController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  ScrollController scrollController = ScrollController();

  final BuildContext context;
  ProfileModel? profileData;
  bool isLoading = true;
  ProfileController(this.context);
  @override
  void onInit() {
    super.onInit();
    getProfileData();
  }
  changeLanguage(){
    final Locale newLocale =
    Get.find<StorageService>().activeLocale == SupportedLocales.arabic
        ? SupportedLocales.english
        : SupportedLocales.arabic;
    //in storage
    Get.find<StorageService>().activeLocale = newLocale;
    //in Getx
    Get.updateLocale(newLocale);
  }
  loggingOut(){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.rightSlide,
      title: Get
          .find<StorageService>()
          .activeLocale == SupportedLocales.english
          ?"warning":"تحذير",
      desc: Get
          .find<StorageService>()
          .activeLocale == SupportedLocales.english
          ? "do you want log out from your account?"
          :"هل تريد تسجيل الخروج من حسابك؟",
      btnCancelText: Get
          .find<StorageService>()
          .activeLocale == SupportedLocales.english
          ?"no":"لا",
      btnOkText: Get
          .find<StorageService>()
          .activeLocale == SupportedLocales.english
          ?"yes":"نعم",
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Get.find<StorageService>().loggingOut();
        Get.offAll(()=>const WelcomeScreen());
      },
    ).show();
  }

  getProfileData() async {
    profileData = await AuthServices.getProfileData();
    isLoading = false;
    update();
  }
  deletingAccount(context) async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.rightSlide,
      title: Get
          .find<StorageService>()
          .activeLocale == SupportedLocales.english
          ?"warning":"تحذير",
      desc: Get
          .find<StorageService>()
          .activeLocale == SupportedLocales.english
          ? "do you want to delete your account?"
          :"هل تريد حذف حسابك؟",
      btnCancelText: Get
          .find<StorageService>()
          .activeLocale == SupportedLocales.english
          ?"no":"لا",
      btnOkText: Get
          .find<StorageService>()
          .activeLocale == SupportedLocales.english
          ?"yes":"نعم",
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Get.find<StorageService>().loggingOut();
        Get.offAll(()=>const WelcomeScreen());
      },
    ).show();

    }

    deleteTheAccount() async {
      if (await BiomatricsAuthService.authenticateUser(Get.find<StorageService>().activeLocale == SupportedLocales.english?"so you can delete account":" حتى تتمكن من حذف الحساب ",
      )) {
        ResponseModel? data = await AuthServices.deletingAccount();
        if (data?.msg == "succeeded") {
          final snackBar = SnackBar(content:
          Row(children: [
            const Icon(Icons.check, color: Colors.white,),
            const SizedBox(width: 10,),
            Text(Get
                .find<StorageService>()
                .activeLocale ==
                SupportedLocales.english
                ? 'The your account has been deleted'
                : 'تم حذف حسابك ', style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
            ),
          ],),
              backgroundColor: Colors.green
          );
          isLoading = false;
          update();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Get.find<StorageService>().loggingOut();
          Get.offAll(()=>const WelcomeScreen());
        }
        else {
          isLoading = false;
          update();
          final snackBar = SnackBar(content:
          Row(children: [
            const Icon(Icons.close, color: Colors.white,),
            const SizedBox(width: 10,),
            Text(Get
                .find<StorageService>()
                .activeLocale ==
                SupportedLocales.english
                ? 'An error occurred while deleting your account'
                : 'حدث خطأ أثناء حذف حسابك ', style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
            ),
          ],),
              backgroundColor: Colors.red
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    }
  }
