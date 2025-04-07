import 'package:carrentmanger/UI/otp/controller/otp_controller.dart';
import 'package:carrentmanger/Utils/colors.dart';
import 'package:carrentmanger/Utils/constant.dart';
import 'package:carrentmanger/Utils/localization_services.dart';
import 'package:carrentmanger/Utils/memory.dart';
import 'package:carrentmanger/Utils/translation_key.dart';
import 'package:carrentmanger/Widget/custom_text_widget.dart';
import 'package:carrentmanger/Widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.comingFromSignUp, });
  final  bool comingFromSignUp;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OTPController>(
      init: OTPController(comingFromSignUp),
      builder: (controller) =>  SafeArea(
        child: Scaffold(
          body: Container(
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
                          Get.back();
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
                          Get.back();
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
                        width: Get.width*0.7,
                        height: Get.height*0.08,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Padding(
                              padding: const EdgeInsets.fromLTRB(18.0,10,25,0),
                              child:    CustomText(
                                Get.find<StorageService>().activeLocale == SupportedLocales.english?"Enter the verification code \n you received on WhatsApp":"أدخل كود التحقق الذي  \nوصلك على الواتس اب",

                                style:  TextStyle(
                                  fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                  color: kDarkBlueColor,
                                  fontSize: 18,
                                  letterSpacing: 0,

                                ),
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
    );
  }
}
