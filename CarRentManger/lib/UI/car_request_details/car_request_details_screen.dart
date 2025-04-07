import 'package:carrentmanger/UI/car_request_details/controller/car_request_details_controller.dart';
import 'package:carrentmanger/UI/car_request_details/widget/car_request_result_widget.dart';
import 'package:carrentmanger/Utils/colors.dart';
import 'package:carrentmanger/Utils/constant.dart';
import 'package:carrentmanger/Utils/localization_services.dart';

import 'package:carrentmanger/Utils/memory.dart';
import 'package:carrentmanger/Utils/translation_key.dart';
import 'package:carrentmanger/Widget/custom_text_widget.dart';
import 'package:carrentmanger/Widget/drawer_widget.dart';
import 'package:carrentmanger/Widget/loader.dart';
import 'package:carrentmanger/models/car_requests_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarRequestDetailsScreen extends StatefulWidget {
   const CarRequestDetailsScreen({super.key, required this.carData});
   final CarRequestModel? carData ;

  @override
  State<CarRequestDetailsScreen> createState() => _CarRequestDetailsScreenState();
}

class _CarRequestDetailsScreenState extends State<CarRequestDetailsScreen> {

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
     for (int i = 0; i < (widget.carData?.type?.length ?? 0); i++) {
       theChosenOfthePeriod = "$theChosenOfthePeriod ${ Get
           .find<StorageService>()
           .activeLocale ==
           SupportedLocales.english
           ? (listOfPeriods?[i]?? "") : (listOfPeriods?[i]?? "")}";
       if ((i + 1) < (widget.carData?.type?.length ?? 0)) {
         theChosenOfthePeriod = "$theChosenOfthePeriod , ";
       }
     }
     return theChosenOfthePeriod;
   }

   String returnChosenDriverOrNot(){
     String theChosenOfWithDriverOrNot = "";
     for (int i = 0; i < (widget.carData?.driver?.length ?? 0); i++) {
       theChosenOfWithDriverOrNot = "$theChosenOfWithDriverOrNot ${ Get
           .find<StorageService>()
           .activeLocale ==
           SupportedLocales.english
           ? (listOfWithDriver?[i]?? "") : (listOfWithDriver?[i]?? "")}";
       if ((i + 1) < (widget.carData?.driver?.length ?? 0)) {
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
    return GetBuilder(
      init:  CarRequestDetailsController(widget.carData?.id ?? 0),
      builder: (CarRequestDetailsController controller) =>  SafeArea(
        child: Scaffold(
          key: controller.scaffoldState,
          drawer: DrawerWidget(scaffoldKey: controller.scaffoldState,),
          body: Container(
            width: Get.width,
            height: Get.height,
            decoration: const BoxDecoration(
                color: kWhiteColor
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: kWhiteColor,
                  child: Container(
                    width: Get.width,

                    decoration:  const BoxDecoration(
                        color: kDarkGreenColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                        )
                    ),
                    child: Column(
                      children: [
                        ColoredBox(
                          color: kDarkGreenColor,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ColoredBox(
                              color: kWhiteColor,
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    InkWell(
                                      onTap:(){
                                        Get.back();
                                      },
                                      child: Container(
                                        color: kDarkGreenColor,
                                        child: Container(
                                          width: Get.width*0.2,

                                          decoration:  BoxDecoration(
                                              color: kWhiteColor,
                                              borderRadius: Get.find<StorageService>().activeLocale == SupportedLocales.english?const BorderRadius.only(
                                                bottomRight: Radius.circular(20),
                                              ):const BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                              )
                                          ),
                                          child:  Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                  width: Get.width*0.1,
                                                  height: Get.height*0.05,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(color: kLightGreenColor,width: 2),
                                                    borderRadius: BorderRadius.circular(50.0),
                                                  ),
                                                  child:  const Center(child: Icon(Icons.arrow_back_ios_rounded,color: kLightGreenColor,size: 25,))),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex:1,
                                      child: Container(
                                        decoration:  const BoxDecoration(
                                            color: kDarkGreenColor,
                                            borderRadius:BorderRadius.only(
                                              topRight: Radius.circular(20),topLeft: Radius.circular(20),
                                            )
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),

                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Stack(
                                                children: [
                                                  // Implement the stroke
                                                  CustomText(
                                                    "تفصيل الطلب",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w900,
                                                      fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                      foreground: Paint()
                                                        ..style = PaintingStyle.stroke
                                                        ..strokeWidth =3
                                                        ..color = kWhiteColor,
                                                    ),
                                                  ),
                                                  // The text inside
                                                  CustomText(
                                                    "تفصيل الطلب",
                                                    textAlign: TextAlign.center,
                                                    style:  TextStyle(
                                                      fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                      color: kDarkBlueColor,
                                                      fontWeight: FontWeight.w800,
                                                      fontSize: 20,
                                                      letterSpacing: 0,

                                                    ),
                                                  )
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        controller.scaffoldState.currentState!.openDrawer();
                                      },
                                      child: Container(
                                        color: kDarkGreenColor,
                                        child: Container(
                                          width: Get.width*0.2,

                                          decoration:  BoxDecoration(
                                              color: kWhiteColor,
                                              borderRadius: Get.find<StorageService>().activeLocale == SupportedLocales.english?const BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                              ):const BorderRadius.only(
                                                bottomRight: Radius.circular(20),
                                              )
                                          ),
                                          child:  Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                  width: Get.width*0.1,
                                                  height: Get.height*0.05,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(color: kLightGreenColor,width: 2),
                                                    borderRadius: BorderRadius.circular(50.0),
                                                  ),
                                                  child: const Padding(
                                                    padding: EdgeInsets.all(3.0),
                                                    child: Center(child: Icon(Icons.menu,color: kLightGreenColor,size: 25,)),
                                                  )),
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



                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: Get.width,
                    decoration:  const BoxDecoration(
                        borderRadius:BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: RawScrollbar(
                        thumbColor: kDarkBlueColor,
                        radius: const Radius.circular(20),
                        thickness: 5,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                children: [

                                  const SizedBox(width: 10,),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: Get.height*0.21,
                                      decoration: const BoxDecoration(
                                          color: kDarkGreenColor,
                                          borderRadius:BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8.0,top: 8.0,bottom: 8.0),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: kWhiteColor,
                                              borderRadius:BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                bottomRight: Radius.circular(20),
                                              )
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
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
                                                          widget.carData?.make ?? "",
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
                                                          widget.carData?.model ?? "",
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
                                                    const SizedBox(height: 3,),
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
                                                                  widget.carData?.yearFrom ?? "",
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
                                                                  widget.carData?.yearTo ?? "",
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
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10,),
                              CustomText(
                                Get.find<StorageService>().activeLocale == SupportedLocales.english?"Newly added cars compatible with your request":"سيارات تمت أضافه حديثا متوافق مع طلبك",
                                textAlign: TextAlign.center,
                                style:  TextStyle(
                                  fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                  color: kGreyColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  letterSpacing: 0,

                                ),

                              ),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: kDarkGreenColor,
                                          borderRadius:BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8.0,top: 8.0,bottom: 8.0),
                                        child: controller.isLoading?Loader(width: Get.width*0.9,
                                          height: Get.height*0.5,):controller.carData?.isEmpty??true?
                                        Container(
                                            decoration: const BoxDecoration(
                                                color: kWhiteColor,
                                                borderRadius:BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  bottomLeft: Radius.circular(20),
                                                )
                                            ),
                                            height: MediaQuery.of(context).size.height*0.75,
                                            width: MediaQuery.of(context).size.width,
                                            child: Column(

                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(20.0),
                                                  child: Image.asset("assets/images/noData.png"),
                                                ),
                                                SizedBox(height: 20,),
                                                Text(Localizations.localeOf(context).languageCode == "en"
                                                    ?"There are no cars compatible with your request yet.":"لا يوجد سيارات متوافقه مع طلبك حتى الآن",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(

                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,

                                                  ),),
                                              ],
                                            ))
                                                :Container(
                                          width: Get.width*0.9,
                                          height: Get.height*0.5,
                                          decoration: const BoxDecoration(
                                              color: kWhiteColor,
                                              borderRadius:BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                bottomLeft: Radius.circular(20),
                                              )
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: controller.carData!.map((e) =>
                                                    CarRequestResultWidget(carData: e,),
                                                ).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10,),

                                ],
                              ),
                              const SizedBox(
                                height:10
                              ),
                              Center(
                                child: InkWell(
                                  onTap: (){
                                    controller.pausingCarRequest(context,widget.carData?.id?.toString()??"");


                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width:Get.width*0.8,
                                      height:Get.height*0.09,

                                      decoration: BoxDecoration(

                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(color: kDarkGreenColor,width: 2)

                                      ),
                                      child:Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(

                                          decoration: BoxDecoration(
                                            color: kDarkBlueColor,
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          child:  Center(child: CustomText(
                                            "أخفاء الطلب",
                                            style:  TextStyle(
                                              fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                              color: kWhiteColor,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15,
                                              height: 1,
                                              letterSpacing: -1,
                                            ),
                                          )
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ]
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
    );
  }
}
