import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrentmanger/Services/app_info_services.dart';
import 'package:carrentmanger/Services/auth_services.dart';
import 'package:carrentmanger/UI/otp/otp_sceen.dart';
import 'package:carrentmanger/Utils/colors.dart';
import 'package:carrentmanger/Utils/constant.dart';
import 'package:carrentmanger/Utils/localization_services.dart';
import 'package:carrentmanger/Utils/memory.dart';
import 'package:carrentmanger/Utils/services.dart';
import 'package:carrentmanger/Widget/custom_text_widget.dart';
import 'package:carrentmanger/models/auth_model.dart';
import 'package:carrentmanger/models/country_code_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/translation_key.dart';
import '../../../Utils/validator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
class SignUpController extends GetxController {
  final _validatorHelber = ValidatorHelper.instance;
  bool isLoading = false;
  final RxBool _visiblePsd = false.obs;
  final RxBool _isEnableLogin = false.obs;

  bool get isEnableLogin => _isEnableLogin.value;

  bool get visiblePsd => _visiblePsd.value;
  int val = 0;
  String buttonStatus = "main";

  set isEnableLogin(bool value) {
    _isEnableLogin.value = value;

    update();
  }

  final formKey = GlobalKey<FormState>();
  late TextEditingController phoneController;
  late TextEditingController nameController;
  List<CountryCodeModel>? countriesCodesList = [];
  CountryCodeModel? selectedCountryCode ;

  late TextEditingController emailController;
  bool nameValidated = false;
  bool secondNameValidated = false;
  bool lastNameValidated = false;
  bool phoneValidated = false;
  bool emailValidated = false;
  bool formValidated = false;
  bool reTypePasswordState = false;
  bool emailState = false;
  bool nameState = false;
  bool secondNameState = false;
  bool lastNameState = false;
  bool phoneState = false;
  bool signingUp = false;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    getCountriesCodes();

  }

  @override
  void onClose() {
    emailController.dispose();

    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void clear() {
    emailController.clear();

    nameController.clear();
    phoneController.clear();
  }

  void onEmailUpdate(String? value) {
    if (value == "omar.khaled20@yahoo.com") {
      phoneController.clear();
    }
    if (value == "") {
      emailValidated = false;
    }
    update();
  }
    changeButtonStatus(){
      if( emailState && nameState && phoneState ){
        if(buttonStatus != "main") {
          buttonStatus = "main";
        }
      }
    }
  void onNameUpdate(String? value) {
    if (value == "") {
      nameState = false;
    }
    update();
  }

  String? validateName(String? name) {
    var validateName = _validatorHelber.validateName(name);
    if (validateName == null && name != "") {
      nameState = true;
      nameValidated = true;
      changeButtonStatus();
    } else {
      nameValidated = true;
      nameState = false;
    }
    return validateName;
  }

  void onPhoneNumberUpdate(String? value) {
    if (value == "") {
      phoneState = false;
    }
    update();
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

  String? validateEmail(String? email) {
    final validateEmail = _validatorHelber.validateEmail(email);
    if (email == "") {
      emailState = false;
      emailValidated = false;
    } else if (validateEmail == null) {
      emailState = true;
      emailValidated = true;
      changeButtonStatus();
    } else {
      emailValidated = true;
      emailState = false;
    }

    return validateEmail;
  }


  changeValueOfRadioBTN(value, context) {
    if (val == 0) {
      val = 1;
      changeButtonStatus();
    } else {
      val = 0;
    }
    update();
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
  Future<void> sendPressed(context) async {
    formValidated = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (formValidated) {
      signningUp(context);
    }else{
      buttonStatus ="failed";

      update();
    }
  }

  // late String _optCode;
  Future errorDialog(String err) async {
    return Get.defaultDialog(
        title: "error /n tryAgain.tr ",
        titlePadding: const EdgeInsets.symmetric(vertical: 10),
        middleText: err);
  }

  signningUp(context) async {
    if( buttonStatus != "loading"){

      buttonStatus = "loading";
      update();
      if(val == 1) {
        AuthModel? data = await AuthServices.signingUp(
          nameController.text ?? "",
          selectedCountryCode?.code ?? "",
          phoneController.text ?? "",
          emailController.text ?? "",
        );
        print(data?.status);
        if (data?.status == "true") {
          await Get.find<StorageService>().saveAccountId(
              "${data?.info?.id ?? 0}");
          await Get.find<StorageService>().saveAccountOtp(
              "${data?.info?.opt ?? 0}");
          await Get.find<StorageService>().saveAccountName(
              data?.info?.name ?? "");
          await Get.find<StorageService>().saveCheckerSigningUp(true);
          buttonStatus = "success";
          update();
          await Get.to(() =>
          const OtpScreen(
            comingFromSignUp: true));
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
      }else{
        buttonStatus = "failed";
        update();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: errorKey.tr,
          desc:"يجب عليك الموافقه على الشروط والأحكام و سياسه الخصوصيه الخاصه بالتطبيق",
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      }
    }

  }

}