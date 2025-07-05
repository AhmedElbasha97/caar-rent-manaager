
import 'dart:io';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrentmanger/Services/app_info_services.dart';
import 'package:carrentmanger/Services/car_services.dart';
import 'package:carrentmanger/Utils/colors.dart';
import 'package:carrentmanger/Utils/constant.dart';
import 'package:carrentmanger/Utils/services.dart';
import 'package:carrentmanger/Utils/translation_key.dart';
import 'package:carrentmanger/Utils/validator.dart';
import 'package:carrentmanger/Widget/custom_text_widget.dart';
import 'package:carrentmanger/Widget/text_field_widget.dart';
import 'package:carrentmanger/models/country_code_model.dart';
import 'package:carrentmanger/models/response_model.dart';
import 'package:carrentmanger/models/years_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:carrentmanger/models/category_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart' as AppSettings;
import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../../models/car_rented_model.dart';

class EditingCarRentRequestController extends GetxController{
  final CarRentedModel? carData;

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  late List<CountryCodeModel>? listOfCountry;
  List<CountryCodeModel>? listOfSearchedCountry = [];
  bool isSearchCountryActive = false;
  TextEditingController searchController = TextEditingController();
  CountryCodeModel? chosenCountry;
  late List<CategoryModel>? listOfCities;
  List<CategoryModel>? listOfSearchedCities = [];
  bool isSearchCitiesActive = false;
  TextEditingController searchCitiesController = TextEditingController();
  CategoryModel? chosenCity;
  late List<CategoryModel>? listOfCarBrands;
  CategoryModel? chosenCarBrand;
  List<CategoryModel>? listOfSearchedCarBrands = [];
  bool isSearchCarBrandsActive = false;
  TextEditingController searchCarBrandsController = TextEditingController();
  late List<CategoryModel>? listOfCarModels;
  CategoryModel? chosenCarModel;
  List<CategoryModel>? listOfSearchedCarModels = [];
  bool isSearchCarModelsActive = false;
  TextEditingController searchCarModelsController = TextEditingController();
  int index = 0;
  List<YearsModel>? listOfYears ;
  YearsModel? chosenYear;
  bool isSendingData =false;

  late TextEditingController nameController;
  bool nameValidated = false;
  bool nameState = false;
  final _validatorHelber = ValidatorHelper.instance;
  FocusNode myFocusNode = FocusNode(); // Create a FocusNode

  List<String>? listInsuranceTypes = Get.find<StorageService>().activeLocale ==
      SupportedLocales.english
      ? ["Comprehensive Insurance","Third Party Insurance"]
      :["تأمين شامل","تأمين ضد الغير"];
  String? chosenInsuranceType;
  List<String>? listOfPeriods = Get.find<StorageService>().activeLocale ==
      SupportedLocales.english
      ? ["daily","weekly","monthly","until ownership"]
      :["يومى","أسبوعى","شهرى"," حتى التملك"];
  List<String> chosenPeriod = [];

  List<String>? listOfWithDriver = Get.find<StorageService>().activeLocale ==
      SupportedLocales.english
      ? ["car with driver", "car without driver"]
      :["السيارة بسائق","السيارة بدون سائق"];
  List<String> chosenWithDriver = [];
  bool isLoading = true;
  final BuildContext context;
  EditingCarRentRequestController(this.context, this.carData);
  ScrollController scrollController = ScrollController();

  @override
  onInit() {
    super.onInit();
    getCountriesCodesList();
    nameController =TextEditingController();
    fillingData();
  }
  fillingData() async {
    nameController.text = carData?.showroomName??"";
    await getYearsList();
    await getCountriesCodesList();
    chosenCountry = CountryCodeModel(id: carData?.country?.id??0,name: carData?.country?.name??"");
    await getCitiestList();
    chosenCity = CategoryModel(id: carData?.city?.id??0,name: carData?.city?.name??"");
    await getCarBrandsList();
    chosenCarBrand = CategoryModel(id: carData?.make?.id??0,name: carData?.make?.name??"");
    await getCarModelsList();
    chosenCarModel = CategoryModel(id: carData?.model?.id??0,name: carData?.model?.name??"");
    ((carData?.incType??0) == 1)? chosenInsuranceType= (listInsuranceTypes?[0]??""): chosenInsuranceType= (listInsuranceTypes?[1]??"");
    for(String driver in carData?.driver??[]){
      if(driver == "1" ){
        chosenWithDriver.add(listOfWithDriver?[0]??"");
      }else  if(driver == "0" ){
        chosenWithDriver.add(listOfWithDriver?[1]??"");
      }
    }
    for(String period in carData?.type??[]){
      if(period == "1"){
        chosenPeriod.add(listOfPeriods?[0]??"");
      }else  if(period == "2"){
        chosenPeriod.add(listOfPeriods?[1]??"");
      }else  if(period == "3"){
        chosenPeriod.add(listOfPeriods?[2]??"");
      }else  if(period == "4"){
        chosenPeriod.add(listOfPeriods?[3]??"");
      }
    }





    for(var i=0;i<listOfYears!.length;i++){
      if(listOfYears![i].year == carData?.year){
        chosenYear = listOfYears![i];
        break;
      }
    }

    isLoading = false;

    update();
  }
  @override
  void onClose() {
    super.onClose();
    myFocusNode.dispose(); // Always dispose the FocusNode
    nameController.dispose();
    scrollController.dispose(); // important!

  }
  void _scrollToBottom() {
    if (scrollController.hasClients) {
      print(scrollController.position.userScrollDirection ==ScrollDirection.reverse );
      scrollController.jumpTo(scrollController.position.extentTotal);

    }


  }
  //office neme validator
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
    } else {
      nameValidated = true;
      nameState = false;
    }
    return validateName;
  }

  //getting data from api
  getCountriesCodesList() async {
    listOfCountry = await AppInfoServices.getCountriesCodesList();
    _getCurrentLocation();

  }
  getCitiestList() async {
    listOfCities =
    await AppInfoServices.getCityList(chosenCountry!.id.toString());
    update();
  }
  getCarBrandsList() async {
    listOfCarBrands = await CarServices.getCarBrandsList();
    update();
  }
  getCarModelsList() async {
    listOfCarModels = await CarServices.getCarModelsList(chosenCarBrand!.id.toString());
    update();
  }
  getYearsList() async {
    listOfYears = await CarServices.getYearsList();
    update();
  }
  //choosingData
  choosingCountry(CountryCodeModel countryCodeModel) async {
    chosenCountry = countryCodeModel;
    chosenCity = null;
    chosenCarBrand = null;
    chosenCarModel = null;
    myFocusNode.unfocus();
    Get.back();
    await getCitiestList();
    update();
    _scrollToBottom();
  }
  choosingCity(CategoryModel city) async {
    chosenCity = city;
    chosenCarBrand = null;
    myFocusNode.unfocus();

    await getCarBrandsList();
    Get.back();

    update();
    _scrollToBottom();
  }
  choosingCarBrand(CategoryModel carBrand) async {
    chosenCarBrand = carBrand;
    chosenCarModel = null;
    myFocusNode.unfocus();

    await getCarModelsList();
    Get.back();

    update();

    _scrollToBottom();
  }
  choosingCarModel(CategoryModel carModel) {
    chosenCarModel = carModel;
    myFocusNode.unfocus();

    Get.back();

    update();
    _scrollToBottom();
  }
  choosingPeriod(String period){
    if(chosenPeriod.contains(period)) {
      chosenPeriod.remove(period);

    }else{
      chosenPeriod.add(period);
    }
    myFocusNode.unfocus();

    update();
    _scrollToBottom();
  }
  choosingWithDriver(String withDriver) async {
    if(chosenWithDriver.contains(withDriver)) {
      chosenWithDriver.remove(withDriver);
    }else{
      chosenWithDriver.add(withDriver);
    }
    myFocusNode.unfocus();

    await getYearsList();
    update();
    _scrollToBottom();
  }
  choosingInsuranceType(String insuranceType) {
    chosenInsuranceType = insuranceType;
    myFocusNode.unfocus();

    update();
    _scrollToBottom();
  }
  choosingYear(YearsModel year){
    chosenYear = year;
    myFocusNode.unfocus();

    update();

    _scrollToBottom();
  }

//getting user location
  String tr(String ar, String en) {
    return Get.find<StorageService>().activeLocale == SupportedLocales.english ? en : ar;
  }
  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      _showLocationServiceDialog(context);
      return;
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showPermissionDeniedDialog(context);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showPermissionDeniedForeverDialog(context);
      return;
    }

    // Permission granted, get location
    Position res = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    getAddressOfLocation(res.latitude, res.longitude);
  }
  void _showLocationServiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(tr("تشغيل الموقع", "Enable Location")),
        content: Text(tr(
          "خدمة الموقع غير مفعّلة. من فضلك فعّلها من الإعدادات.",
          "Location services are disabled. Please enable them from settings.",
        )),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Geolocator.openLocationSettings();
            },
            child: Text(tr("فتح الإعدادات", "Open Settings")),
          ),
        ],
      ),
    );
  }
  void _showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(tr("إذن الموقع مرفوض", "Location Permission Denied")),
        content: Text(tr(
          "نحتاج إذن الموقع لتشغيل هذه الميزة.",
          "Location permission is required to use this feature.",
        )),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(tr("حسناً", "OK")),
          ),
        ],
      ),
    );
  }
  void _showPermissionDeniedForeverDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(tr("إذن الموقع مرفوض دائمًا", "Permission Denied Forever")),
        content: Text(tr(
          "لقد قمت برفض إذن الموقع دائمًا. الرجاء السماح من إعدادات التطبيق.",
          "You have permanently denied location permission. Please allow it from app settings.",
        )),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              AppSettings.openAppSettings();
            },
            child: Text(tr("فتح إعدادات التطبيق", "Open App Settings")),
          ),
        ],
      ),
    );
  }
  getAddressOfLocation(double lat,double long) async {
    List<Placemark> i =
    await placemarkFromCoordinates(lat, long);
    Placemark placeMark = i.first;
    bool isFoundCountry = false;
    for (var countryCode in listOfCountry!) {
      if (placeMark.country == countryCode.name) {
        chosenCountry = countryCode;
        getCitiestList();
        isFoundCountry = true;

      }
    }
    if (!isFoundCountry) {

    }
  }

  //bottom modal sheet for countries
  choosingCountryCode(BuildContext context){
    clearSearch();
    showModalBottomSheet(
      context:context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return GetBuilder<EditingCarRentRequestController>(
            init: EditingCarRentRequestController(context,carData),
            builder: (EditingCarRentRequestController controller) {

              return Container(
                height: Get.height*0.8,

                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: Get.height*0.09,
                                width: Get.width*0.6,
                                child: CustomInputField(
                                  isPhoneNumber: false,
                                  textAligning: Get.find<StorageService>().activeLocale == SupportedLocales.english?TextAlign.left:TextAlign.right,
                                  hasIntialValue: true,
                                  labelText: Get.find<StorageService>().activeLocale == SupportedLocales.english?"Search":"بحث",
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.name,
                                  iconOfTextField: const Icon(Icons.search,
                                      color: kDarkBlueColor),
                                  onFieldSubmitted: (e){
                                    searchingCountriesHistory();
                                  },
                                  onchange: (e){
                                    searchingCountriesHistory();
                                  },
                                  controller: searchController,
                                  hasGreenBorder: false,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              isSearchCountryActive?Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: InkWell(
                                    onTap: (){
                                      clearSearch();
                                    },
                                    child: Container(
                                        width: Get.width*0.2,
                                        height: Get.height*0.06,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: kDarkGreenColor,
                                        ),
                                        child: Center(
                                            child: CustomText(
                                              Get.find<StorageService>().activeLocale == SupportedLocales.english?"clear":"مسح",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                color: Colors.white,
                                              ),
                                            )
                                        )
                                    )),
                              ):SizedBox()
                            ],
                          ),
                        ),
                        Column(
                          children:isSearchCountryActive? listOfSearchedCountry!.isEmpty?[Container(
                            width: Get.width,
                            child: Column(
                              children: [
                                SizedBox(height: Get.height*0.05,),
                                Icon(Icons.search,color: kDarkGreenColor,size: 50,),
                                SizedBox(height: Get.height*0.05,),
                                CustomText(
                                  Get.find<
                                      StorageService>()
                                      .activeLocale ==
                                      SupportedLocales
                                          .english
                                      ?"no country with this name":"لا توجد دولة بهذا الاسم",
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontFamily: Get.find<
                                        StorageService>()
                                        .activeLocale ==
                                        SupportedLocales
                                            .english
                                        ? fontFamilyEnglishName
                                        : fontFamilyArabicName,
                                    color: kDarkGreenColor,
                                  ),
                                ),
                                SizedBox(height: Get.height*0.3,),
                              ],
                            ),
                          )]:listOfSearchedCountry!.map((e){
                            return InkWell(
                              onTap: (){
                                choosingCountry(e);
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
                                                  color: chosenCountry?.name==e.name
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
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    e ==  listOfCountry?.last
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
                          }).toList():listOfCountry!.map((e){
                            return InkWell(
                              onTap: (){
                                choosingCountry(e);
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
                                                  color: chosenCountry?.name==e.name
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
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    e ==  listOfCountry?.last
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
                      ],
                    ),
                  ),
                ),
              );
            }
        );
      },
    );
  }
  searchingCountriesHistory(){
    listOfSearchedCountry = [];
    isSearchCountryActive = true;

    for(var i=0;i<(listOfCountry?.length??0);i++){
      if(("${listOfCountry?[i].name?.toLowerCase()}").contains(searchController.text.toLowerCase())){
        listOfSearchedCountry?.add(listOfCountry![i]);
      }


    }
    update();
  }
  clearSearch(){
    isSearchCountryActive = false;
    listOfSearchedCountry = [];
    searchController.clear();
    update();
  }
  //bottom modal sheet for cities
  choosingCities(BuildContext context){
    clearSearchCities();
    showModalBottomSheet(
      context:context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return GetBuilder<EditingCarRentRequestController>(
            init: EditingCarRentRequestController(context,carData),
            builder: (EditingCarRentRequestController controller) {

              return Container(
                height: Get.height*0.8,

                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: Get.height*0.09,
                                width: Get.width*0.6,
                                child: CustomInputField(
                                  isPhoneNumber: false,
                                  textAligning: Get.find<StorageService>().activeLocale == SupportedLocales.english?TextAlign.left:TextAlign.right,
                                  hasIntialValue: true,
                                  labelText: Get.find<StorageService>().activeLocale == SupportedLocales.english?"Search":"بحث",
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.name,
                                  iconOfTextField: const Icon(Icons.search,
                                      color: kDarkBlueColor),
                                  onFieldSubmitted: (e){
                                    searchingCitiesHistory();
                                  },
                                  onchange: (e){
                                    searchingCitiesHistory();
                                  },
                                  controller: searchCitiesController,
                                  hasGreenBorder: false,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              isSearchCitiesActive?Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: InkWell(
                                    onTap: (){
                                      clearSearchCities();
                                    },
                                    child: Container(
                                        width: Get.width*0.2,
                                        height: Get.height*0.06,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: kDarkGreenColor,
                                        ),
                                        child: Center(
                                            child: CustomText(
                                              Get.find<StorageService>().activeLocale == SupportedLocales.english?"clear":"مسح",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                color: Colors.white,
                                              ),
                                            )
                                        )
                                    )),
                              ):SizedBox()
                            ],
                          ),
                        ),
                        Column(
                          children:isSearchCitiesActive? listOfSearchedCities!.isEmpty?[Container(
                            width: Get.width,
                            child: Column(
                              children: [
                                SizedBox(height: Get.height*0.05,),
                                Icon(Icons.search,color: kDarkGreenColor,size: 50,),
                                SizedBox(height: Get.height*0.05,),
                                CustomText(
                                  Get.find<
                                      StorageService>()
                                      .activeLocale ==
                                      SupportedLocales
                                          .english
                                      ?"no city with this name":"لا توجد مدينه بهذا الاسم",
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontFamily: Get.find<
                                        StorageService>()
                                        .activeLocale ==
                                        SupportedLocales
                                            .english
                                        ? fontFamilyEnglishName
                                        : fontFamilyArabicName,
                                    color: kDarkGreenColor,
                                  ),
                                ),
                                SizedBox(height: Get.height*0.3,),
                              ],
                            ),
                          )]:
                          listOfSearchedCities!.map((e){
                            return InkWell(
                              onTap: (){
                                choosingCity(e);
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
                                                  color: chosenCity?.name==e.name
                                                      ? kDarkGreenColor
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
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
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    e ==  listOfCities?.last
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
                          }).toList():
                          listOfCities!.map((e){
                            return InkWell(
                              onTap: (){
                                choosingCity(e);
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
                                                  color: chosenCity?.name==e.name
                                                      ? kDarkGreenColor
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
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
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    e ==  listOfCities?.last
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
                      ],
                    ),
                  ),
                ),
              );
            }
        );
      },
    );
  }
  searchingCitiesHistory(){
    listOfSearchedCities = [];
    isSearchCitiesActive = true;

    for(var i=0;i<(listOfCities?.length??0);i++){
      if(("${listOfCities?[i].name?.toLowerCase()}").contains(searchCitiesController.text.toLowerCase())){
        listOfSearchedCities?.add(listOfCities![i]);
      }


    }
    update();
  }
  clearSearchCities(){
    isSearchCitiesActive = false;
    listOfSearchedCities = [];
    searchCitiesController.clear();
    update();
  }
  //bottom modal sheet for car brands
  choosingCarBrands(BuildContext context){
    clearSearchCarBrands();
    showModalBottomSheet(
      context:context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return GetBuilder<EditingCarRentRequestController>(
            init: EditingCarRentRequestController(context,carData),
            builder: (EditingCarRentRequestController controller) {

              return Container(
                height: Get.height*0.8,

                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: Get.height*0.09,
                                width: Get.width*0.6,
                                child: CustomInputField(
                                  isPhoneNumber: false,
                                  textAligning: Get.find<StorageService>().activeLocale == SupportedLocales.english?TextAlign.left:TextAlign.right,
                                  hasIntialValue: true,
                                  labelText: Get.find<StorageService>().activeLocale == SupportedLocales.english?"Search":"بحث",
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.name,
                                  iconOfTextField: const Icon(Icons.search,
                                      color: kDarkBlueColor),
                                  onFieldSubmitted: (e){
                                    searchingCarBrandsHistory();
                                  },
                                  onchange: (e){
                                    searchingCarBrandsHistory();
                                  },
                                  controller: searchCarBrandsController,
                                  hasGreenBorder: false,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              isSearchCarBrandsActive?Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: InkWell(
                                    onTap: (){
                                      clearSearchCarBrands();
                                    },
                                    child: Container(
                                        width: Get.width*0.2,
                                        height: Get.height*0.06,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: kDarkGreenColor,
                                        ),
                                        child: Center(
                                            child: CustomText(
                                              Get.find<StorageService>().activeLocale == SupportedLocales.english?"clear":"مسح",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                color: Colors.white,
                                              ),
                                            )
                                        )
                                    )),
                              ):SizedBox()
                            ],
                          ),
                        ),
                        Column(
                          children:isSearchCarBrandsActive? listOfSearchedCarBrands!.isEmpty?[Container(
                            width: Get.width,
                            child: Column(
                              children: [
                                SizedBox(height: Get.height*0.05,),
                                Icon(Icons.search,color: kDarkGreenColor,size: 50,),
                                SizedBox(height: Get.height*0.05,),
                                CustomText(
                                  Get.find<
                                      StorageService>()
                                      .activeLocale ==
                                      SupportedLocales
                                          .english
                                      ?"no car brand with this name":"لا يوجد ماركة سيارة بهذا الاسم",
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontFamily: Get.find<
                                        StorageService>()
                                        .activeLocale ==
                                        SupportedLocales
                                            .english
                                        ? fontFamilyEnglishName
                                        : fontFamilyArabicName,
                                    color: kDarkGreenColor,
                                  ),
                                ),
                                SizedBox(height: Get.height*0.3,),
                              ],
                            ),
                          )]:
                          listOfSearchedCarBrands!.map((e){
                            return InkWell(
                              onTap: (){
                                choosingCarBrand(e);
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
                                                  color: chosenCarBrand?.name==e.name
                                                      ? kDarkGreenColor
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
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
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    e ==  listOfCarBrands?.last
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
                          }).toList():
                          listOfCarBrands!.map((e){
                            return InkWell(
                              onTap: (){
                                choosingCarBrand(e);
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
                                                  color: chosenCarBrand?.name==e.name
                                                      ? kDarkGreenColor
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
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
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    e ==  listOfCarBrands?.last
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
                      ],
                    ),
                  ),
                ),
              );
            }
        );
      },
    );
  }
  searchingCarBrandsHistory(){
    listOfSearchedCarBrands = [];
    isSearchCarBrandsActive = true;

    for(var i=0;i<(listOfCarBrands?.length??0);i++){
      if(("${listOfCarBrands?[i].name?.toLowerCase()}").contains(searchCarBrandsController.text.toLowerCase())){
        listOfSearchedCarBrands?.add(listOfCarBrands![i]);
      }


    }
    update();
  }
  clearSearchCarBrands(){
    isSearchCarBrandsActive = false;
    listOfSearchedCarBrands = [];
    searchCarBrandsController.clear();
    update();
  }
  //bottom modal sheet for car models
  choosingCarModels(BuildContext context){
    clearSearchCarModels();
    showModalBottomSheet(
      context:context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return GetBuilder<EditingCarRentRequestController>(
            init: EditingCarRentRequestController(context,carData),
            builder: (EditingCarRentRequestController controller) {

              return Container(
                height: Get.height*0.8,

                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: Get.height*0.09,
                                width: Get.width*0.6,
                                child: CustomInputField(
                                  isPhoneNumber: false,
                                  textAligning: Get.find<StorageService>().activeLocale == SupportedLocales.english?TextAlign.left:TextAlign.right,
                                  hasIntialValue: true,
                                  labelText: Get.find<StorageService>().activeLocale == SupportedLocales.english?"Search":"بحث",
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.name,
                                  iconOfTextField: const Icon(Icons.search,
                                      color: kDarkBlueColor),
                                  onFieldSubmitted: (e){
                                    searchingCarModelsHistory();
                                  },
                                  onchange: (e){
                                    searchingCarModelsHistory();
                                  },
                                  controller: searchCarModelsController,
                                  hasGreenBorder: false,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              isSearchCarModelsActive?Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: InkWell(
                                    onTap: (){
                                      clearSearchCarBrands();
                                    },
                                    child: Container(
                                        width: Get.width*0.2,
                                        height: Get.height*0.06,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: kDarkGreenColor,
                                        ),
                                        child: Center(
                                            child: CustomText(
                                              Get.find<StorageService>().activeLocale == SupportedLocales.english?"clear":"مسح",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                                color: Colors.white,
                                              ),
                                            )
                                        )
                                    )),
                              ):SizedBox()
                            ],
                          ),
                        ),
                        Column(
                          children:isSearchCarModelsActive? listOfSearchedCarModels!.isEmpty?[Container(
                            width: Get.width,
                            child: Column(
                              children: [
                                SizedBox(height: Get.height*0.05,),
                                Icon(Icons.search,color: kDarkGreenColor,size: 50,),
                                SizedBox(height: Get.height*0.05,),
                                CustomText(
                                  Get.find<
                                      StorageService>()
                                      .activeLocale ==
                                      SupportedLocales
                                          .english
                                      ?"no car moadel with this name":"لا يوجد طراز السيارة بهذا الاسم",
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontFamily: Get.find<
                                        StorageService>()
                                        .activeLocale ==
                                        SupportedLocales
                                            .english
                                        ? fontFamilyEnglishName
                                        : fontFamilyArabicName,
                                    color: kDarkGreenColor,
                                  ),
                                ),
                                SizedBox(height: Get.height*0.3,),
                              ],
                            ),
                          )]:
                          listOfSearchedCarModels!.map((e){
                            return InkWell(
                              onTap: (){
                                choosingCarModel(e);
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
                                                  color: chosenCarModel?.name==e.name
                                                      ? kDarkGreenColor
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
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
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    e ==  listOfCarModels?.last
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
                          }).toList():
                          listOfCarModels!.map((e){
                            return InkWell(
                              onTap: (){
                                choosingCarModel(e);
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
                                                  color: chosenCarModel?.name==e.name
                                                      ? kDarkGreenColor
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
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
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    e ==  listOfCarModels?.last
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
                      ],
                    ),
                  ),
                ),
              );
            }
        );
      },
    );
  }
  searchingCarModelsHistory(){
    listOfSearchedCarModels = [];
    isSearchCarModelsActive = true;

    for(var i=0;i<(listOfCarModels?.length??0);i++){
      if(("${listOfCarModels?[i].name?.toLowerCase()}").contains(searchCarModelsController.text.toLowerCase())){
        listOfSearchedCarModels?.add(listOfCarModels![i]);
      }


    }
    update();
  }
  clearSearchCarModels(){
    isSearchCarModelsActive = false;
    listOfSearchedCarModels = [];
    searchCarModelsController.clear();
    update();
  }
  //bottom sheet modal for driver
  choosingWithDriverOrNot(BuildContext context){
    showModalBottomSheet(
      context:context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return GetBuilder<EditingCarRentRequestController>(
            init: EditingCarRentRequestController(context,carData),
            builder: (EditingCarRentRequestController controller) {

              return Container(
                height: Get.height*0.8,

                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [

                        Column(
                          children:
                          listOfWithDriver!.map((e){
                            return InkWell(
                              onTap: (){
                                choosingWithDriver(e);
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
                                                  color: chosenWithDriver.contains(e)
                                                      ? kDarkGreenColor
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            CustomText(
                                              "   ${e}    ",
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
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    e ==  listOfWithDriver?.last
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
                        SizedBox(height: 10,),
                        Center(
                          child: InkWell(
                            onTap: (){
                              Navigator.pop(context);
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
                                      Get.find<StorageService>().activeLocale == SupportedLocales.english?"Apply":"تطبيق",
                                      style:  TextStyle(
                                        fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                        color: kWhiteColor,
                                        fontWeight: FontWeight.w800,
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
                      ],
                    ),
                  ),
                ),
              );
            }
        );
      },
    );
  }
  String returnChosenDriverOrNot(){
    String theChosenOfWithDriverOrNot = "";
    for (int i = 0; i < (chosenWithDriver.length ?? 0); i++) {
      theChosenOfWithDriverOrNot = "$theChosenOfWithDriverOrNot ${ Get
          .find<StorageService>()
          .activeLocale ==
          SupportedLocales.english
          ? (chosenWithDriver[i]?? "") : (chosenWithDriver[i]?? "")}";
      if ((i + 1) < (chosenWithDriver.length ?? 0)) {
        theChosenOfWithDriverOrNot = "$theChosenOfWithDriverOrNot , ";
      }
    }
    return theChosenOfWithDriverOrNot;
  }
  //bottom sheet modal for period
  choosingWithPeriods(BuildContext context){
    showModalBottomSheet(
      context:context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return GetBuilder<EditingCarRentRequestController>(
            init: EditingCarRentRequestController(context,carData),
            builder: (EditingCarRentRequestController controller) {

              return Container(
                height: Get.height*0.8,

                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [

                        Column(
                          children:
                          listOfPeriods!.map((e){
                            return InkWell(
                              onTap: (){
                                choosingPeriod(e);
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
                                                  color: chosenPeriod.contains(e)
                                                      ? kDarkGreenColor
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            CustomText(
                                              "   ${e}    ",
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
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    e ==  listOfPeriods?.last
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
                        SizedBox(height: 10,),
                        Center(
                          child: InkWell(
                            onTap: (){
                              Navigator.pop(context);
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
                                      Get.find<StorageService>().activeLocale == SupportedLocales.english?"Apply":"تطبيق",
                                      style:  TextStyle(
                                        fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                        color: kWhiteColor,
                                        fontWeight: FontWeight.w800,
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
                      ],
                    ),
                  ),
                ),
              );
            }
        );
      },
    );
  }
  String returnChosenPeriods(){
    String theChosenOfthePeriod = "";
    for (int i = 0; i < (chosenPeriod.length ?? 0); i++) {
      theChosenOfthePeriod = "$theChosenOfthePeriod ${ Get
          .find<StorageService>()
          .activeLocale ==
          SupportedLocales.english
          ? (chosenPeriod[i]?? "") : (chosenPeriod[i]?? "")}";
      if ((i + 1) < (chosenPeriod.length ?? 0)) {
        theChosenOfthePeriod = "$theChosenOfthePeriod , ";
      }
    }
    return theChosenOfthePeriod;
  }
  List<String> gettingChosenDriver(){
    List<String> chosenDriver = [];
    for(String driver in chosenWithDriver){
      if(driver == "السيارة بسائق" || driver =="car with driver" ){
        chosenDriver.add("1");
      }else if(driver == "السيارة بدون سائق" || driver =="car without driver"){
        chosenDriver.add("0");
      }
    }
    return chosenDriver;
  }
  List<String> gettingChosenPeriods(){
    List<String> chosenPeriods = [];
    for(String period in chosenPeriod){
      if(period == "يومى" || period == "daily"){
        chosenPeriods.add("1");
      }else if(period == "أسبوعى" || period == "weekly"){
        chosenPeriods.add("2");
      }else if(period == "شهرى" || period == "monthly"){
        chosenPeriods.add("3");
      }else if(period == " حتى التملك" || period == "until ownership"){
        chosenPeriods.add("4");
      }
    }
    return chosenPeriods;
  }
  checkerIfTheDataChangedOrNot(){
    print(((nameController.text??"") == (carData?.showroomName??"")));
    print(gettingChosenDriver());
    print(carData?.driver??[]);
    print(gettingChosenPeriods());
    print(carData?.type??[]);

    print( (gettingChosenDriver() == (carData?.driver!)));
    print( (gettingChosenPeriods() == (carData?.type!)));
    print( ((chosenYear?.year??"") == (carData?.year??"")));
    print( ((chosenCountry?.id.toString()??"") == (carData?.country?.id.toString()??"")));
    print( ((chosenCity?.id.toString()??"") == (carData?.city?.id.toString()??"")));
    print(  ((chosenCarBrand?.id.toString()??"") == (carData?.make?.id.toString()??"")));
    print( ((chosenCarModel?.id.toString()??"") == (carData?.model?.id.toString()??"")));
    print( (((chosenInsuranceType == "تأمين شامل" ||
            chosenInsuranceType == "Comprehensive Insurance") ? (carData?.incType == 1) :  (carData?.incType == 2))));
    if(((nameController.text??"") == (carData?.showroomName??""))&&
        listEquals(gettingChosenDriver(), carData?.driver) &&
        listEquals(gettingChosenPeriods(), carData?.type) &&
        ((chosenYear?.year??"") == (carData?.year??""))&&
        ((chosenCountry?.id.toString()??"") == (carData?.country?.id.toString()??""))&&
        ((chosenCity?.id.toString()??"") == (carData?.city?.id.toString()??""))&&
        ((chosenCarBrand?.id.toString()??"") == (carData?.make?.id.toString()??""))&&
        ((chosenCarModel?.id.toString()??"") == (carData?.model?.id.toString()??""))&&
        (((chosenInsuranceType == "تأمين شامل" ||
            chosenInsuranceType == "Comprehensive Insurance") ? (carData?.incType == 1) :  (carData?.incType == 2)))){
      AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: Get
            .find<StorageService>()
            .activeLocale ==
            SupportedLocales.english
            ? "please wait ...":"انتظر من فضلك ...",
        desc: Get
            .find<StorageService>()
            .activeLocale ==
            SupportedLocales.english
            ?"You have not changed any data for your added car.":"أنك لم تقوم بتغير اى بينات للسيارتك المضافه",

        btnCancelText: Get
            .find<StorageService>()
            .activeLocale == SupportedLocales.english
            ?"no":"لا",
        btnOkText: Get
            .find<StorageService>()
            .activeLocale == SupportedLocales.english
            ?"yes":"نعم",
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
      return  false;
    }else{
      return  true;
    }
  }
 editingCarToRent(BuildContext context) async {
    if(isSendingData){
      AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: Get
            .find<StorageService>()
            .activeLocale ==
            SupportedLocales.english
            ? "please wait ...":"انتظر من فضلك ...",
        desc: Get
            .find<StorageService>()
            .activeLocale ==
            SupportedLocales.english
            ? "We modify your car data":"نحن نقوم بتعديل بيانات سيارتك",

        btnCancelText: Get
            .find<StorageService>()
            .activeLocale == SupportedLocales.english
            ?"no":"لا",
        btnOkText: Get
            .find<StorageService>()
            .activeLocale == SupportedLocales.english
            ?"yes":"نعم",
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    }else{
      if(checkerIfTheDataChangedOrNot()) {
        isSendingData = true;
        update();

        ResponseModel? data = await CarServices.editingCarToRent(

          nameController.text ?? "",
          carData?.id.toString() ?? "",
          gettingChosenDriver(),
          gettingChosenPeriods(),
          chosenYear?.year ?? "",
          chosenCountry!.id.toString(),
          chosenCity!.id.toString(),
          chosenCarBrand!.id.toString(),
          chosenCarModel!.id.toString(),
          (chosenInsuranceType == "تأمين شامل" ||
              chosenInsuranceType == "Comprehensive Insurance") ? '1' : '2',
        );

        print(data?.msg);
        if (data?.msg == "succeeded") {
          isSendingData = false;
          update();
          final snackBar = SnackBar(content:
          Row(children: [
            const Icon(Icons.check, color: Colors.white,),
            const SizedBox(width: 10,),
            Text(Get
                .find<StorageService>()
                .activeLocale ==
                SupportedLocales.english
                ? 'Your car rental data has been modified.'
                : 'تم تعديل بيانات سيارتك للإيجار ', style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
            ),
          ],),
              backgroundColor: Colors.green
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);


          Get.back();
        }
        else {
          isSendingData = false;
          update();
          final snackBar = SnackBar(content:
          Row(children: [
            const Icon(Icons.close, color: Colors.white,),
            const SizedBox(width: 10,),
            Text(Get
                .find<StorageService>()
                .activeLocale ==
                SupportedLocales.english
                ? 'An error occurred while Adding the car to rent'
                : 'حدث خطأ أثناء تعديل بيانات السيارة للإيجار',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],),
              backgroundColor: Colors.red
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    }
  }

}