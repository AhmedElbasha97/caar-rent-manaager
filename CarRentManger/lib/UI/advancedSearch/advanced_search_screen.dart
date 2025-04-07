// ignore_for_file: avoid_unnecessary_containers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrentmanger/Utils/services.dart';
import 'package:carrentmanger/Utils/translation_key.dart';
import 'package:carrentmanger/Widget/loader.dart';
import 'package:carrentmanger/models/category_model.dart';
import 'package:carrentmanger/models/country_code_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/colors.dart';
import '../../Utils/constant.dart';
import '../../Utils/localization_services.dart';
import '../../Utils/memory.dart';
import '../../Widget/custom_text_widget.dart';
import '../../Widget/drawer_widget.dart';
import 'controller/advanced_search_controller.dart';

class AdvancedSearchScreen extends StatelessWidget {
  const AdvancedSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  AdvancedSearchController(context),
      builder: (AdvancedSearchController controller) =>  SafeArea(
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
                                                    advancedSearch.tr,
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
                                                    advancedSearch.tr,
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
                controller.isLoading? Loader(height: Get.height*0.84,):Container(
                  height: Get.height*0.84,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child:  RawScrollbar(
                            thumbColor: kDarkGreenColor,
                            radius: const Radius.circular(20),
                            thickness: 5,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: CustomText(
                                          textAlign: TextAlign.center,
                                          maxLines: 3,
                                          "${
                                              Get.find<StorageService>().activeLocale ==
                                                  SupportedLocales.english
                                                  ? "county"
                                                  : "الدوله"
                                          } : ",
                                          style: TextStyle(
                                            shadows: <Shadow>[
                                              Shadow(
                                                  offset:
                                                  const Offset(0.5, 0.5),
                                                  blurRadius: 0.5,
                                                  color: Colors.black
                                                      .withValues(alpha:0.5)),
                                            ],
                                            fontSize: 13,
                                            letterSpacing: 0,
                                            fontFamily:
                                            Get.find<StorageService>()
                                                .activeLocale ==
                                                SupportedLocales.english
                                                ? fontFamilyEnglishName
                                                : fontFamilyArabicName,
                                            color: kDarkGreenColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),

                                      Center(
                                        child: InkWell(
                                            onTap: (){
                                               controller.choosingCountryCode(context);
                                        },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width:Get.width*0.9,
                                              height:Get.height*0.06,

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
                                                  child:
                                                  Center(child:
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      controller.chosenCountry == null?CustomText(
                                                        Get.find<StorageService>().activeLocale == SupportedLocales.english?"choose county":"أختر الدوله",
                                                        style:  TextStyle(
                                                          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                          color: kWhiteColor,
                                                          fontSize: 15,
                                                          height: 1,
                                                          letterSpacing: -1,
                                                        ),
                                                      ):Row(
                                                        children: [
                                                          CustomText(
                                                            Get.find<StorageService>().activeLocale == SupportedLocales.english?"choose county:":"الدوله المختاره:",
                                                            style:  TextStyle(
                                                              fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                              color: kWhiteColor,
                                                              fontSize: 15,
                                                              height: 1,
                                                              letterSpacing: -1,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          CachedNetworkImage(
                                                            imageUrl:"${Services.baseEndPoint}${controller.chosenCountry?.flag}",
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
                                                                        fit: BoxFit.fitHeight,
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
                                                            controller.chosenCountry?.name??"",
                                                            style:  TextStyle(
                                                              fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                              color: kWhiteColor,
                                                              fontSize: 15,
                                                              height: 1,
                                                              letterSpacing: -1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(width: 10,),
                                                      const Icon(Icons.arrow_drop_down_circle_outlined,color: kWhiteColor,),
                                                    ],
                                                  )
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  controller.chosenCountry == null?const SizedBox():
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10,),


                                       Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: CustomText(
                                            textAlign: TextAlign.center,
                                            maxLines: 3,
                                            "${
                                                Get.find<StorageService>().activeLocale ==
                                                    SupportedLocales.english
                                                    ? "city"
                                                    : "المدينه"
                                            } : ",
                                            style: TextStyle(
                                              shadows: <Shadow>[
                                                Shadow(
                                                    offset:
                                                    const Offset(0.5, 0.5),
                                                    blurRadius: 0.5,
                                                    color: Colors.black
                                                        .withValues(alpha:0.5)),
                                              ],
                                              fontSize: 13,
                                              letterSpacing: 0,
                                              fontFamily:
                                              Get.find<StorageService>()
                                                  .activeLocale ==
                                                  SupportedLocales.english
                                                  ? fontFamilyEnglishName
                                                  : fontFamilyArabicName,
                                              color: kDarkGreenColor,
                                            ),
                                          ),
                                        ),

                                      const SizedBox(height: 10,),

                                      InkWell(
                                        onTap: (){
                                          controller.choosingCities(context);
                                        },
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width:Get.width*0.9,
                                              height:Get.height*0.06,

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
                                                  child:
                                                  Center(child:
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      controller.chosenCity == null?CustomText(
                                                        Get.find<StorageService>().activeLocale == SupportedLocales.english?"choose city":"إختر المدينه",
                                                        style:  TextStyle(
                                                          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                          color: kWhiteColor,
                                                          fontSize: 15,
                                                          height: 1,
                                                          letterSpacing: -1,
                                                        ),
                                                      ):Row(
                                                        children: [
                                                          CustomText(
                                                            Get.find<StorageService>().activeLocale == SupportedLocales.english?"chosen city:":"المدينه المختاره:",
                                                            style:  TextStyle(
                                                              fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                              color: kWhiteColor,
                                                              fontSize: 15,
                                                              height: 1,
                                                              letterSpacing: -1,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          CustomText(
                                                            controller.chosenCity?.name??"",
                                                            style:  TextStyle(
                                                              fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                              color: kWhiteColor,
                                                              fontSize: 15,
                                                              height: 1,
                                                              letterSpacing: -1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(width: 10,),
                                                      const Icon(Icons.arrow_drop_down_circle_outlined,color: kWhiteColor,),
                                                    ],
                                                  )
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  controller.chosenCity == null?const SizedBox():
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: CustomText(
                                          textAlign: TextAlign.center,
                                          maxLines: 3,
                                          "${
                                              Get.find<StorageService>().activeLocale ==
                                                  SupportedLocales.english
                                                  ? "car brand"
                                                  : "ماركة السيارة"
                                          } : ",
                                          style: TextStyle(
                                            shadows: <Shadow>[
                                              Shadow(
                                                  offset:
                                                  const Offset(0.5, 0.5),
                                                  blurRadius: 0.5,
                                                  color: Colors.black
                                                      .withValues(alpha:0.5)),
                                            ],
                                            fontSize: 13,
                                            letterSpacing: 0,
                                            fontFamily:
                                            Get.find<StorageService>()
                                                .activeLocale ==
                                                SupportedLocales.english
                                                ? fontFamilyEnglishName
                                                : fontFamilyArabicName,
                                            color: kDarkGreenColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),

                                      InkWell(
                                          onTap: (){
                                            controller.choosingCarBrands(context);
                                          },
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width:Get.width*0.9,
                                              height:Get.height*0.06,
                                        
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
                                                  child:
                                                  Center(child:
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      controller.chosenCarBrand == null?CustomText(
                                                        Get.find<StorageService>().activeLocale == SupportedLocales.english?"choose car brand":"إختر ماركة السيارة",
                                                        style:  TextStyle(
                                                          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                          color: kWhiteColor,
                                                          fontSize: 15,
                                                          height: 1,
                                                          letterSpacing: -1,
                                                        ),
                                                      ):Row(
                                                        children: [
                                                          CustomText(
                                                            Get.find<StorageService>().activeLocale == SupportedLocales.english?"chosen car brand:":"ماركة السيارة المختاره:",
                                                            style:  TextStyle(
                                                              fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                              color: kWhiteColor,
                                                              fontSize: 15,
                                                              height: 1,
                                                              letterSpacing: -1,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          CustomText(
                                                            controller.chosenCarBrand?.name??"",
                                                            style:  TextStyle(
                                                              fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                              color: kWhiteColor,
                                                              fontSize: 15,
                                                              height: 1,
                                                              letterSpacing: -1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(width: 10,),
                                                      const Icon(Icons.arrow_drop_down_circle_outlined,color: kWhiteColor,),
                                                    ],
                                                  )
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  controller.chosenCarBrand == null?const SizedBox():
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: CustomText(
                                          textAlign: TextAlign.center,
                                          maxLines: 3,
                                          "${
                                              Get.find<StorageService>().activeLocale ==
                                                  SupportedLocales.english
                                                  ? "car moadel"
                                                  : "طراز السيارة"
                                          } : ",
                                          style: TextStyle(
                                            shadows: <Shadow>[
                                              Shadow(
                                                  offset:
                                                  const Offset(0.5, 0.5),
                                                  blurRadius: 0.5,
                                                  color: Colors.black
                                                      .withValues(alpha:0.5)),
                                            ],
                                            fontSize: 13,
                                            letterSpacing: 0,
                                            fontFamily:
                                            Get.find<StorageService>()
                                                .activeLocale ==
                                                SupportedLocales.english
                                                ? fontFamilyEnglishName
                                                : fontFamilyArabicName,
                                            color: kDarkGreenColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),

                                      InkWell(
                                          onTap:(){
                                          controller.choosingCarModels(context);
                                          },
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width:Get.width*0.9,
                                              height:Get.height*0.06,

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
                                                  child:
                                                  Center(child:
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      controller.chosenCarBrand == null?CustomText(
                                                        Get.find<StorageService>().activeLocale == SupportedLocales.english?"choose car brand":"إختر طراز السيارة",
                                                        style:  TextStyle(
                                                          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                          color: kWhiteColor,
                                                          fontSize: 15,
                                                          height: 1,
                                                          letterSpacing: -1,
                                                        ),
                                                      ):Row(
                                                        children: [
                                                          CustomText(
                                                            Get.find<StorageService>().activeLocale == SupportedLocales.english?"chosen car model:":"طراز السيارة المختاره:",
                                                            style:  TextStyle(
                                                              fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                              color: kWhiteColor,
                                                              fontSize: 15,
                                                              height: 1,
                                                              letterSpacing: -1,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          CustomText(
                                                            controller.chosenCarModel?.name??"",
                                                            style:  TextStyle(
                                                              fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                              color: kWhiteColor,
                                                              fontSize: 15,
                                                              height: 1,
                                                              letterSpacing: -1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(width: 10,),
                                                      const Icon(Icons.arrow_drop_down_circle_outlined,color: kWhiteColor,),
                                                    ],
                                                  )
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  controller.chosenCarModel == null?const SizedBox():
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: CustomText(
                                          textAlign: TextAlign.center,
                                          maxLines: 3,
                                          "${
                                              Get.find<StorageService>().activeLocale ==
                                                  SupportedLocales.english
                                                  ? "Rental period"
                                                  : "فتره الأيجار"
                                          } : ",
                                          style: TextStyle(
                                            shadows: <Shadow>[
                                              Shadow(
                                                  offset:
                                                  const Offset(0.5, 0.5),
                                                  blurRadius: 0.5,
                                                  color: Colors.black
                                                      .withValues(alpha:0.5)),
                                            ],
                                            fontSize: 13,
                                            letterSpacing: 0,
                                            fontFamily:
                                            Get.find<StorageService>()
                                                .activeLocale ==
                                                SupportedLocales.english
                                                ? fontFamilyEnglishName
                                                : fontFamilyArabicName,
                                            color: kDarkGreenColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),

                                      Center(
                                        child: InkWell(
                                          
                                          onTap:(){
                                            controller.choosingWithPeriods(context);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width:Get.width*0.9,
                                              height:Get.height*0.06,
                                          
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
                                                  child:
                                                  Center(child:
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      controller.chosenPeriod.isEmpty ?CustomText(
                                                        Get.find<StorageService>().activeLocale == SupportedLocales.english?"choose Rental period":"إختر فتره الأيجار",
                                                        style:  TextStyle(
                                                          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                          color: kWhiteColor,
                                                          fontSize: 15,
                                                          height: 1,
                                                          letterSpacing: -1,
                                                        ),
                                                      ):Row(
                                                        children: [
                                                          CustomText(
                                                            Get.find<StorageService>().activeLocale == SupportedLocales.english?"chosen Rental period:":"فتره الأيجار المختاره:",
                                                            style:  TextStyle(
                                                              fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                              color: kWhiteColor,
                                                              fontSize: 15,
                                                              height: 1,
                                                              letterSpacing: -1,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          CustomText(
                                                            controller.returnChosenPeriods(),
                                                            style:  TextStyle(
                                                              fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                              color: kWhiteColor,
                                                              fontSize: 15,
                                                              height: 1,
                                                              letterSpacing: -1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(width: 10,),
                                                      const Icon(Icons.arrow_drop_down_circle_outlined,color: kWhiteColor,),
                                                    ],
                                                  )
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                        ],
                                  ),
                                  controller.chosenPeriod.isEmpty?const SizedBox():
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: CustomText(
                                          textAlign: TextAlign.center,
                                          maxLines: 3,
                                          "${
                                              Get.find<StorageService>().activeLocale ==
                                                  SupportedLocales.english
                                                  ? "driver"
                                                  : "السائق"
                                          } : ",
                                          style: TextStyle(
                                            shadows: <Shadow>[
                                              Shadow(
                                                  offset:
                                                  const Offset(0.5, 0.5),
                                                  blurRadius: 0.5,
                                                  color: Colors.black
                                                      .withValues(alpha:0.5)),
                                            ],
                                            fontSize: 13,
                                            letterSpacing: 0,
                                            fontFamily:
                                            Get.find<StorageService>()
                                                .activeLocale ==
                                                SupportedLocales.english
                                                ? fontFamilyEnglishName
                                                : fontFamilyArabicName,
                                            color: kDarkGreenColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),

                                      InkWell(

                                        onTap:(){
                                          controller.choosingWithDriverOrNot(context);
                                        },
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width:Get.width*0.9,
                                              height:Get.height*0.06,
                                        
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
                                                  child:
                                                  Center(child:
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      controller.chosenWithDriver.isEmpty?CustomText(
                                                        Get.find<StorageService>().activeLocale == SupportedLocales.english?"Do you want a car with a driver?":"هل تريد السيارة بسائق؟",
                                                        style:  TextStyle(
                                                          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                          color: kWhiteColor,
                                                          fontSize: 15,
                                                          height: 1,
                                                          letterSpacing: -1,
                                                        ),
                                                      ):Row(
                                                        children: [
                                                          CustomText(
                                                            controller.returnChosenDriverOrNot(),
                                                            style:  TextStyle(
                                                              fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                              color: kWhiteColor,
                                                              fontSize: 15,
                                                              height: 1,
                                                              letterSpacing: -1,
                                                            ),
                                                          ),
                                                          CustomText(
                                                            Get.find<StorageService>().activeLocale == SupportedLocales.english?" , I want a car with a driver:":" , أريد السيارة بسائق",
                                                            style:  TextStyle(
                                                              fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                              color: kWhiteColor,
                                                              fontSize: 15,
                                                              height: 1,
                                                              letterSpacing: -1,
                                                            ),
                                                          ),
                                        
                                                        ],
                                                      ),
                                                      const SizedBox(width: 10,),
                                                      const Icon(Icons.arrow_drop_down_circle_outlined,color: kWhiteColor,),
                                                    ],
                                                  )
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  controller.chosenWithDriver.isEmpty?const SizedBox():
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: CustomText(
                                          textAlign: TextAlign.center,
                                          maxLines: 3,
                                          "${
                                              Get.find<StorageService>().activeLocale ==
                                                  SupportedLocales.english
                                                  ? "History of car manufacturing"
                                                  : " تاريخ صناعه السيارة"
                                          } : ",
                                          style: TextStyle(
                                            shadows: <Shadow>[
                                              Shadow(
                                                  offset:
                                                  const Offset(0.5, 0.5),
                                                  blurRadius: 0.5,
                                                  color: Colors.black
                                                      .withValues(alpha:0.5)),
                                            ],
                                            fontSize: 13,
                                            letterSpacing: 0,
                                            fontFamily:
                                            Get.find<StorageService>()
                                                .activeLocale ==
                                                SupportedLocales.english
                                                ? fontFamilyEnglishName
                                                : fontFamilyArabicName,
                                            color: kDarkGreenColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10,),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: CustomText(
                                              textAlign: TextAlign.center,
                                              maxLines: 3,
                                              "${
                                                  Get.find<StorageService>().activeLocale ==
                                                      SupportedLocales.english
                                                      ? "from"
                                                      : "من"
                                              } : ",
                                              style: TextStyle(
                                                shadows: <Shadow>[
                                                  Shadow(
                                                      offset:
                                                      const Offset(0.5, 0.5),
                                                      blurRadius: 0.5,
                                                      color: Colors.black
                                                          .withValues(alpha:0.5)),
                                                ],
                                                fontSize: 13,
                                                letterSpacing: 0,
                                                fontFamily:
                                                Get.find<StorageService>()
                                                    .activeLocale ==
                                                    SupportedLocales.english
                                                    ? fontFamilyEnglishName
                                                    : fontFamilyArabicName,
                                                color: kDarkGreenColor,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10,),

                                          Center(
                                            child: PopupMenuButton<String>(
                                              constraints: BoxConstraints(
                                                maxWidth: Get.width * 0.8,
                                                minWidth: Get.width * 0.8,
                                              ),
                                              itemBuilder: (context) =>
                                                  controller.listOfYears!.map((e) {
                                                    return PopupMenuItem(
                                                      value: e.year,
                                                      textStyle: TextStyle(
                                                          color: kDarkGreenColor,
                                                          fontFamily:
                                                          Get.find<StorageService>().activeLocale ==
                                                              SupportedLocales.english
                                                              ? fontFamilyEnglishName
                                                              : fontFamilyArabicName,
                                                      ),
                                                      onTap: () {
                                                        controller.choosingYearFrom(e);
                                                      },
                                                      child: SizedBox(
                                                        width: Get.width * 0.8,
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      width: 25,
                                                                      height: 25,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(5),
                                                                          color: Colors.white,
                                                                          boxShadow: const [
                                                                            BoxShadow(
                                                                              color: kGreyColor,
                                                                              blurRadius: 2,
                                                                              offset:
                                                                              Offset(1, 1), // Shadow position
                                                                            ),
                                                                          ],
                                                                          border: Border.all(
                                                                              color: kDarkGreenColor, width: 1)),
                                                                      child: Center(
                                                                        child: Icon(
                                                                          Icons.check_box,
                                                                          color: controller.chosenYearFrom==e
                                                                              ? kDarkGreenColor
                                                                              : Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),

                                                                    CustomText(
                                                                      e?.year??"",
                                                                      style:  TextStyle(
                                                                        fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                                        color: kWhiteColor,
                                                                        fontSize: 15,
                                                                        height: 1,
                                                                        letterSpacing: -1,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            e == controller.listOfYears?.last
                                                                ? const SizedBox()
                                                                : const Divider(
                                                              color: kDarkGreenColor,
                                                              height: 1,
                                                              thickness: 1,
                                                              endIndent: 0,
                                                              indent: 0,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                              color: kDarkBlueColor,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width:Get.width*0.8,
                                                  height:Get.height*0.06,

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
                                                      child:
                                                      Center(child:
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          controller.chosenYearFrom == null?CustomText(
                                                            Get.find<StorageService>().activeLocale == SupportedLocales.english?"from year":"من سنه",
                                                            style:  TextStyle(
                                                              fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                              color: kWhiteColor,
                                                              fontSize: 15,
                                                              height: 1,
                                                              letterSpacing: -1,
                                                            ),
                                                          ):Row(
                                                            children: [
                                                              CustomText(
                                                                Get.find<StorageService>().activeLocale == SupportedLocales.english?"from year":"من سنه",                                                              style:  TextStyle(
                                                                fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                                color: kWhiteColor,
                                                                fontSize: 15,
                                                                height: 1,
                                                                letterSpacing: -1,
                                                              ),
                                                            ),
                                                              SizedBox(width: 5,),
                                                              CustomText(
                                                                controller.chosenYearFrom?.year??"",
                                                                style:  TextStyle(
                                                                  fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                                  color: kWhiteColor,
                                                                  fontSize: 15,
                                                                  height: 1,
                                                                  letterSpacing: -1,
                                                                ),
                                                              ),


                                                            ],
                                                          ),
                                                          const SizedBox(width: 10,),
                                                          const Icon(Icons.arrow_drop_down_circle_outlined,color: kWhiteColor,),
                                                        ],
                                                      )
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10,),

                                      controller.chosenYearFrom == null?SizedBox():Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10,),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: CustomText(
                                              textAlign: TextAlign.center,
                                              maxLines: 3,
                                              "${
                                                  Get.find<StorageService>().activeLocale ==
                                                      SupportedLocales.english
                                                      ? "to"
                                                      : "الى"
                                              } : ",
                                              style: TextStyle(
                                                shadows: <Shadow>[
                                                  Shadow(
                                                      offset:
                                                      const Offset(0.5, 0.5),
                                                      blurRadius: 0.5,
                                                      color: Colors.black
                                                          .withValues(alpha:0.5)),
                                                ],
                                                fontSize: 13,
                                                letterSpacing: 0,
                                                fontFamily:
                                                Get.find<StorageService>()
                                                    .activeLocale ==
                                                    SupportedLocales.english
                                                    ? fontFamilyEnglishName
                                                    : fontFamilyArabicName,
                                                color: kDarkGreenColor,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10,),

                                          Center(
                                            child: PopupMenuButton<String>(
                                              constraints: BoxConstraints(
                                                maxWidth: Get.width * 0.8,
                                                minWidth: Get.width * 0.8,
                                              ),
                                              itemBuilder: (context) =>
                                                  controller.listOfYearsToChosen!.map((e) {
                                                    return PopupMenuItem(
                                                      value: e.year,
                                                      textStyle: TextStyle(
                                                          color: kWhiteColor,
                                                          fontFamily:
                                                          Get.find<StorageService>().activeLocale ==
                                                              SupportedLocales.english
                                                              ? fontFamilyEnglishName
                                                              : fontFamilyArabicName,),
                                                      onTap: () {
                                                        controller.choosingYearTo(e);
                                                      },
                                                      child: SizedBox(
                                                        width: Get.width * 0.8,
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      width: 25,
                                                                      height: 25,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(5),
                                                                          color: Colors.white,
                                                                          boxShadow: const [
                                                                            BoxShadow(
                                                                              color: kGreyColor,
                                                                              blurRadius: 2,
                                                                              offset:
                                                                              Offset(1, 1), // Shadow position
                                                                            ),
                                                                          ],
                                                                          border: Border.all(
                                                                              color: kDarkGreenColor, width: 1)),
                                                                      child: Center(
                                                                        child: Icon(
                                                                          Icons.check_box,
                                                                          color: controller.chosenYearTo==e
                                                                              ? kDarkGreenColor
                                                                              : Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),

                                                                    CustomText(
                                                                      e.year??"",
                                                                      style:  TextStyle(
                                                                        fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                                        color: kWhiteColor,
                                                                        fontSize: 15,
                                                                        height: 1,
                                                                        letterSpacing: -1,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            e == controller.listOfYears?.last
                                                                ? const SizedBox()
                                                                : const Divider(
                                                              color: kDarkGreenColor,
                                                              height: 1,
                                                              thickness: 1,
                                                              endIndent: 0,
                                                              indent: 0,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                              color: kDarkBlueColor,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width:Get.width*0.8,
                                                  height:Get.height*0.06,

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
                                                      child:
                                                      Center(child:
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          controller.chosenYearTo == null?CustomText(
                                                            Get.find<StorageService>().activeLocale == SupportedLocales.english?"to year":"الى سنه",
                                                            style:  TextStyle(
                                                              fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                              color: kWhiteColor,
                                                              fontSize: 15,
                                                              height: 1,
                                                              letterSpacing: -1,
                                                            ),
                                                          ):Row(
                                                            children: [
                                                              CustomText(
                                                                Get.find<StorageService>().activeLocale == SupportedLocales.english?"to year":"الى سنه",                                                              style:  TextStyle(
                                                                fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                                color: kWhiteColor,
                                                                fontSize: 15,
                                                                height: 1,
                                                                letterSpacing: -1,
                                                              ),
                                                              ),
                                                              const SizedBox(width: 5,),
                                                              CustomText(
                                                                controller.chosenYearTo?.year??"",
                                                                style:  TextStyle(
                                                                  fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                                  color: kWhiteColor,
                                                                  fontSize: 15,
                                                                  height: 1,
                                                                  letterSpacing: -1,
                                                                ),
                                                              ),


                                                            ],
                                                          ),
                                                          const SizedBox(width: 10,),
                                                          const Icon(Icons.arrow_drop_down_circle_outlined,color: kWhiteColor,),
                                                        ],
                                                      )
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),


                                ],
                              ),
                            ),
                          ),
                        ),

                        controller.chosenYearTo == null?const SizedBox():Center(
                          child: InkWell(
                            onTap: (){
                              controller.addingOrderForSpecialCar(context);


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
                                      "أضف الطلب",
                                      style:  TextStyle(
                                        fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                        color: kWhiteColor,
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
                        ),
                        const SizedBox(height: 10,),
                      ],
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
