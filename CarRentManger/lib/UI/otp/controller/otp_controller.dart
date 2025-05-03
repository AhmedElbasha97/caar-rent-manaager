import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carrentmanger/Services/auth_services.dart';
import 'package:carrentmanger/UI/homeScreen/home_screen.dart';
import 'package:carrentmanger/UI/signIn/signin_screen.dart';
import 'package:carrentmanger/UI/signUp/signup_screen.dart';
import 'package:carrentmanger/Utils/localization_services.dart';
import 'package:carrentmanger/Utils/memory.dart';
import 'package:carrentmanger/Utils/translation_key.dart';
import 'package:carrentmanger/Utils/validator.dart';
import 'package:carrentmanger/models/response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';

class OTPController extends GetxController{
  final formKey = GlobalKey<FormState>();
  final  bool comingFromSignUp;
  OTPController(this.comingFromSignUp, );
  late TextEditingController nameController;
  bool nameState = false;
  bool nameValidated = false;
  String buttonStatus = "main";
  late FocusNode text1FocusNode ;
  final _validatorHelber = ValidatorHelper.instance;
  bool formValidated = false;
  RxInt remainingSeconds = 60.obs;
  Timer? _timer;
bool isResendingOTPCode = false;
  void startTimer() {
    remainingSeconds.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void resetTimer() {
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    nameController.dispose();
    text1FocusNode.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    text1FocusNode = FocusNode();
    checkForUpgrades();
    startTimer();
  }



  void clear() {
    nameController.clear();
  }

  changeButtonStatus(){
    if(nameState){
      if(buttonStatus != "main") {
        buttonStatus = "main";
      }
    }
  }
  void onNameUpdate(String? value) {
    if (value == "") {
      nameState = false;
    }
    update();
  }

  String? validateName(String? name) {
    var validateName = _validatorHelber.validateName(name);
    if (validateName == null && name != "") {
      nameState = true;
      nameValidated = true;
      changeButtonStatus();
    } else {
      nameValidated = true;
      nameState = false;
    }
    return validateName;
  }

  checkForUpgrades() async {

      try {
        final updateInfo = await InAppUpdate.checkForUpdate();

        if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
          // يوجد تحديث متاح، تقدر تختار:
          // 1. Immediate (تحديث إجباري)
          // 2. Flexible (تحديث اختياري)

          // مثال على التحديث الفوري:
          InAppUpdate.performImmediateUpdate();

          // أو لو تفضل تحديث مرن:
          // InAppUpdate.startFlexibleUpdate().then((_) {
          //   InAppUpdate.completeFlexibleUpdate();
          // });
        }
      } catch (e) {
        print("Error checking for update: $e");
      }
    }

  getBackToAnotherScreen(BuildContext context) async {
    bool checker = await Navigator.maybePop(context);
    if(!checker){
      if(comingFromSignUp) {
        Get.to(()=>const SignInScreen());
      }else{
        Get.to(()=>const SignInScreen());
      }
    }
  }
  resendingCode(BuildContext context) async {

    if(isResendingOTPCode){
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: Get
              .find<StorageService>()
              .activeLocale ==
              SupportedLocales.english
              ? "please wait ...":"انتظر من فضلك ...",
          desc: Get
              .find<StorageService>()
              .activeLocale ==
              SupportedLocales.english
              ? "We are sending the OTP code again.":"نحن نرسل رمز التحقق مرة إخرى",

          btnCancelText: Get
              .find<StorageService>()
              .activeLocale == SupportedLocales.english
              ?"no":"لا",
          btnOkText: Get
              .find<StorageService>()
              .activeLocale == SupportedLocales.english
              ?"yes":"نعم",
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();

    }else {

      ResponseModel? data = await AuthServices.resendNewOTP();
      isResendingOTPCode = true;
      update();
      print(data?.msg);
      if (data?.msg == "succeeded") {
        final snackBar = SnackBar(content:
        Row(children: [
          const Icon(Icons.check, color: Colors.white,),
          const SizedBox(width: 10,),
          Text(Get
              .find<StorageService>()
              .activeLocale ==
              SupportedLocales.english
              ? 'The OTP Code has been sent successfully'
              : 'تم إرسال رمز التحقق بنجاح', style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
          ),
        ],),
            backgroundColor: Colors.green
        );
        update();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        isResendingOTPCode = false;
        resetTimer();
        update();
      }
      else {
        update();
        final snackBar = SnackBar(content:
        Row(children: [
          const Icon(Icons.close, color: Colors.white,),
          const SizedBox(width: 10,),
          Text(Get
              .find<StorageService>()
              .activeLocale ==
              SupportedLocales.english
              ? 'An error occurred while Resending the otp code'
              : 'حدث خطأ أثناء إعادة إرسال رمز التحقق', style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
          ),
        ],),
            backgroundColor: Colors.red
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        isResendingOTPCode = false;
        resetTimer();
      }
    }
  }
  checkOtp(BuildContext context) async {
    if(nameController.text ==  Get.find<StorageService>().getUserOtp){
      nameController.clear();
      if(comingFromSignUp){
        ResponseModel? data = await AuthServices.activatingAccount();
        print(data?.msg);
        if (data?.msg == "succeeded") {
          await Get.find<StorageService>().removeOtpCode();
          await Get.to(()=> const HomeScreen());


        }
        else {

          final snackBar = SnackBar(content:
          Row(children: [
            const Icon(Icons.close, color: Colors.white,),
            const SizedBox(width: 10,),
            Text(Get
                .find<StorageService>()
                .activeLocale ==
                SupportedLocales.english
                ? 'An error occurred while checking the otp'
                : 'حدث خطاء ', style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
            ),
          ],),
              backgroundColor: Colors.red
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }


      }else{
        await Get.find<StorageService>().removeOtpCode();
        await Get.to(()=> const HomeScreen());
      }
    }else{
      AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: errorKey.tr,
          desc: otpAlert.tr,
          btnCancelOnPress: () {},
    btnOkOnPress: () {},
    ).show();

    }
  }

  Future<void> sendPressed(context) async {
    formValidated = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (formValidated) {
      checkOtp(context);
    }else{
      buttonStatus ="failed";

      update();
    }
  }

  // late String _optCode;
  Future errorDialog(String err) async {
    return Get.defaultDialog(
        title: "error /n tryAgain.tr ",
        titlePadding: const EdgeInsets.symmetric(vertical: 10),
        middleText: err);
  }

  signningUp(context) async {
    if( buttonStatus != "loading"){
      Future.delayed(const Duration(milliseconds: 200), () {
        buttonStatus = "success";
        update();
        Get.to(()=>HomeScreen());
      });
    }
    buttonStatus = "loading";
    update();
  }
}