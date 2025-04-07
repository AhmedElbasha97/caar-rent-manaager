import 'package:carrentmanger/Widget/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/colors.dart';
import '../../Utils/constant.dart';
import '../../Utils/localization_services.dart';
import '../../Utils/memory.dart';
import '../../Utils/translation_key.dart';
import '../../Widget/custom_text_widget.dart';
import '../../Widget/drawer_widget.dart';

import 'controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(

      init:  ProfileController(context),
      builder: (ProfileController controller) =>  Scaffold(
        key: controller.scaffoldState,
        drawer:  DrawerWidget(scaffoldKey: controller.scaffoldState,),
        body: SafeArea(

          child:controller.isLoading?const Loader(): Container(
            width: Get.width,
            height: Get.height,
            decoration: const BoxDecoration(
                color: kDarkGreenColor
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
                        Container(
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
                                                drawerTag4.tr,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w900,
                                                  fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                  foreground: Paint()
                                                    ..style = PaintingStyle.stroke
                                                    ..strokeWidth =2
                                                    ..color = kWhiteColor,
                                                ),
                                              ),
                                              // The text inside
                                              CustomText(
                                                drawerTag4.tr,
                                                textAlign: TextAlign.center,
                                                style:  TextStyle(
                                                  fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                  color: kLightGreenColor,
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
                        Container(
                          color: kWhiteColor,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    width: Get.width,
                                    decoration:  const BoxDecoration(
                                        color: kDarkGreenColor,
                                        borderRadius:BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                        )
                                    ),
                                    child: Padding(
                                      padding:  EdgeInsets.symmetric(vertical: Get.height*0.025),
                                      child: Container(
                                        color: kWhiteColor,
                                        height: Get.height*0.2,
                                        width: Get.width,
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 10,),
                                            Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: Container(
                                                width: Get.width*0.31,
                                                height: Get.height*0.17,
                                                decoration:  BoxDecoration(
                                                  color: kDarkGreenColor,
                                                  borderRadius: BorderRadius.circular(20.0),
                                                ),
                                                child:Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(20), // Image border
                                                    child: SizedBox.fromSize(
                                                      size: const Size.fromRadius(20), // Image radius
                                                      child: Container(color:kWhiteColor,child: Image.asset('assets/images/app_logo.png', fit: BoxFit.fill)),
                                                    ),
                                                  ),
                                                ),

                                              ),
                                            ),
                                            const SizedBox(width: 10,),
                                            Expanded(
                                              flex: 1,
                                              child: Container(

                                                height: Get.height*0.17,
                                                decoration: const BoxDecoration(
                                                    color: kDarkGreenColor,
                                                    borderRadius:BorderRadius.only(
                                                      topRight: Radius.circular(20),
                                                      bottomRight: Radius.circular(20),
                                                    )
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      CustomText(
                                                        Get.find<StorageService>().activeLocale == SupportedLocales.english?"name:":"اسم:",
                                                        style:  TextStyle(
                                                          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                          color: kWhiteColor,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5,),
                                                      Center(
                                                        child: CustomText(
                                                          controller.profileData?.info?.name??"",
                                                          style:  TextStyle(
                                                            fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                            color: kWhiteColor,
                                                            fontSize: 12,

                                                          ),
                                                        ),
                                                      ),
                                                      CustomText(Get.find<StorageService>().activeLocale == SupportedLocales.english?"Email address:":"البريد الألكترونى:",
                                                        style:  TextStyle(
                                                          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                          color: kWhiteColor,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5,),
                                                      Center(
                                                        child: CustomText(
                                                          controller.profileData?.info?.email??"",
                                                          maxLines: 2,
                                                          style:  TextStyle(

                                                            fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                            color: kWhiteColor,
                                                            fontSize: 12,

                                                          ),
                                                        ),
                                                      ),
                                                      CustomText(Get.find<StorageService>().activeLocale == SupportedLocales.english?"phone number:":"التلفون:",
                                                        style:  TextStyle(
                                                          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                          color: kWhiteColor,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5,),
                                                      Center(
                                                        child: CustomText(
                                                          Get.find<StorageService>().activeLocale == SupportedLocales.english?"(+${controller.profileData?.info?.phoneCode??""})${controller.profileData?.info?.phone??""}":"${controller.profileData?.info?.phone??""}(${controller.profileData?.info?.phoneCode??""}+)",
                                                          style:  TextStyle(
                                                            fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                            color: kWhiteColor,
                                                            fontSize: 12,

                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
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
                        color: kWhiteColor,
                        borderRadius:BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )
                    ),
                    child:  RawScrollbar(
                      thumbColor: kDarkGreenColor,
                      radius: const Radius.circular(20),
                      thickness: 5,
                      controller: controller.scrollController,
                      child: Padding(
                        padding:  EdgeInsets.only(top: Get.height*0.06),
                        child: SingleChildScrollView(
                          controller: controller.scrollController,
                          child: Container(
                            height: Get.height*0.6,
                            child: Column(

                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                                InkWell(
                                  onTap: (){
                                    controller.changeLanguage();
                                  },
                                  child: ListTile(
                                    title: CustomText(
                                      translateKey.tr,
                                      style:  TextStyle(
                                        fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                        color: kDarkGreenColor,
                                        fontSize: 14,
                                        letterSpacing: 0,

                                      ),
                                    ),

                                    leading:  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: Get.width*0.2,
                                        height: Get.height*0.1,

                                        decoration: BoxDecoration(

                                            borderRadius: BorderRadius.circular(50),
                                            border: Border.all(color:kDarkGreenColor,width: 2)

                                        ),
                                        child:Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(

                                            decoration: BoxDecoration(
                                              color: kWhiteColor,
                                              borderRadius: BorderRadius.circular(50),
                                            ),
                                            child:  const Center(child: Icon(Icons.translate_rounded, color:kDarkGreenColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ),
                                ),

                                const Divider(
                                  color: kDarkGreenColor,
                                  height: 1,
                                  thickness: 2,
                                  endIndent: 0,
                                  indent: 0,
                                ),
                                InkWell(
                                  onTap: (){
                                    controller.loggingOut();
                                  },
                                  child: ListTile(
                                    title: CustomText(
                                      Get.find<StorageService>().activeLocale == SupportedLocales.english?"logging out":"تسجيل خروج",
                                      style:  TextStyle(
                                        fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                        color: kDarkGreenColor,
                                        fontSize: 14,
                                        letterSpacing: 0,

                                      ),
                                    ),

                                    leading:  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: Get.width*0.2,
                                        height: Get.height*0.1,

                                        decoration: BoxDecoration(

                                            borderRadius: BorderRadius.circular(50),
                                            border: Border.all(color:kDarkGreenColor,width: 2)

                                        ),
                                        child:Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(

                                            decoration: BoxDecoration(
                                              color: kWhiteColor,
                                              borderRadius: BorderRadius.circular(50),
                                            ),
                                            child:  const Center(child: Icon(Icons.logout, color:kDarkGreenColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ),
                                ),
                                const Divider(
                                  color: kDarkGreenColor,
                                  height: 1,
                                  thickness: 2,
                                  endIndent: 0,
                                  indent: 0,
                                ),
                                InkWell(
                                  onTap: (){
                                    controller.deletingAccount(context);
                                  },
                                  child: ListTile(
                                    title: CustomText(
                                      Get.find<StorageService>().activeLocale == SupportedLocales.english?"deleting the account":"  حذف الحساب ",
                                      style:  TextStyle(
                                        fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                        color: kDarkGreenColor,
                                        fontSize: 14,
                                        letterSpacing: 0,

                                      ),
                                    ),

                                    leading:  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: Get.width*0.2,
                                        height: Get.height*0.1,

                                        decoration: BoxDecoration(

                                            borderRadius: BorderRadius.circular(50),
                                            border: Border.all(color:kDarkGreenColor,width: 2)

                                        ),
                                        child:Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(

                                            decoration: BoxDecoration(
                                              color: kWhiteColor,
                                              borderRadius: BorderRadius.circular(50),
                                            ),
                                            child:  const Center(child: Icon(Icons.delete, color:kDarkGreenColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ),
                                ),
                                const Divider(
                                  color: kDarkGreenColor,
                                  height: 1,
                                  thickness: 2,
                                  endIndent: 0,
                                  indent: 0,
                                ),
                                const SizedBox(height: 10,)
                              ],

                            ),
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
