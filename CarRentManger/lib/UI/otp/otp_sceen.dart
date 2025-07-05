import 'package:carrentmanger/UI/otp/controller/otp_controller.dart';
import 'package:carrentmanger/Utils/colors.dart';
import 'package:carrentmanger/Utils/constant.dart';
import 'package:carrentmanger/Utils/localization_services.dart';
import 'package:carrentmanger/Utils/memory.dart';
import 'package:carrentmanger/Utils/translation_key.dart';
import 'package:carrentmanger/Widget/custom_text_widget.dart';
import 'package:carrentmanger/Widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../signIn/signin_screen.dart';
import '../signUp/signup_screen.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.comingFromSignUp, });
  final  bool comingFromSignUp;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OTPController>(
      init: OTPController(comingFromSignUp),
      builder: (controller) =>   AnnotatedRegion<SystemUiOverlayStyle>(
    value: const SystemUiOverlayStyle(
    statusBarColor: kDarkGreenColor, // نفس لون الخلفية
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: kDarkGreenColor,
    systemNavigationBarIconBrightness: Brightness.light,
    ),
    child: Scaffold(
    backgroundColor: kDarkGreenColor,
    body: SafeArea(
    child: Container(
            width: Get.width,
            height: Get.height,
            decoration:  const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg_image.png"),
                fit: BoxFit.cover,
              ),
            ),
            child:  Container(
              width: Get.width,
              height: Get.height,
              color: Colors.black.withOpacity(0),
              child: Form(
                key: controller.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Get.find<StorageService>().activeLocale == SupportedLocales.english? InkWell(
                        onTap: (){
                          if(comingFromSignUp){
                            Get.off(()=>const SignUpScreen(),transition: Get.find<StorageService>().activeLocale == SupportedLocales.english?Transition.rightToLeftWithFade:Transition.leftToRightWithFade);
                          }else{
                            Get.off(()=>const SignInScreen(),transition: Get.find<StorageService>().activeLocale == SupportedLocales.english?Transition.rightToLeftWithFade:Transition.leftToRightWithFade);

                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Icon(Icons.arrow_circle_left,color: kWhiteColor,size: 45,),
                              Icon(Icons.arrow_circle_left_outlined,color: kDarkBlueColor,size: 45,),
                            ],
                          ),
                        ),
                      ):
                      InkWell(
                        onTap: (){
                          if(comingFromSignUp){
                            Get.off(()=>const SignUpScreen(),transition: Get.find<StorageService>().activeLocale == SupportedLocales.english?Transition.rightToLeftWithFade:Transition.leftToRightWithFade);
                          }else{
                            Get.off(()=>const SignInScreen(),transition: Get.find<StorageService>().activeLocale == SupportedLocales.english?Transition.rightToLeftWithFade:Transition.leftToRightWithFade);

                          }

                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Stack(
                            children: [

                              Icon(Icons.arrow_circle_right,color: kWhiteColor,size: 45,),
                              Icon(Icons.arrow_circle_right_outlined,color: kDarkBlueColor,size: 45,),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Padding(
                              padding: const EdgeInsets.fromLTRB(18.0,10,25,0),
                              child: CustomText(
                                Get.find<StorageService>().activeLocale == SupportedLocales.english?"OTP code":"رمز التحقيق",
                                style:  TextStyle(
                                  fontWeight: FontWeight.w800,

                                  fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                  color: kDarkBlueColor,
                                  fontSize: 25,
                                  letterSpacing: 0,

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),Container(
                        width: Get.width,
                        height: Get.height*0.13,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Padding(
                              padding: const EdgeInsets.fromLTRB(18.0,10,25,0),
                              child:    Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    Get.find<StorageService>().activeLocale == SupportedLocales.english?"Enter the verification code \n you received on WhatsApp":" أدخل كود التحقق الذي  \nوصلك على الواتس اب على رقم ",

                                    style:  TextStyle(
                                      fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                      color: kDarkBlueColor,
                                      fontSize: 18,
                                      letterSpacing: 0,

                                    ),
                                  ),
                                  CustomText(
                                      "${ Get.find<StorageService>().getUserPhoneNumber} (${ Get.find<StorageService>().getUserCountryCode}+) ",
                                    style:  TextStyle(
                                      fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                      color: kLightGreenColor,
                                      fontSize: 18,
                                      letterSpacing: 0,

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height*0.07,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                          height: Get.height*0.09,
                          width: Get.width*0.95,
                          child: CustomInputField(
                            isPhoneNumber: false,
                            textAligning: Get.find<StorageService>().activeLocale == SupportedLocales.english?TextAlign.left:TextAlign.right,
                            hasIntialValue: true,
                            labelText: textOfOTPTextField.tr,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            iconOfTextField: const Icon(Icons.numbers,
                                color: kDarkBlueColor),
                            controller:controller.nameController,
                            onchange: controller.onNameUpdate,
                            validator: controller.validateName,
                            icon: (controller.nameValidated)
                                ? (controller.nameState)
                                ? const Icon(Icons.check_rounded,
                                color: kLightGreenColor)
                                : const Icon(
                              Icons.close_outlined,
                              color: kErrorColor,
                            )
                                : null,
                            hasGreenBorder: false,
                          ),
                        ),
                      ),

                  Center(
                    child: Obx(() {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                Get.find<StorageService>().activeLocale == SupportedLocales.english?"Resend code in:":"إعادة إرسال الرمز في:",
                                style:  TextStyle(
                                  fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                  color: kDarkBlueColor,
                                  fontSize: 18,
                                  letterSpacing: 0,

                                ),
                              ),  CustomText(
                                Get.find<StorageService>().activeLocale == SupportedLocales.english?" ${controller.remainingSeconds.value}s":"${controller.remainingSeconds.value}ثانية",
                                style:  TextStyle(
                                  fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                  color: kLightGreenColor,
                                  fontSize: 18,
                                  letterSpacing: 0,

                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap: (){
                              if(controller.remainingSeconds.value == 0){
                              controller.resendingCode( context);
                              }
                            },
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                     WidgetSpan(
                                      child: Icon(Icons.restart_alt, size: 20,color:  controller.remainingSeconds.value == 0?kLightGreenColor:kGreyColor,
                                      ),
                                    ),

                                    TextSpan(
                                      text:Get.find<StorageService>().activeLocale == SupportedLocales.english?"Resend code":"إعادة إرسال الرمز",
                                      style:  TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                        color:  controller.remainingSeconds.value == 0?kLightGreenColor:kGreyColor,
                                        fontSize: 18,
                                        letterSpacing: 0,

                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      );
                    }),
                  ),


                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(height: Get.height*0.1),
                      Center(
                        child: InkWell(
                          onTap: (){
                            controller.sendPressed(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: controller.buttonStatus =="main"?Get.width*0.8:Get.width*0.19,
                              height: controller.buttonStatus =="main"?Get.height*0.09:Get.height*0.07,

                              decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: controller.buttonStatus =="failed"?kErrorColor:kLightGreenColor,width: 2)

                              ),
                              child:Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(

                                  decoration: BoxDecoration(
                                    color: kDarkBlueColor,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child:  Center(child: controller.buttonStatus =="main"?CustomText(
                                    textOfOTPBTN.tr,
                                    style:  TextStyle(
                                      fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                      color: kWhiteColor,
                                      fontSize: 15,

                                      height: 1,
                                      letterSpacing: -1,
                                    ),
                                  ):controller.buttonStatus =="loading"?const CircularProgressIndicator(
                                    backgroundColor: kWhiteColor,
                                    color: kLightGreenColor,
                                  ):controller.buttonStatus =="success"? const Icon(Icons.check,color: kLightGreenColor,size: 40,): const Icon(Icons.close,color: kErrorColor,size: 40,),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    )
    );
  }
}
