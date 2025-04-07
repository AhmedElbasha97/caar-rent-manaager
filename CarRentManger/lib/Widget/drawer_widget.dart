// ignore_for_file: unused_import


import 'dart:io';

import 'package:carrentmanger/Services/app_info_services.dart';
import 'package:carrentmanger/UI/car_rent_list/car_rent_list_screen.dart';
import 'package:carrentmanger/UI/car_request_list/car_request_list_screen.dart';
import 'package:carrentmanger/UI/homeScreen/home_screen.dart';
import 'package:carrentmanger/UI/privacy_policy/privacy_policy_screen.dart';
import 'package:carrentmanger/UI/profile/profile_screen.dart';
import 'package:carrentmanger/UI/terms_and_condition/terms_and_condition_screen.dart';
import 'package:carrentmanger/Utils/colors.dart';
import 'package:carrentmanger/models/app_department_model.dart';
import 'package:carrentmanger/models/social_link_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Utils/constant.dart';
import '../Utils/localization_services.dart';
import '../Utils/memory.dart';
import '../Utils/translation_key.dart';
import 'custom_text_widget.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key,required this.scaffoldKey});
  final scaffoldKey ;

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool isLoadingSocialLink = true;
  late SocialLinkModel? socialLinkData;
  AppDepartmentModel? data;

  String userName = "";
  @override
  void initState() {
    super.initState();
    getSocialLinks();
    getDepartmentData();

    userName = Get.find<StorageService>().getUserName;
  }

  getDepartmentData() async {
    data = await AppInfoServices.getAppDepartment();

  }
  getSocialLinks() async {
    socialLinkData = await AppInfoServices.getSocialLink();
    await getDepartmentData();
    isLoadingSocialLink = false;
    setState(() {

    });
  }
  launchURL(String url) async {
    final Uri launchUri = Uri.parse(url);
    await launchUrl(launchUri, mode: LaunchMode.externalApplication);
  }
  void shareUrl(String text, BuildContext context){
    try{
      Size size = MediaQuery.of(context).size;
      double screenWidth = size.width;
      double screenHeight = size.height;
      Share.share(text,
          sharePositionOrigin: Rect.fromLTWH(0, 0, screenWidth,
              screenHeight));
    } catch (e) {
      print(e);
    }
  }
  whatsapp(String contact,context) async{
    var iosUrl = "https://wa.me/${contact}?text=&text=لدينا مكتب إيجار سيارات ونريد الإشتراك في موقع وتطبيق \nCar rent manager \nونريد نسخه من برنامج إدارة مكاتب إيجار السيارات" ;
    var androidUrl = "whatsapp://send?phone=${contact}&text=لدينا مكتب إيجار سيارات ونريد الإشتراك في موقع وتطبيق \nCar rent manager \nونريد نسخه من برنامج إدارة مكاتب إيجار السيارات";
    try{
      if(Platform.isIOS){
        await launchUrl(Uri.parse(iosUrl));
      }

      else{
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception{
    }
  }
  @override
  Widget build(BuildContext context) {

    return Drawer(
      backgroundColor: kDarkGreenColor,
      width: Get.width*0.9,
      child: Column(
        children:  [
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
                                    Stack(
                                      children: [
                                        // Implement the stroke
                                        CustomText(
                                          welcomeText.tr,
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
                                          welcomeText.tr,
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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                      child: Stack(
                                        children: [
                                          // Implement the stroke
                                          CustomText(
                                            userName,
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
                                            userName,
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          ColoredBox(
                            color: kDarkGreenColor,
                            child: Container(
                              width: Get.width*0.35,

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

                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child:  Center(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset('assets/images/app_logo.png', fit: BoxFit.fill),
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
                  ColoredBox(
                    color: kWhiteColor,
                    child: Padding(
                      padding: Get.find<StorageService>().activeLocale == SupportedLocales.english?const EdgeInsets.only(left: 3.0): const EdgeInsets.only(left: 3.0),
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
                                  child: const Flex(
                                    direction: Axis.vertical,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: Get.find<StorageService>().activeLocale == SupportedLocales.english?const EdgeInsets.only(left: 2): const EdgeInsets.only(right: 2),
              child: Container(
                width: Get.width,

                decoration:  BoxDecoration(
                    color: kWhiteColor,
                    borderRadius:Get.find<StorageService>().activeLocale == SupportedLocales.english?const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ): const BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              )
                ),
                child:   RawScrollbar(
                  thumbColor: kDarkGreenColor,
                  radius: const Radius.circular(20),
                  thickness: 5,
                  child: SingleChildScrollView(
                    child: Flex(
                      direction: Axis.vertical,
                      children: [

                        InkWell(
                          onTap: (){
                            Get.to(()=>const HomeScreen(),transition:Get.find<StorageService>().activeLocale == SupportedLocales.english?Transition.rightToLeftWithFade:Transition.leftToRightWithFade);
                            widget.scaffoldKey.currentState?.openEndDrawer();
                          },
                          child: ListTile(
                            title: CustomText(
                              drawerTag1.tr,
                              style:  TextStyle(
                                fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                color: kDarkGreenColor,
                                fontSize: 16,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            leading:  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: Get.width*0.1,
                                height: Get.height*0.06,

                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color:kDarkGreenColor,width: 2)

                                ),
                                child:Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(

                                    decoration: BoxDecoration(
                                      color: kWhiteColor,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child:  const Center(child: Icon(Icons.home, color:kDarkGreenColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ),
                        ),
                        const Divider(
                          color: kDarkGreenColor,
                          height: 0.3,
                          thickness: 1,
                          endIndent: 0,
                          indent: 0,
                        ),
                        InkWell(
                          onTap: (){
                           Get.to(()=>const ProfileScreen(),transition: Get.find<StorageService>().activeLocale == SupportedLocales.english?Transition.rightToLeftWithFade:Transition.leftToRightWithFade);
                           widget.scaffoldKey.currentState?.openEndDrawer();
                          },
                          child: ListTile(
                            title: CustomText(
                              drawerTag4.tr,
                              style:  TextStyle(
                                fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                color: kDarkGreenColor,
                                fontSize: 16,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,
                                            ),
                                          ),

                            leading:  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: Get.width*0.1,
                                height: Get.height*0.06,

                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color:kDarkGreenColor,width: 2)

                                ),
                                child:Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(

                                    decoration: BoxDecoration(
                                      color: kWhiteColor,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child:  const Center(child: Icon(Icons.person, color:kDarkGreenColor),
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
                          thickness: 1,
                          endIndent: 0,
                          indent: 0,
                        ),
                        isLoadingSocialLink?Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: Get.width*0.1,
                              height: Get.height*0.06,
                              child: const Center(child: CircularProgressIndicator())),
                        ):(data?.carRentRequest??0) == 0?const SizedBox():InkWell(
                          onTap: (){
                            Get.to(()=>const CarRequestListScreen(),transition: Get.find<StorageService>().activeLocale == SupportedLocales.english?Transition.rightToLeftWithFade:Transition.leftToRightWithFade);
                            widget.scaffoldKey.currentState?.openEndDrawer();
                          },
                          child: ListTile(
                            title: CustomText(
                              Get.find<StorageService>().activeLocale == SupportedLocales.english?"My requests":"طلباتي",
                              style:  TextStyle(
                                fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                color: kDarkGreenColor,
                                fontSize: 16,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,

                              ),
                            ),

                            leading:  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: Get.width*0.1,
                                height: Get.height*0.06,

                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color:kDarkGreenColor,width: 2)

                                ),
                                child:Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(

                                    decoration: BoxDecoration(
                                      color: kWhiteColor,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child:  const Center(child: Icon(Icons.car_crash, color:kDarkGreenColor),
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
                          thickness: 1,
                          endIndent: 0,
                          indent: 0,
                        ),
                        isLoadingSocialLink?Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: Get.width*0.1,
                              height: Get.height*0.06,
                              child: const Center(child: CircularProgressIndicator())),
                        ):(data?.addCars??0) == 0?const SizedBox():InkWell(
                          onTap: (){
                            Get.to(()=>const CarRentListScreen(),transition: Get.find<StorageService>().activeLocale == SupportedLocales.english?Transition.rightToLeftWithFade:Transition.leftToRightWithFade);
                            widget.scaffoldKey.currentState?.openEndDrawer();
                          },
                          child: ListTile(
                            title: CustomText(
                              Get.find<StorageService>().activeLocale == SupportedLocales.english?"Cars on display":"سياراتي المعروضة",
                              style:  TextStyle(
                                fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                color: kDarkGreenColor,
                                fontSize: 16,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,

                              ),
                            ),

                            leading:  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: Get.width*0.1,
                                height: Get.height*0.06,

                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color:kDarkGreenColor,width: 2)

                                ),
                                child:Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(

                                    decoration: BoxDecoration(
                                      color: kWhiteColor,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child:  const Center(child: Icon(Icons.car_rental_rounded, color:kDarkGreenColor),
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
                          thickness: 1,
                          endIndent: 0,
                          indent: 0,
                        ),
                        InkWell(
                          onTap: (){
                            Get.to(()=>const TermsAndConditionScreen(),transition: Get.find<StorageService>().activeLocale == SupportedLocales.english?Transition.rightToLeftWithFade:Transition.leftToRightWithFade);
                            widget.scaffoldKey.currentState?.openEndDrawer();
                          },
                          child: ListTile(
                            title: CustomText(
                              drawerWidget8.tr,
                              style:  TextStyle(
                                fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                color: kDarkGreenColor,
                                fontSize: 16,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,

                              ),
                            ),

                            leading:  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: Get.width*0.1,
                                height: Get.height*0.06,

                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color:kDarkGreenColor,width: 2)

                                ),
                                child:Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(

                                    decoration: BoxDecoration(
                                      color: kWhiteColor,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child:  const Center(child: Icon(Icons.assignment_outlined, color:kDarkGreenColor),
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
                          thickness: 1,
                          endIndent: 0,
                          indent: 0,
                        ),
                        InkWell(
                          onTap: (){
                            Get.to(()=>const PrivacyPolicyScreen(),transition: Get.find<StorageService>().activeLocale == SupportedLocales.english?Transition.rightToLeftWithFade:Transition.leftToRightWithFade);
                            widget.scaffoldKey.currentState?.openEndDrawer();
                          },
                          child: ListTile(
                            title: CustomText(
                              drawerWidget9.tr,
                              style:  TextStyle(
                                fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                color: kDarkGreenColor,
                                fontSize: 16,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,

                              ),
                            ),

                            leading:  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: Get.width*0.1,
                                height: Get.height*0.06,

                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color:kDarkGreenColor,width: 2)

                                ),
                                child:Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child:  const Center(child: Icon(Icons.privacy_tip_outlined, color:kDarkGreenColor),
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
                          thickness: 1,
                          endIndent: 0,
                          indent: 0,
                        ),
                        InkWell(
                          onTap: (){
                            String link =
                                socialLinkData?.android ??"" ;
                            if (Platform.isIOS) {
                              link =
                                  socialLinkData?.ios ??"" ;
                            }
                            shareUrl(link,context);
                            widget.scaffoldKey.currentState?.openEndDrawer();
                          },
                          child: ListTile(
                            title: CustomText(
                              Get.find<StorageService>().activeLocale == SupportedLocales.english?"share the app":"شارك التطبيق",
                              style:  TextStyle(
                                fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                color: kDarkGreenColor,
                                fontSize: 16,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,

                              ),
                            ),

                            leading:  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: Get.width*0.1,
                                height: Get.height*0.06,

                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color:kDarkGreenColor,width: 2)

                                ),
                                child:Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(

                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child:  const Center(child: Icon(Icons.share, color:kDarkGreenColor),
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
                          thickness: 1,
                          endIndent: 0,
                          indent: 0,
                        ),
                        InkWell(
                          onTap: (){
                            launchURL("https://mohamed-nagah.com/our-projects/");
                            widget.scaffoldKey.currentState?.openEndDrawer();
                          },
                          child: ListTile(
                            title: CustomText(
                              Get.find<StorageService>().activeLocale == SupportedLocales.english?"our apps":"برامجنا",
                              style:  TextStyle(
                                fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                color: kDarkGreenColor,
                                fontSize: 16,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,

                              ),
                            ),

                            leading:  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: Get.width*0.1,
                                height: Get.height*0.06,

                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color:kDarkGreenColor,width: 2)

                                ),
                                child:Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(

                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child:  const Center(child: Icon(Icons.app_shortcut_outlined, color:kDarkGreenColor),
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
                          thickness: 1,
                          endIndent: 0,
                          indent: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          ColoredBox(
            color: kWhiteColor,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                width: Get.width,
                decoration:  const BoxDecoration(
                    color: kDarkGreenColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                    )
                ),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    ColoredBox(
                    color: kWhiteColor,
                    child: Padding(
                      padding: Get.find<StorageService>().activeLocale == SupportedLocales.english?const EdgeInsets.only(left: 3.0): const EdgeInsets.only(left: 3.0),

                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                width: Get.width,

                                decoration:  BoxDecoration(
                                    color: kDarkGreenColor,
                                    borderRadius:Get.find<StorageService>().activeLocale == SupportedLocales.english?const BorderRadius.only(
                                      bottomRight: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ): const BorderRadius.only(
                                      bottomLeft: Radius.circular(30),
                                      topLeft: Radius.circular(30),
                                    )
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(vertical: Get.height*0.01),
                                  child: Flex(
                                    direction: Axis.vertical,
                                    children: [
                                      isLoadingSocialLink?const Center(child: CircularProgressIndicator()):Flex(
                                        direction: Axis.horizontal,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              launchURL(socialLinkData?.facebook??"");
                                            },
                                            child: Image.asset(
                                              "assets/images/facebook.png",
                                              scale: 1.5,
                                            ),
                                          ),
                                           InkWell(
                                            onTap: (){
                                              launchURL(socialLinkData?.instagram??"");
                                            },
                                            child: Image.asset(
                                              "assets/images/instagram.png",
                                              scale: 1.5,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              launchURL(socialLinkData?.x??"");
                                            },
                                            child: Image.asset(
                                              "assets/images/twitter.png",
                                              scale: 1.5,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                             whatsapp(socialLinkData?.whatsapp??"", context);
                                            },
                                            child: Image.asset(
                                              "assets/images/whatsapp.png",
                                              scale: 1.5,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              launchURL(socialLinkData?.youtube??"");
                                            },
                                            child: Image.asset(
                                              "assets/images/youtube.png",
                                              scale: 1.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: CustomText(
                                          policy1.tr,
                                          style:  TextStyle(
                                            fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                            color: kWhiteColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,

                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Row(
                                          children: [
                                          CustomText(policy2.tr,
                                          style:  TextStyle(
                                            fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                            color: kWhiteColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                          ),
                                            InkWell(
                                              onTap: () => launchURL("https://syncqatar.com"),
                                              child:  CustomText(
                                                policy3.tr,
                                                style:  TextStyle(
                                                  fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                  color: kDarkBlueColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              ),

                                          ],
                                          ),
                                        ),


                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),


                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );

  }
}
