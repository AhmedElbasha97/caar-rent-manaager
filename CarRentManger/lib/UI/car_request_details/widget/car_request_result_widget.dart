import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrentmanger/UI/car_rented_details/car_rented_details_screen.dart';
import 'package:carrentmanger/UI/web_view.dart';
import 'package:carrentmanger/Utils/colors.dart';
import 'package:carrentmanger/Utils/constant.dart';
import 'package:carrentmanger/Utils/localization_services.dart';
import 'package:carrentmanger/Utils/memory.dart';
import 'package:carrentmanger/Utils/translation_key.dart';
import 'package:carrentmanger/Widget/custom_text_widget.dart';
import 'package:carrentmanger/models/car_requests_result_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CarRequestResultWidget extends StatelessWidget {
  CarRequestResultWidget({super.key, required this.carData});
  final CarRequestResultModel? carData;
  List<String>? listOfWithDriver = Get.find<StorageService>().activeLocale ==
      SupportedLocales.english
      ? ["Yes","No"]
      :["نعم","لا"];
  List<String>? listOfPeriods = Get.find<StorageService>().activeLocale ==
      SupportedLocales.english
      ? ["daily","weekly","monthly","until ownership"]
      :["يومى","أسبوعى","شهرى"," حتى التملك"];
  List<String>? listInsuranceTypes = Get.find<StorageService>().activeLocale ==
      SupportedLocales.english
      ? ["Comprehensive Insurance","Third Party Insurance"]
      :["تأمين شامل","تأمين ضد الغير"];
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
    return InkWell(
      onTap: (){
        Get.to(  WebViewContainer(carData?.link??""));
      },
      child: Center(
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
            child:  Center(
              child: InkWell(
                onTap: (){
                  print("object");
                  Get.to(()=>const CarRentedDetailsScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: Get.width*0.9,
                    height: Get.height*0.22,
                    decoration: BoxDecoration(
                      color:  kDarkGreenColor  ,
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
                                border: Border.all(color: kDarkGreenColor  ,width: 3),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: Get.width*0.52,
                                    height: Get.height*0.22,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              CustomText(
                                                Get.find<StorageService>().activeLocale == SupportedLocales.english?"car brand: ":"ماركة السيارة: ",
                                                textAlign: TextAlign.center,
                                                style:  TextStyle(
                                                  fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                  color: kGreyColor,
                                                  fontSize: 15,
                                                  letterSpacing: 0,

                                                ),

                                              ),
                                              CustomText(
                                                carData?.make ?? "" ,
                                                textAlign: TextAlign.center,
                                                style:  TextStyle(
                                                  fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                  color: kDarkBlueColor,
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
                                                  fontSize: 15,
                                                  letterSpacing: 0,

                                                ),

                                              ),
                                              CustomText(
                                                carData?.model ?? "" ,
                                                textAlign: TextAlign.center,
                                                style:  TextStyle(
                                                  fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                  color: kDarkBlueColor,
                                                  fontSize: 15,
                                                  letterSpacing: 0,

                                                ),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              CustomText(
                                                Get.find<StorageService>().activeLocale == SupportedLocales.english?"Year of manufacture:":"سنة الصنع:",
                                                textAlign: TextAlign.center,
                                                style:  TextStyle(
                                                  fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                  color: kGreyColor,
                                                  fontSize: 15,
                                                  letterSpacing: 0,

                                                ),

                                              ),
                                              CustomText(
                                                carData?.year ?? "" ,
                                                textAlign: TextAlign.center,
                                                style:  TextStyle(
                                                  fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                  color: kDarkBlueColor,
                                                  fontSize: 15,
                                                  letterSpacing: 0,

                                                ),),
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
                          Get.find<StorageService>().activeLocale == SupportedLocales.english?Positioned(
                            right: 15,
                            top: 0,
                            child: Stack(
                              children: [
                                Container(
                                  width: Get.width*0.33,
                                  height: Get.height*0.18,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    width: Get.width*0.31,
                                    height: Get.height*0.17,
                                    decoration:  BoxDecoration(
                                      color:  kDarkGreenColor,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child:CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:  carData?.img??"",
                                      imageBuilder: ((context, image){
                                        return  Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20), // Image border
                                            child: SizedBox.fromSize(
                                              size: const Size.fromRadius(48), // Image radius
                                              child: Container(color:kWhiteColor,decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: image,
                                                  fit:  BoxFit.fill,
                                                ),
                                              )
                                                ,),
                                            ),
                                          ),
                                        );
                                      }),
                                      placeholder: (context, image){
                                        return   Container(
                                          width: Get.width*0.31,
                                          height: Get.height*0.17,
                                          decoration:BoxDecoration(
                                            color:  const Color(0xFFF2F0F3),
                                            borderRadius: BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.1),
                                                offset: const Offset(
                                                  0.0,
                                                  0.0,
                                                ),
                                                blurRadius: 13.0,
                                                spreadRadius: 2.0,
                                              ), //BoxShadow
                                              BoxShadow(
                                                color: Colors.white.withOpacity(0.2),
                                                offset: const Offset(0.0, 0.0),
                                                blurRadius: 0.0,
                                                spreadRadius: 0.0,
                                              ), //BoxShadow
                                            ],
                                          ),
                                          child:Center(
                                            child: Container(
                                              width: Get.width*0.31,
                                              height: Get.height*0.17,
                                              decoration:BoxDecoration(
                                                color:  const Color(0xFFDFDDDF),
                                                borderRadius: BorderRadius.circular(15),

                                              ),
                                            ).animate(onPlay: (controller) => controller.repeat())
                                                .shimmer(duration: 1200.ms, color:  kDarkBlueColor.withAlpha(10))
                                                .animate() // this wraps the previous Animate in another Animate
                                            ,
                                          ),
                                        ).animate(onPlay: (controller) => controller.repeat())
                                            .shimmer(duration: 1200.ms, color:  kDarkBlueColor.withAlpha(10))
                                            .animate() // this wraps the previous Animate in another Animate
                                            ;
                                      },
                                      errorWidget: (context, url, error){
                                        return SizedBox(
                                          width:Get.width,
                                          height:Get.height*0.4,
                                          child: Image.asset("assets/images/app_logo.png",fit: BoxFit.fitHeight,),
                                        );
                                      },
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          ):
                          Positioned(
                            left: 15,
                            top: 0,
                            child: Stack(
                              children: [
                                Container(
                                  width: Get.width*0.33,
                                  height: Get.height*0.18,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    width: Get.width*0.31,
                                    height: Get.height*0.17,
                                    decoration:  BoxDecoration(
                                      color:  kDarkGreenColor,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child:CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:  carData?.img??"",
                                      imageBuilder: ((context, image){
                                        return  Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20), // Image border
                                            child: SizedBox.fromSize(
                                              size: const Size.fromRadius(48), // Image radius
                                              child: Container(color:kWhiteColor,decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: image,
                                                  fit:  BoxFit.fill,
                                                ),
                                              )
                                                ,),
                                            ),
                                          ),
                                        );
                                      }),
                                      placeholder: (context, image){
                                        return   Container(
                                          width: Get.width*0.31,
                                          height: Get.height*0.17,
                                          decoration:BoxDecoration(
                                            color:  const Color(0xFFF2F0F3),
                                            borderRadius: BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.1),
                                                offset: const Offset(
                                                  0.0,
                                                  0.0,
                                                ),
                                                blurRadius: 13.0,
                                                spreadRadius: 2.0,
                                              ), //BoxShadow
                                              BoxShadow(
                                                color: Colors.white.withOpacity(0.2),
                                                offset: const Offset(0.0, 0.0),
                                                blurRadius: 0.0,
                                                spreadRadius: 0.0,
                                              ), //BoxShadow
                                            ],
                                          ),
                                          child:Center(
                                            child: Container(
                                              width: Get.width*0.31,
                                              height: Get.height*0.17,
                                              decoration:BoxDecoration(
                                                color:  const Color(0xFFDFDDDF),
                                                borderRadius: BorderRadius.circular(15),

                                              ),
                                            ).animate(onPlay: (controller) => controller.repeat())
                                                .shimmer(duration: 1200.ms, color:  kDarkBlueColor.withAlpha(10))
                                                .animate() // this wraps the previous Animate in another Animate
                                            ,
                                          ),
                                        ).animate(onPlay: (controller) => controller.repeat())
                                            .shimmer(duration: 1200.ms, color:  kDarkBlueColor.withAlpha(10))
                                            .animate() // this wraps the previous Animate in another Animate
                                            ;
                                      },
                                      errorWidget: (context, url, error){
                                        return Container(
                                          decoration:BoxDecoration(
                                            color: kWhiteColor,
                                            borderRadius: BorderRadius.circular(15),

                                          ),
                                          width:Get.width,
                                          height:Get.height*0.4,
                                          child: Image.asset("assets/images/app_logo.png",fit: BoxFit.fitWidth,),
                                        );
                                      },
                                    ),

                                  ),
                                ),
                              ],
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
        ),
      ),
    );
  }
}