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



  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    text1FocusNode = FocusNode();
    checkForUpgrades();
  }

  @override
  void onClose() {
    nameController.dispose();
    text1FocusNode.dispose();
    super.onClose();
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
  checkForUpgrades() {
    InAppUpdate.checkForUpdate().then((updateInfo) {
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateInfo.immediateUpdateAllowed) {
          // Perform immediate update
          InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              //App Update successful
            }
          });
        } else if (updateInfo.flexibleUpdateAllowed) {
          //Perform flexible update
          InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              //App Update successful
              InAppUpdate.completeFlexibleUpdate();
            }
          });
        }
      }
    });
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