import 'package:carrentmanger/Utils/colors.dart';
import 'package:carrentmanger/Widget/custom_text_widget.dart';
import 'package:carrentmanger/Widget/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../../Utils/constant.dart';
import '../../Utils/localization_services.dart';
import '../../Utils/memory.dart';
import 'controller/terms_and_condition_controller.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  TermsAndConditionController(context),
      builder: (TermsAndConditionController controller) =>
          Scaffold(
            appBar: AppBar(
              actions: [
                const SizedBox(
                  width: 8,
                ),

                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: Get.height * 0.07,
                      width: Get.width * 0.11,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: kWhiteColor,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2,
                            offset: Offset(1, 1), // Shadow position
                          ),
                        ],
                      ),
                      child: const Center(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: kDarkGreenColor,
                          )),
                    ),
                  ),
                ),
              ],
              backgroundColor: kDarkGreenColor,
              leading: InkWell(
                onTap: () {
                },
                child: const Padding(
                    padding: EdgeInsets.all(13.0),
                    child: SizedBox()
                ),
              ),
              title: Image.asset(
                "assets/images/app_logo.png",
                fit: BoxFit.fitWidth,
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.3,
              ),
              centerTitle: true,
            ),
            body: controller.loading
                ? const Loader()
                : Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListView(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: CustomText(Get.find<StorageService>().activeLocale == SupportedLocales.english?controller.termsData?.titleEn??"":controller.termsData?.title??"",
                        style:  TextStyle(
                            fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                            color: kDarkBlueColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 20),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Html(
                      data: Get.find<StorageService>().activeLocale == SupportedLocales.english?controller.termsData?.descEn??"":controller.termsData?.desc??"",
                      style: {
                        "body": Style(
                          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                          color: kDarkGreenColor,
                          fontWeight: FontWeight.w600,

                          fontSize: FontSize(20),
                        ),
                      },),
                  )
                ],
              ),
            ),
          ),
    );
  }
}
