// ignore_for_file: prefer_final_fields

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrentmanger/Services/app_info_services.dart';
import 'package:carrentmanger/Services/auth_services.dart';
import 'package:carrentmanger/UI/homeScreen/home_screen.dart';
import 'package:carrentmanger/Utils/colors.dart';
import 'package:carrentmanger/Utils/constant.dart';
import 'package:carrentmanger/Utils/localization_services.dart';
import 'package:carrentmanger/Utils/memory.dart';
import 'package:carrentmanger/Utils/services.dart';
import 'package:carrentmanger/Utils/translation_key.dart';
import 'package:carrentmanger/Widget/custom_text_widget.dart';
import 'package:carrentmanger/models/country_code_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/validator.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:carrentmanger/models/auth_model.dart';
import 'package:carrentmanger/Utils/localization_services.dart';
import 'package:carrentmanger/UI/otp/otp_sceen.dart';

class LoginController extends GetxController{
  final _validatorHelber = ValidatorHelper.instance;
  bool isLoading = false;
  RxBool _isEnableLogin = false.obs;
  bool get isEnableLogin => _isEnableLogin.value;

  set isEnableLogin(bool value) {
    _isEnableLogin.value = value;

    update();
  }
  String buttonStatus = "main";
  final formKey = GlobalKey<FormState>();
  late TextEditingController phoneController;
  List<CountryCodeModel>? countriesCodesList = [];
  CountryCodeModel? selectedCountryCode ;
  bool phoneValidated = false;
  bool formValidated = false;
  bool phoneState = false;
  bool passHasAnErrorViewed = false;
  bool emailHasAnErrorViewed = false;
  bool signingIn =false;
  @override
  void onInit() {
    super.onInit();
    phoneController = TextEditingController();
    checkForUpgrades();
    getCountriesCodes();
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }

  void clear() {
    phoneController.clear();
  }

  checkForUpgrades() {
    InAppUpdate.checkForUpdate().then((updateInfo) {
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateInfo.immediateUpdateAllowed) {
          // Perform immediate update
          InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              //App Update successful
            }
          });
        } else if (updateInfo.flexibleUpdateAllowed) {
          //Perform flexible update
          InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              //App Update successful
              InAppUpdate.completeFlexibleUpdate();
            }
          });
        }
      }
    });
  }

  void onPhoneNumberUpdate(String? value) {
    if (value == "") {
      phoneState = false;
    }
    update();
  }
  changeButtonStatus(){
    if(  phoneState ){
      if(buttonStatus != "main") {
        buttonStatus = "main";
      }
    }
  }
  String? validatePhoneNumber(String? phoneNumber) {
    var validateName = _validatorHelber.validatePhoneNumberField(phoneNumber);
    if (validateName == null && phoneNumber != "") {
      phoneState = true;
      phoneValidated = true;
      changeButtonStatus();
    } else {
      phoneValidated = true;
      phoneState = false;
    }
    return validateName;
  }


  Future<void> sendPressed(context) async {
    formValidated = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (formValidated) {
      sinningIn(context);
    }else{
      buttonStatus ="failed";

      update();
    }
  }
  getCountriesCodes() async {
    countriesCodesList = await AppInfoServices.getCountriesCodesList();
    _getCurrentLocation();
  }
  void _getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position res = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    getAddressOfLocation(res.latitude, res.longitude);

  }
  getAddressOfLocation(double lat,double long) async {
    List<Placemark> i =
    await placemarkFromCoordinates(lat, long);
    Placemark placeMark = i.first;

    for(var countryCode in countriesCodesList!){
      if(placeMark.country == countryCode.name){
        selectedCountryCode = countryCode;
        isLoading = false;
        update();
      }
    }

  }
  choosingAnotherCountryCode(CountryCodeModel chosenCountryCode,BuildContext context){
    selectedCountryCode = chosenCountryCode;
    update();
    Navigator.pop(context);
  }
  choosingCountryCode(BuildContext context){
    showModalBottomSheet(
      context:context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer, builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: countriesCodesList!.map((e){
              return InkWell(
                onTap: (){
                  choosingAnotherCountryCode(e, context);
                },
                child: Container(
                  width: Get.width,
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
                                    color: selectedCountryCode?.name==e.name
                                        ? kDarkGreenColor
                                        : Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              CachedNetworkImage(
                                imageUrl:"${Services.baseEndPoint}${e.flag}",
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
                                "   ${e.name}    ",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: Get.find<
                                      StorageService>()
                                      .activeLocale ==
                                      SupportedLocales
                                          .english
                                      ? fontFamilyEnglishName
                                      : fontFamilyArabicName,
                                  color: kBlackColor,
                                ),
                              ),
                            ],
                          ),
                          CustomText(
                            "   ${e.code}    ",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: Get.find<
                                  StorageService>()
                                  .activeLocale ==
                                  SupportedLocales
                                      .english
                                  ? fontFamilyEnglishName
                                  : fontFamilyArabicName,
                              color: kBlackColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      e ==  countriesCodesList?.last
                          ? const SizedBox()
                          : const Divider(
                        color: kDarkGreenColor,
                        height: 1,
                        thickness: 1,
                        endIndent: 0,
                        indent: 0,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    },
    );
  }
  // late String _optCode;
  Future errorDialog(String err) async {
    return Get.defaultDialog(
        title: "error /n tryAgain.tr ",
        titlePadding: const EdgeInsets.symmetric(vertical: 10),
        middleText: err);
  }
  sinningIn(context) async {

        if( buttonStatus != "loading"){
          buttonStatus = "loading";
          update();
          AuthModel? data = await AuthServices.logIn(
            selectedCountryCode?.code ?? "",
            phoneController.text ?? "",
          );
          print(data?.status);
          if (data?.status == "true") {
            await Get.find<StorageService>().saveAccountId(
                "${data?.info?.id ?? 0}");
            await Get.find<StorageService>().saveAccountOtp(
                "${data?.info?.opt ?? 0}");
            await Get.find<StorageService>().saveAccountName(
                data?.info?.name ?? "");
            await Get.find<StorageService>().saveCheckerSigningUp(false);
            buttonStatus = "success";
            update();
            await Get.to(() =>
             OtpScreen(
              comingFromSignUp: false));
          } else {
            buttonStatus = "failed";
            update();
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: errorKey.tr,
              desc: Get
                  .find<StorageService>()
                  .activeLocale == SupportedLocales.english
                  ? data?.msg ?? ""
                  : data?.msgAr ?? "",
              btnCancelOnPress: () {},
              btnOkOnPress: () {},
            ).show();
          }
        }

  }
  @override
  String toString() {
    return 'LoginController{ _email: ${phoneController
        .value},}';
  }
}