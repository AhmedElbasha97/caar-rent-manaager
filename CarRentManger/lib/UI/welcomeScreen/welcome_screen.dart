import 'package:carrentmanger/UI/signUp/signup_screen.dart';
import 'package:carrentmanger/UI/web_view.dart';
import 'package:carrentmanger/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Utils/constant.dart';
import '../../Utils/localization_services.dart';
import '../../Utils/memory.dart';
import '../../Utils/translation_key.dart';
import '../../Widget/custom_text_widget.dart';
import '../signIn/signin_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  changeLanguage(){
    if(Get
        .find<StorageService>()
        .activeLocale ==
        SupportedLocales.english
    ){
      final Locale newLocale = SupportedLocales.english;

      //in storage
      Get.find<StorageService>().activeLocale = newLocale;

      //in Getx
      Get.updateLocale(newLocale);

    }else{
      final Locale newLocale = SupportedLocales.arabic;
      //in storage
      Get.find<StorageService>().activeLocale = newLocale;

      //in Getx
      Get.updateLocale(newLocale);
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            color: Colors.black.withOpacity(0.01),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: Get.width*0.9,
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
                            Get.find<LocalizationService>().toggleLocale();

                          },

                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  // Implement the stroke
                                  CustomText(
                                    translateKey.tr,
                                    style: TextStyle(
                                      fontSize: 15,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth =1
                                        ..color = kWhiteColor,
                                    ),
                                  ),

                                  // The text inside
                                  CustomText(
                                    translateKey.tr,
                                    style:  TextStyle(
                                      fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                      color: kDarkBlueColor,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15,
                                      letterSpacing: 0,

                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(width: 5,),
                              Container(
                                decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  border: Border.all(color: kDarkBlueColor,width: 2),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Center(child: Icon(Icons.translate_rounded,color: kDarkBlueColor,size: 17,)),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Get.height*0.17,),
                Image.asset("assets/images/app_logo.png",width: Get.width*0.8,height: Get.height*0.3,),
                InkWell(
                  onTap: (){
                    Get.to(()=> const SignInScreen(),transition: Transition.rightToLeftWithFade);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: kLightGreenColor,width: 2)
                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: Get.width*0.8,
                          height: Get.height*0.07,
                          decoration: BoxDecoration(
                            color: kDarkBlueColor,
                              borderRadius: BorderRadius.circular(50),
                          ),
                          child:  Center(
                            child: CustomText(
                              signInBTN.tr,
                              style:  TextStyle(
                                fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                color: kWhiteColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,

                                height: 1,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(height: 5,),
                InkWell(
                  onTap: (){
                    Get.to(()=>const SignUpScreen(),transition: Transition.leftToRightWithFade);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: kLightGreenColor,width: 2)
                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: Get.width*0.8,
                          height: Get.height*0.07,
                          decoration: BoxDecoration(
                            color: kDarkBlueColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child:  Center(
                            child: CustomText(
                              signUpBTN.tr,
                              style:  TextStyle(
                                fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                color: kWhiteColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,

                                height: 1,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                InkWell(
                  onTap: (){
                    Get.to(()=>const WebViewContainer("https://carrentmanager.com/"),transition: Transition.leftToRightWithFade);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: kLightGreenColor,width: 2)
                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: Get.width*0.8,
                          height: Get.height*0.07,
                          decoration: BoxDecoration(
                            color: kDarkBlueColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child:  Center(
                            child: CustomText(
                              Get.find<StorageService>().activeLocale == SupportedLocales.english?"Enter as a guest":"الدخول كزائر",
                              style:  TextStyle(
                                fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                color: kWhiteColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,

                                height: 1,
                                letterSpacing: -1,
                              ),
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
    );
  }
}
