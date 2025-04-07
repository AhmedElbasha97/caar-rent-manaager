import 'package:carrentmanger/UI/car_rent_list/controller/car_rent_list_controller.dart';
import 'package:carrentmanger/UI/car_rent_list/widget/car_rent_widget.dart';
import 'package:carrentmanger/Utils/colors.dart';
import 'package:carrentmanger/Utils/constant.dart';
import 'package:carrentmanger/Utils/localization_services.dart';
import 'package:carrentmanger/Utils/memory.dart';
import 'package:carrentmanger/Widget/custom_text_widget.dart';
import 'package:carrentmanger/Widget/drawer_widget.dart';
import 'package:carrentmanger/Widget/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarRentListScreen extends StatelessWidget {
  const CarRentListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  CarRentListController(),
      builder: (CarRentListController controller) =>  SafeArea(
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
                                                    "سياراتي المعروضة",
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
                                                    "سياراتي المعروضة",
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
                controller.isLoading?Loader(height: Get.height*0.87,):controller.carData?.isEmpty??true?
                SizedBox(
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
                          ?"There are no cars registered for rent yet.":"لا يوجد سيارات مسجله للأيجار حتى الآن",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,

                        ),),
                    ],
                  ),
                ):Expanded(
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
                      padding: const EdgeInsets.all(8.0),
                      child: RawScrollbar(
                        thumbColor: kDarkBlueColor,
                        radius: const Radius.circular(20),
                        thickness: 5,
                        child: SingleChildScrollView(
                          child: Column(
                            children: controller.carData!.map((e) =>
                                CarRentWidget(carData: e,),
                            ).toList(),
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
