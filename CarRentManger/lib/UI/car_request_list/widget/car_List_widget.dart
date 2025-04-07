// ignore_for_file: sized_box_for_whitespace, file_names, prefer_const_constructors

import 'package:carrentmanger/UI/car_request_details/car_request_details_screen.dart';
import 'package:carrentmanger/models/car_requests_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Models/car_list_model.dart';
import '../../../Utils/colors.dart';
import '../../../Utils/constant.dart';
import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../../Utils/translation_key.dart';
import '../../../Widget/custom_text_widget.dart';

class CarListWidget extends StatelessWidget {
   CarListWidget({super.key, required this.carData});
  final CarRequestModel? carData;
  List<String>? listOfWithDriver = Get.find<StorageService>().activeLocale ==
      SupportedLocales.english
      ? ["Yes","No"]
      :["نعم","لا"];
  List<String>? listOfPeriods = Get.find<StorageService>().activeLocale ==
      SupportedLocales.english
      ? ["daily","weekly","monthly","until ownership"]
      :["يومى","أسبوعى","شهرى"," حتى التملك"];
   String returnChosenPeriods(){
     String theChosenOfthePeriod = "";
     for (int i = 0; i < (carData?.type?.length ?? 0); i++) {
       theChosenOfthePeriod = "$theChosenOfthePeriod ${ Get
           .find<StorageService>()
           .activeLocale ==
           SupportedLocales.english
           ? (listOfPeriods?[i]?? "") : (listOfPeriods?[i]?? "")}";
       if ((i + 1) < (carData?.type?.length ?? 0)) {
         theChosenOfthePeriod = "$theChosenOfthePeriod , ";
       }
     }
     return theChosenOfthePeriod;
   }
   String returnChosenDriverOrNot(){
     String theChosenOfWithDriverOrNot = "";
     for (int i = 0; i < (carData?.driver?.length ?? 0 ); i++) {
       theChosenOfWithDriverOrNot = "$theChosenOfWithDriverOrNot ${ Get
           .find<StorageService>()
           .activeLocale ==
           SupportedLocales.english
           ? (listOfWithDriver?[i]?? "") : (listOfWithDriver?[i]?? "")}";
       if ((i + 1) < (carData?.driver?.length ?? 0 )) {
         theChosenOfWithDriverOrNot = "$theChosenOfWithDriverOrNot ${ Get
             .find<StorageService>()
             .activeLocale ==
             SupportedLocales.english
             ?"or ": "أو"} ";
       }
     }
     return theChosenOfWithDriverOrNot;
   }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: (){
          print("object");
          Get.to(()=>CarRequestDetailsScreen(carData: carData,));
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            width: Get.width*0.9,
            height: Get.height*0.25,
            decoration: BoxDecoration(
              color: kDarkGreenColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: kGreyColor.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Stack(

                children: [

                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: Get.width*0.9,
                      height: Get.height*0.22,
                      decoration:  BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        border: Border.all(color: kDarkGreenColor,width: 3),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: Get.width*0.8,
                            height: Get.height*0.19,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 3.0),
                              child: Column(
                                children: [
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                      children: [
                                        CustomText(
                                          Get.find<StorageService>().activeLocale == SupportedLocales.english?"car brand: ":"ماركة السيارة: ",
                                          textAlign: TextAlign.center,
                                          style:  TextStyle(
                                            fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                            color: kGreyColor,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 15,
                                            letterSpacing: 0,

                                          ),

                                        ),
                                        CustomText(
                                          carData?.make??"",
                                          textAlign: TextAlign.center,
                                          style:  TextStyle(
                                            fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                            color: kDarkBlueColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                            letterSpacing: 0,

                                          ),),
                                      ],
                                    ),


                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        "${carNameTitle.tr} ",
                                        textAlign: TextAlign.center,
                                        style:  TextStyle(
                                          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                          color: kGreyColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 15,
                                          letterSpacing: 0,

                                        ),

                                      ),
                                      CustomText(
                                        carData?.model??"",
                                        textAlign: TextAlign.center,
                                        style:  TextStyle(
                                          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                          color: kDarkBlueColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          letterSpacing: 0,

                                        ),),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                      Get.find<StorageService>().activeLocale == SupportedLocales.english?"Year of manufacture:":"سنة الصنع:",
                                      textAlign: TextAlign.center,
                                      style:  TextStyle(
                                        fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                        color: kGreyColor,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
                                        letterSpacing: 0,

                                      ),

                                    ),
                                      SizedBox(height: 3,),
                                      Center(
                                        child: Container(
                                          width: Get.width*0.6,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  CustomText(
                                                    "  ${Get.find<StorageService>().activeLocale == SupportedLocales.english?"from: ":"من: "}",
                                                    textAlign: TextAlign.center,
                                                    style:  TextStyle(
                                                      fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                      color: kBlackColor,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 15,
                                                      letterSpacing: 0,

                                                    ),),
                                                  CustomText(
                                                    carData?.yearFrom??"",
                                                    textAlign: TextAlign.center,
                                                    style:  TextStyle(
                                                      fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                      color: kDarkBlueColor,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 15,
                                                      letterSpacing: 0,

                                                    ),),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  CustomText(
                                                    "  ${Get.find<StorageService>().activeLocale == SupportedLocales.english?"to: ":"إلى: "}",
                                                    textAlign: TextAlign.center,
                                                    style:  TextStyle(
                                                      fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                      color: kBlackColor,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 15,
                                                      letterSpacing: 0,

                                                    ),),
                                                  CustomText(
                                                    carData?.yearTo??"",
                                                    textAlign: TextAlign.center,
                                                    style:  TextStyle(
                                                      fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                      color: kDarkBlueColor,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 15,
                                                      letterSpacing: 0,

                                                    ),),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        Get.find<StorageService>().activeLocale == SupportedLocales.english?"rental period: ":"فترة الإيجار: ",
                                        textAlign: TextAlign.center,
                                        style:  TextStyle(
                                          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                          color: kGreyColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 15,
                                          letterSpacing: 0,

                                        ),

                                      ),
                                      CustomText(
                                        returnChosenPeriods(),
                                        textAlign: TextAlign.center,
                                        style:  TextStyle(
                                          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                          color: kDarkBlueColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          letterSpacing: 0,

                                        ),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        Get.find<StorageService>().activeLocale == SupportedLocales.english?"do you want car with driver? ":" هل تريد سيارة مع سائق؟",
                                        textAlign: TextAlign.center,
                                        style:  TextStyle(
                                          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                          color: kGreyColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 15,
                                          letterSpacing: 0,

                                        ),

                                      ),
                                      CustomText(
                                        returnChosenDriverOrNot(),
                                        textAlign: TextAlign.center,
                                        style:  TextStyle(
                                          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                          color: kDarkBlueColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          letterSpacing: 0,

                                        ),),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
