import 'package:carousel_slider/carousel_slider.dart';
import 'package:carrentmanger/Models/car_list_model.dart';
import 'package:carrentmanger/UI/car_rented_details/controller/car_rented_details_controller.dart';
import 'package:carrentmanger/UI/car_rented_details/widget/product_image_widget.dart';
import 'package:carrentmanger/Utils/colors.dart';
import 'package:carrentmanger/Utils/constant.dart';
import 'package:carrentmanger/Utils/localization_services.dart';
import 'package:carrentmanger/Utils/memory.dart';
import 'package:carrentmanger/Utils/translation_key.dart';
import 'package:carrentmanger/Widget/custom_text_widget.dart';
import 'package:carrentmanger/Widget/drawer_widget.dart';
import 'package:carrentmanger/models/car_rented_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarRentedDetailsScreen extends StatefulWidget {
   const CarRentedDetailsScreen({super.key, this.carData});
   final CarRentedModel? carData;

  @override
  State<CarRentedDetailsScreen> createState() => _CarRentedDetailsScreenState();
}

class _CarRentedDetailsScreenState extends State<CarRentedDetailsScreen> {


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
    for (int i = 0; i < (widget.carData?.driver?.length ?? 0 ); i++) {
      theChosenOfWithDriverOrNot = "$theChosenOfWithDriverOrNot ${ Get
          .find<StorageService>()
          .activeLocale ==
          SupportedLocales.english
          ? (listOfWithDriver?[i]?? "") : (listOfWithDriver?[i]?? "")}";
      if ((i + 1) < (widget.carData?.driver?.length ?? 0 )) {
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
      init:  CarRentedDetailsController( widget.carData),
      builder: (CarRentedDetailsController controller) =>  SafeArea(
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
                                                    "تفصيل سيارة مستأجرة",
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
                                                    "تفصيل سيارة مستأجرة",
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
                                GetBuilder<CarRentedDetailsController>(
                                id: "Carsoul",
                                builder: (CarRentedDetailsController controller) {
                                  return Stack(
                                    children: [

                                      CarouselSlider.builder(
                                        carouselController: controller.carouselController,
                                        itemCount: controller.carData?.imgs?.length??0,
                                        itemBuilder: (BuildContext context, int index, int realIndex) {
                                          return ProductImageWidget(imageUrl: controller.carData?.imgs?[index], activeIndex: index, imageTotalCount:"${controller.carData?.imgs?.length??0}",imagesLink:controller.carData?.imgs!);
                                        },
                                        options: CarouselOptions(
                                            height:Get.height*0.5,
                                            autoPlay: true,
                                            enlargeCenterPage: false,
                                            viewportFraction: 1,
                                            onPageChanged: (val, _) {
                                              controller.onImageChange(val);
                                            }
                                        ),
                                      ),
                                      Positioned(
                                        bottom:10,

                                        child: Container(

                                          width:Get.width,
                                          child: Row(
                                            mainAxisAlignment:MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                  children:controller.dotsList
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ); },

                              ),
                                const SizedBox(height: 10,),
                                Row(
                                  children: [

                                    const SizedBox(width: 10,),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: Get.height*0.23,
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
                                                        widget.carData?.make??"",
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
                                                        widget.carData?.model??"",
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
                                                        widget.carData?.year??"",
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
                                                        Get.find<StorageService>().activeLocale == SupportedLocales.english?"Insurance Type:":"نوع التأمين:",
                                                        textAlign: TextAlign.center,
                                                        style:  TextStyle(
                                                          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                          color: kGreyColor,
                                                          fontSize: 15,
                                                          letterSpacing: 0,

                                                        ),

                                                      ),
                                                      CustomText(
                                                        listInsuranceTypes?[widget.carData?.status ?? 0]??"" ,
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
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10,),

                                const SizedBox(
                                    height:10
                                ),
                                Center(
                                  child: InkWell(
                                    onTap: (){
                                      controller.pausingCarRenting(context,widget.carData?.id?.toString()??"");

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
                                              "أنهاء عمليه التأجير",
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

