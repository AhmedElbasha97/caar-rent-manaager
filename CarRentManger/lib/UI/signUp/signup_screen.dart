// ignore_for_file: sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrentmanger/UI/privacy_policy/privacy_policy_screen.dart';
import 'package:carrentmanger/UI/terms_and_condition/terms_and_condition_screen.dart';
import 'package:carrentmanger/Utils/services.dart';
import 'package:carrentmanger/Utils/translation_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/colors.dart';
import '../../Utils/constant.dart';
import '../../Utils/localization_services.dart';
import '../../Utils/memory.dart';
import '../../Widget/custom_text_widget.dart';
import '../../Widget/text_field_widget.dart';
import 'controller/signup_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      init: SignUpController(),
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
                              child:      CustomText(
                                signUpBTN.tr,
                                style:  TextStyle(
                                  fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                  color: kDarkBlueColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 25,
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
                            labelText: signUpTitleName.tr,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            iconOfTextField: const Icon(Icons.person,
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

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                          height: Get.height*0.09,
                          width: Get.width*0.95,
                          child: CustomInputField(
                            isPhoneNumber: false,
                            textAligning: Get.find<StorageService>().activeLocale == SupportedLocales.english?TextAlign.left:TextAlign.right,

                            hasIntialValue: true,
                            labelText: signUpTitleEmail.tr,
                            iconOfTextField: const Icon(Icons.email,
                                color: kDarkBlueColor),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,

                            controller:controller.emailController,
                            onchange: controller.onEmailUpdate,
                            validator: controller.validateEmail,
                            icon: (controller.emailValidated)
                                ? (controller.emailState)
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

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                          height: Get.height*0.09,
                          width: Get.width*0.95,
                          child: CustomInputField(
                            isPhoneNumber: true,

                            textAligning: Get.find<StorageService>().activeLocale == SupportedLocales.english?TextAlign.left:TextAlign.right,

                            hasIntialValue: true,
                            labelText: signUpTitlePhone.tr,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            iconOfTextField: const Icon(Icons.phone,
                                color: kDarkBlueColor),
                            controller:controller.phoneController,
                            onchange: controller.onPhoneNumberUpdate,
                            validator: controller.validatePhoneNumber,
                            icon: (controller.phoneValidated)
                                ? (controller.phoneState)
                                ?  InkWell(
                              onTap: (){
                                controller. choosingCountryCode( context);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:"${Services.baseEndPoint}${controller.selectedCountryCode?.flag}",
                                    imageBuilder: ((context, image) {
                                      return Container(
                                          height: Get.height * 0.04,
                                          width: Get.width * 0.07,

                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),

                                            image: DecorationImage(
                                              image: image,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ));
                                    }),
                                    placeholder: (context, image) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Container(
                                            height: Get.height * 0.04,
                                            width: Get.width * 0.07,
                                            decoration: const BoxDecoration(
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        15))),
                                            child:const CircularProgressIndicator(
                                              color: kDarkGreenColor,
                                            )),
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return Container(
                                          height: Get.height * 0.04,
                                          width: Get.width * 0.07,

                                          decoration: const BoxDecoration(

                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/27002.jpg"),
                                                fit: BoxFit.fitWidth,
                                              ),
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(
                                                      10))));
                                    },
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  CustomText(
                                    "   ${controller.selectedCountryCode?.code??signUpTextPhoneKey.tr}    ",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: Get.find<
                                          StorageService>()
                                          .activeLocale ==
                                          SupportedLocales
                                              .english
                                          ? fontFamilyEnglishName
                                          : fontFamilyArabicName,
                                      color: kDarkGreenColor,
                                    ),
                                  ),
                                  const Icon(
                                      Icons.check_rounded,
                                      color: kDarkGreenColor),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            )
                                : InkWell(
                              onTap: (){
                                controller. choosingCountryCode( context);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:"${Services.baseEndPoint}${controller.selectedCountryCode?.flag}",
                                    imageBuilder: ((context, image) {
                                      return Container(
                                          height: Get.height * 0.04,
                                          width: Get.width * 0.07,

                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),

                                            image: DecorationImage(
                                              image: image,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ));
                                    }),
                                    placeholder: (context, image) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Container(
                                            height: Get.height * 0.04,
                                            width: Get.width * 0.07,
                                            decoration: const BoxDecoration(
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        15))),
                                            child:const CircularProgressIndicator(
                                              color: kDarkGreenColor,
                                            )),
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return Container(
                                          height: Get.height * 0.04,
                                          width: Get.width * 0.07,

                                          decoration: const BoxDecoration(

                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/27002.jpg"),
                                                fit: BoxFit.fitWidth,
                                              ),
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(
                                                      10))));
                                    },
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),

                                  CustomText(
                                    "   ${controller.selectedCountryCode?.code??signUpTextPhoneKey.tr}    ",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: Get.find<
                                          StorageService>()
                                          .activeLocale ==
                                          SupportedLocales
                                              .english
                                          ? fontFamilyEnglishName
                                          : fontFamilyArabicName,
                                      color: kDarkGreenColor,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.close_outlined,
                                    color: kErrorColor,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            )
                                :  InkWell(
                              onTap: (){
                                controller. choosingCountryCode( context);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:"${Services.baseEndPoint}${controller.selectedCountryCode?.flag}",
                                    imageBuilder: ((context, image) {
                                      return Container(
                                          height: Get.height * 0.04,
                                          width: Get.width * 0.07,

                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),

                                            image: DecorationImage(
                                              image: image,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ));
                                    }),
                                    placeholder: (context, image) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Container(
                                            height: Get.height * 0.04,
                                            width: Get.width * 0.07,
                                            decoration: const BoxDecoration(
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        15))),
                                            child:const CircularProgressIndicator(
                                              color: kDarkGreenColor,
                                            )),
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return Container(
                                          height: Get.height * 0.04,
                                          width: Get.width * 0.07,

                                          decoration: const BoxDecoration(

                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/27002.jpg"),
                                                fit: BoxFit.fitWidth,
                                              ),
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(
                                                      10))));
                                    },
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  CustomText(
                                    "   ${controller.selectedCountryCode?.code??signUpTextPhoneKey.tr}    ",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: Get.find<
                                          StorageService>()
                                          .activeLocale ==
                                          SupportedLocales
                                              .english
                                          ? fontFamilyEnglishName
                                          : fontFamilyArabicName,
                                      color: kDarkGreenColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            hasGreenBorder: false,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          width: Get.width*0.9,
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const WidgetSpan(
                                    child: Icon(Icons.warning, size: 14,color: kDarkBlueColor,),
                                  ),

                                  TextSpan(
                                    text: Get.find<StorageService>()
                                        .activeLocale ==
                                        SupportedLocales.english
                                        ?"You must have WhatsApp on the phone number you will use to register your account in the application in order to be able to receive the verification code.":"يجب أن يكون لديك واتس اب على رقم الهاتف الذي ستقوم تسجيل حسابك به في التطبيق لكي تتمكن من إستقبال كود التحقق",

                                    style: TextStyle(


                                        fontFamily: Get.find<StorageService>()
                                            .activeLocale ==
                                            SupportedLocales.english
                                            ? fontFamilyEnglishName
                                            : fontFamilyArabicName,
                                        color: kDarkBlueColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            fillColor: MaterialStateProperty.all<Color>(kLightGreenColor),

                            groupValue: controller.val,
                            onChanged: (value) {
                              controller.changeValueOfRadioBTN(value,context);
                            },
                            toggleable: true,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                readAppPolicyAndTerms.tr,  style:  TextStyle(
                                  fontFamily:Get
                                      .find<StorageService>()
                                      .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                                  color: kDarkBlueColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Get.to(()=>const PrivacyPolicyScreen());
                                    },
                                    child: Text(
                                      privacyPolicy.tr,
                                      style:  TextStyle(
                                          fontFamily:Get
                                              .find<StorageService>()
                                              .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                                          color: kLightGreenColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Text(
                                    and.tr,  style:  TextStyle(
                                      fontFamily:Get
                                          .find<StorageService>()
                                          .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                                      color: kDarkBlueColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),),
                                  InkWell(
                                    onTap: (){
                                      Get.to(()=>const TermsAndConditionScreen());
                                    },
                                    child: Text(
                                      termsAndCondition.tr,
                                      style:  TextStyle(
                                          fontFamily:Get
                                              .find<StorageService>()
                                              .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                                          color: kLightGreenColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          )
                        ],
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
                                    signUpBTN.tr,
                                    style:  TextStyle(
                                      fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                      color: kWhiteColor,
                                      fontWeight: FontWeight.w800,
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

