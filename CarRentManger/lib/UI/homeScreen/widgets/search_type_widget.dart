// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/colors.dart';
import '../../../Utils/constant.dart';
import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../../Widget/custom_text_widget.dart';

class SearchTypeWidget extends StatelessWidget {
  final String title;
  final String  imgPath;
  const SearchTypeWidget({Key? key, required this.title, required this.imgPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: Get.width*0.9,
      height: Get.height*0.19,
      decoration:  const BoxDecoration(
        color: Colors.transparent,

      ),
      child: Stack(
        children: [
          SizedBox(
            width: Get.width*0.9,
            height: Get.height*0.2,
          ),
          Get.find<StorageService>().activeLocale == SupportedLocales.english?Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: Get.width*0.85,
                height: Get.height*0.12,
                decoration:   BoxDecoration(
                  color: kDarkGreenColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        width: Get.width*0.45,
                        child: CustomText(
                          title,
                          style:  TextStyle(
                            fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                            color: kWhiteColor,
                            fontSize: 20,

                            height: 1,
                            letterSpacing: -1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ):Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: Get.width*0.85,
                height: Get.height*0.12,
                decoration:   BoxDecoration(
                  color: kDarkGreenColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        width: Get.width*0.45,
                        child: CustomText(
                          title,
                          textAlign: TextAlign.center,
                          style:  TextStyle(
                            fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                            color: kWhiteColor,
                            fontSize: 20,

                            height: 1.2,
                            letterSpacing: -1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ),
          Get.find<StorageService>().activeLocale == SupportedLocales.english? Positioned(
            right: 0.0,
            top: 0.0,
            child:Container(
              width: Get.width*0.4,
              height: Get.height*0.15,
              decoration:   BoxDecoration(
                color: kGreyColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white,width: 2.0),
              ),
              child: Center(
                child: Image.asset("assets/images/$imgPath",fit: BoxFit.contain,width: Get.width*0.3,
                  height: Get.height*0.1,),

              ),
            ),
          ):Positioned(
            left: 0.0,
            top: 0.0,
            child:Container(
              width: Get.width*0.4,
              height: Get.height*0.15,
              decoration:   BoxDecoration(
                color: kGreyColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white,width: 3.0),

              ),
              child: Center(
                child: Image.asset("assets/images/$imgPath",fit: BoxFit.contain,width: Get.width*0.3,
                  height: Get.height*0.1,),

              ),
            ),
          ),


        ],
      ),
    );
  }
}
