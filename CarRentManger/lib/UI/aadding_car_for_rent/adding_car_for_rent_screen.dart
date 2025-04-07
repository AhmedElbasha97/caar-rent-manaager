import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrentmanger/UI/aadding_car_for_rent/controller/adding_car_for_rent_controller.dart';
import 'package:carrentmanger/UI/aadding_car_for_rent/widget/image_show_widget.dart';
import 'package:carrentmanger/Utils/colors.dart';
import 'package:carrentmanger/Utils/constant.dart';
import 'package:carrentmanger/Utils/localization_services.dart';
import 'package:carrentmanger/Utils/memory.dart';
import 'package:carrentmanger/Utils/services.dart';
import 'package:carrentmanger/Widget/custom_text_widget.dart';
import 'package:carrentmanger/Widget/drawer_widget.dart';
import 'package:carrentmanger/Widget/loader.dart';
import 'package:carrentmanger/Widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddingCarForRentScreen extends StatelessWidget {
  const AddingCarForRentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  AddingCarForRentController(context),
      builder: (AddingCarForRentController controller) =>  SafeArea(
        child: Scaffold(
          key: controller.scaffoldState,
          drawer:  DrawerWidget(scaffoldKey: controller.scaffoldState,),
          body: Container(
            width: Get.width,
            height: Get.height,
            decoration: const BoxDecoration(
                color: kWhiteColor
            ),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
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
                                                      Get.find<StorageService>().activeLocale == SupportedLocales.english?"Adding Car For Rent":"إضافة سيارة للإيجار",
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
                                                      Get.find<StorageService>().activeLocale == SupportedLocales.english?"Adding Car For Rent":"إضافة سيارة للإيجار",
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
                  controller.isLoading? Loader(height: Get.height*0.87,):Container(
                    height: Get.height*0.87,
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
                                                    ? "Rental office name"
                                                    : "أسم مكتب الأيجار"
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

                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                          child: SizedBox(
                                            height: Get.height*0.09,
                                            width: Get.width*0.95,
                                            child: CustomInputField(
                                              focusNode: controller.myFocusNode,
                                              isPhoneNumber: false,
                                              textAligning: Get.find<StorageService>().activeLocale == SupportedLocales.english?TextAlign.left:TextAlign.right,
                                              hasIntialValue: true,
                                              labelText: Get.find<StorageService>().activeLocale == SupportedLocales.english?"Write your office name":"أكتب أسم المكتب الخاص بك",
                                              textInputAction: TextInputAction.done,
                                              keyboardType: TextInputType.name,
                                              iconOfTextField: const Icon(Icons.house_outlined,
                                                  color: kDarkBlueColor),
                                              controller:controller.nameController,
                                              onchange: controller.onNameUpdate,
                                              validator: controller.validateName,
                                              icon: (controller.nameValidated)
                                                  ? (controller.nameState)
                                                  ? const Icon(Icons.check_rounded,
                                                  color: kLightGreenColor)
                                                  : const Icon(
                                                Icons.close_outlined,
                                                color: kErrorColor,
                                              )
                                                  : null,
                                              hasGreenBorder: false,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    controller.imagesFile.isEmpty?const SizedBox(
                                      height: 20,
                                    ):const SizedBox(
                                      height: 10,
                                    ),
                                    controller.nameController.text.trim().isEmpty?const SizedBox():controller.imagesFile.isEmpty||controller.imagesFile.length<6? InkWell(
                                      onTap: (){
                                        controller.getImages(context);
                                      },


                                      child: Center(
                                        child: Container(
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
                                                          child: CustomText(
                                                            Get.find<StorageService>().activeLocale == SupportedLocales.english?"You Must Add 1 to 6 Images For The Car":"يجب عليك إضافة 1 إلى 6 صور للسيارة",
                                                            style:  TextStyle(
                                                              fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                              color: kWhiteColor,
                                                              fontWeight: FontWeight.w800,
                                                              fontSize: 20,

                                                              height: 1,
                                                              letterSpacing: -1,
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
                                                          child: SizedBox(
                                                            width: Get.width*0.45,
                                                            child: CustomText(
                                                              Get.find<StorageService>().activeLocale == SupportedLocales.english?" Add 1 to 6 Images For The Car":"أضف من ١ إلى ٦ صور للسيارة.",
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
                                                  child: const Center(
                                                    child: Icon(Icons.camera_enhance,color: kDarkGreenColor,size: 50,),

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
                                                  child: const Center(
                                                    child: Icon(Icons.camera_enhance,color: kDarkGreenColor,size: 50,),
                                                  ),
                                                ),
                                              ),


                                            ],
                                          ),
                                        ),
                                      ),
                                    ):SizedBox(),
                                    controller.imagesFile.isEmpty?SizedBox()  :Center(
                                          child: ImageShowWidget(
                                                                              index: controller.index,
                                                                              getNextImage: (){
                                          controller.getNextImages();
                                                                              },
                                                                              getPreviousImage: (){
                                          controller.getPrevImages();
                                                                              },
                                                                              chooseAnotherImage: (){
                                          controller.editingImage();
                                                                              },
                                                                              deleteImage: (){
                                          controller.deleteImage();
                                                                              },
                                                                              images: controller.imagesFile,

                                                                            ),
                                        ),
                                    controller.imagesFile.isEmpty?const SizedBox(
                                      height: 20,
                                    ):const SizedBox(
                                      height: 10,
                                    ),
                                    controller.imagesFile.isEmpty?const SizedBox():
                                    const SizedBox(height: 10,),


                                    controller.imagesFile.isEmpty?SizedBox():
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
                                                          Get.find<StorageService>().activeLocale == SupportedLocales.english?"choose county":"إختر الدوله",
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
                                    controller.imagesFile.isEmpty?SizedBox():controller.chosenCountry == null?const SizedBox():
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
                                                    ? "Insurance Type"
                                                    : "نوع التأمين"
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
                                                controller.listInsuranceTypes!.map((e) {
                                                  return PopupMenuItem(
                                                    value: e,
                                                    textStyle: TextStyle(
                                                        color: kDarkGreenColor,
                                                        fontFamily:
                                                        Get.find<StorageService>().activeLocale ==
                                                            SupportedLocales.english
                                                            ? fontFamilyEnglishName
                                                            : fontFamilyArabicName,
                                                        ),
                                                    onTap: () {
                                                      controller.choosingInsuranceType(e);
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
                                                                        color: controller.chosenInsuranceType==e
                                                                            ? kDarkGreenColor
                                                                            : Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 20,
                                                                  ),

                                                                  CustomText(
                                                                    e,
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
                                                          e == controller.listInsuranceTypes?.last
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
                                                        controller.chosenInsuranceType == null?CustomText(
                                                          Get.find<StorageService>().activeLocale == SupportedLocales.english?"choose car Insurance Type":"إختر نوع تأمين السيارة",
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
                                                              Get.find<StorageService>().activeLocale == SupportedLocales.english?"chosen Insurance Type:":"نوع تأمين السيارة المختاره:",
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
                                                              controller.chosenInsuranceType??"",
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
                                    controller.chosenInsuranceType == null?const SizedBox():
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
                                                          Get.find<StorageService>().activeLocale == SupportedLocales.english?"Is the car chauffeured?":"هل السيارة مع سائق؟",
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
                                                    ? "year of manufacturing"
                                                    : "سنة الصنع"
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
                                                            : fontFamilyArabicName,),
                                                    onTap: () {
                                                      controller.choosingYear(e);
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
                                                                        color: controller.chosenYear==e
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
                                                        controller.chosenYear == null?CustomText(
                                                          Get.find<StorageService>().activeLocale == SupportedLocales.english?"choose year of manufacturing":"إختر سنة الصنع",
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
                                                              Get.find<StorageService>().activeLocale == SupportedLocales.english?"year of manufacturing":"سنة الصنع:",                                                              style:  TextStyle(
                                                              fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                              color: kWhiteColor,
                                                              fontSize: 15,
                                                              height: 1,
                                                              letterSpacing: -1,
                                                            ),
                                                            ),
                                                            SizedBox(width: 5,),
                                                            CustomText(
                                                              controller.chosenYear?.year??"",
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
                              ),
                            ),
                          ),

                          controller.chosenYear == null?const SizedBox():Center(
                            child: InkWell(
                              onTap: (){
                                controller.addingCarToRent(context);


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
                                        Get.find<StorageService>().activeLocale == SupportedLocales.english?"Add Car To Rent":"أضف سيارة للإيجار",
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
      ),
    );
  }
}
