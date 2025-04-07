import 'package:carrentmanger/UI/aadding_car_for_rent/adding_car_for_rent_screen.dart';
import 'package:carrentmanger/UI/advancedSearch/advanced_search_screen.dart';
import 'package:carrentmanger/UI/homeScreen/controller/home_controller.dart';
import 'package:carrentmanger/UI/web_view.dart';
import 'package:carrentmanger/Utils/colors.dart';
import 'package:carrentmanger/Widget/drawer_widget.dart';
import 'package:carrentmanger/Widget/loader.dart';


import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../Utils/constant.dart';
import '../../Utils/localization_services.dart';
import '../../Utils/memory.dart';
import '../../Utils/translation_key.dart';
import '../../Widget/custom_text_widget.dart';

import 'widgets/search_type_widget.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   String userName = "";
   @override
   void initState() {
     super.initState();
     userName = Get.find<StorageService>().getUserName;
   }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(context),
      builder: (controller) => SafeArea(
        child: Scaffold(
          key: controller.scaffoldState,
          drawer:  DrawerWidget(scaffoldKey: controller.scaffoldState,),
          body:  ColoredBox(color: kDarkGreenColor,

            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              ColoredBox(
                  color: kWhiteColor,
                  child: Container(
                    width: Get.width,
                    decoration:  const BoxDecoration(
                        color: kDarkGreenColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                        )
                    ),
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        ColoredBox(
                          color: kWhiteColor,
                          child: IntrinsicHeight(
                            child: Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,

                              children: [
                                Expanded(
                                  flex:1,
                                  child: Container(
                                    decoration:  BoxDecoration(
                                        color: kDarkGreenColor,
                                  borderRadius:Get.find<StorageService>().activeLocale == SupportedLocales.english?const BorderRadius.only(
                                    topRight: Radius.circular(30),
                                  ): const BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                  )
                                                        ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),

                                      child: Flex(
                                        direction: Axis.vertical,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        CustomText(
                                        welcomeText.tr,
                                        style:  TextStyle(
                                          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                          color: kWhiteColor,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 20,
                                          letterSpacing: 0,

                                        ),
                                      ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                            child:  CustomText(
                                                userName,
                                                style:  TextStyle(
                                                  fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                  color: kWhiteColor,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 20,
                                                  letterSpacing: 0,

                                                ),
                                            ),
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
                                  child: ColoredBox(
                                    color: kDarkGreenColor,
                                    child: Container(
                                      width: Get.width*0.25,

                                      decoration:  BoxDecoration(
                                          color: kWhiteColor,
                                          borderRadius: Get.find<StorageService>().activeLocale == SupportedLocales.english?const BorderRadius.only(
                                            bottomLeft: Radius.circular(30),
                                          ):const BorderRadius.only(
                                            bottomRight: Radius.circular(30),
                                          )
                                      ),
                                    child:  Center(
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
                                )

                              ],
                            ),
                          ),
                        ),
                        ColoredBox(
                          color: kWhiteColor,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                  child: Container(
                                    width: Get.width,

                                    decoration:  BoxDecoration(
                                        color: kDarkGreenColor,
                                        borderRadius:Get.find<StorageService>().activeLocale == SupportedLocales.english?const BorderRadius.only(
                                          topRight: Radius.circular(30),
                                        ): const BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                        )
                                    ),
                                    child: Padding(
                                      padding:  EdgeInsets.symmetric(vertical: Get.height*0.025),
                                      child: Flex(
                                        direction: Axis.vertical,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: controller.isLoading? Loader(height: Get.height*0.8,):Container(
                    width: Get.width,

                    decoration:  BoxDecoration(
                        color: kWhiteColor,
                        borderRadius:Get.find<StorageService>().activeLocale == SupportedLocales.english?const BorderRadius.only(
                      topLeft: Radius.circular(30),
                    ): const BorderRadius.only(
                      topRight: Radius.circular(30),
                    )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RawScrollbar(
                        controller: controller.scrollController,
                        thumbColor: kDarkGreenColor,
                        radius: const Radius.circular(20),
                        thickness: 5,
                        child: SingleChildScrollView(
                          controller: controller.scrollController,
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              (controller.data?.siteCars??0) == 0?const SizedBox():InkWell(
                                  onTap: (){
                                    Get.to(  WebViewContainer("https://carrentmanager.com?user_id=${Get.find<StorageService>().getId}"));
                                  },
                                  child: SearchTypeWidget(title: showCarsByCategories.tr,imgPath: "showCars.png",)),
                              const SizedBox(height: 10,),
                              (controller.data?.carRentRequest??0) == 0?const SizedBox():InkWell(
                                onTap: (){
                                  Get.to(()=> const AdvancedSearchScreen());
                                },
                                child: Center(
                                    child: SearchTypeWidget(title: advancedSearch.tr,imgPath: "searchingForSpecialCar.png",)),
                              ),
                              const SizedBox(height: 10,),
                              (controller.data?.addCars??0) == 0?const SizedBox():InkWell(
                                onTap: (){
                                  Get.to(()=> const AddingCarForRentScreen());
                                },
                                child: Center(
                                    child: SearchTypeWidget(title: addingCarToRent.tr,imgPath: "adddingCarToRent.png",)),
                              ),
                              const SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
