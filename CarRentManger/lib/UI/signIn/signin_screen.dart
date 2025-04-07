// ignore_for_file: sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrentmanger/Utils/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/colors.dart';
import '../../Utils/constant.dart';
import '../../Utils/localization_services.dart';
import '../../Utils/memory.dart';
import '../../Utils/translation_key.dart';
import '../../Widget/custom_text_widget.dart';
import '../../Widget/text_field_widget.dart';
import 'controller/signin_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
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
                              Icon(Icons.arrow_circle_left_outlined,color:kDarkBlueColor ,size: 45,),
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
                              Icon(Icons.arrow_circle_right_outlined,color:kDarkBlueColor ,size: 45,),
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
                              child:   CustomText(
                                signInBTN.tr,
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
                      SizedBox(height: Get.height*0.18,),
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
                       SizedBox(height: Get.height*0.03),
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
                                  signInBTN.tr,
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
                                    color: kDarkBlueColor,
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
