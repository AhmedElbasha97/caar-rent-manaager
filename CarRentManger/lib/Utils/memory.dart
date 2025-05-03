import 'dart:ui';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localization_services.dart';

abstract class StorageKeys {
  StorageKeys();
  static const String activeLocale = "ACTIVE_LOCAL";
  static const String userId = "User_Id";
  static const String userOtp = "User_OTP";
  static const String username = "User_Name";
  static const String signingUp = "signing_Up";
  static const String notificationPage = "Notification_Page";
  static const String notificationPageId = "Notification_Page_Id";
  static const String userPhoneNumber = "User_Phone_Number";
  static const String userCountryCode = "User_Country_Code";
}

class StorageService extends GetxService {
  StorageService(this._prefs);

  final SharedPreferences _prefs;

  static Future<StorageService> init() async {
    // await GetStorage.init();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  //to save id of the account
  Future<void> saveAccountId(String userId) async =>
      _prefs.setString(StorageKeys.userId, userId);
  Future<void> saveAccountOtp(String checker) async =>
      _prefs.setString(StorageKeys.userOtp, checker);
  Future<void> saveAccountName(String userName) async =>
      _prefs.setString(StorageKeys.username, userName);
  Future<void> saveNotificationPage(String notificationPage) async =>
      _prefs.setString(StorageKeys.notificationPage, notificationPage);
  Future<void> saveNotificationPageId(String notificationPageId) async =>
      _prefs.setString(StorageKeys.notificationPageId, notificationPageId);
  Future<void> saveUserPhoneNumber(String userPhoneNumber) async =>
      _prefs.setString(StorageKeys.userPhoneNumber, userPhoneNumber);
  Future<void> saveUserCountryCode(String userCountryCode) async =>
      _prefs.setString(StorageKeys.userCountryCode, userCountryCode);


  Future<void> saveCheckerSigningUp(bool checker) async =>
      _prefs.setBool(StorageKeys.signingUp, checker);



  String get getId {
    return _prefs.getString(StorageKeys.userId)?? "0";
  }
  String get getUserOtp {
    return _prefs.getString(StorageKeys.userOtp)?? "0";
  }
  String get getUserName {
    return _prefs.getString(StorageKeys.username)?? "0";
  }
  String get getNotificationPage {
    return _prefs.getString(StorageKeys.notificationPage)?? "0";
  }
  String get getNotificationPageId {
    return _prefs.getString(StorageKeys.notificationPageId)?? "0";
  }
  String get getUserPhoneNumber {
    return _prefs.getString(StorageKeys.userPhoneNumber)?? "0";
  }
  String get getUserCountryCode {
    return _prefs.getString(StorageKeys.userCountryCode)?? "0";
  }
  bool get getCheckerSigningUp {
    return _prefs.getBool(StorageKeys.signingUp)??true;
  }


  removeOtpCode(){
    _prefs.remove(StorageKeys.userOtp);
    _prefs.remove(StorageKeys.signingUp);
    _prefs.remove(StorageKeys.userPhoneNumber);
    _prefs.remove(StorageKeys.userCountryCode);
  }

  loggingOut(){
    _prefs.remove(StorageKeys.userId);
  }
  //
  // to check if user record dismissal or not
  bool get checkUserIsSignedIn  {
    return _prefs.containsKey(StorageKeys.userId);
  }
  bool get checkUserHasOtpAlready  {
    return _prefs.containsKey(StorageKeys.userOtp);
  }
  bool get checkIfThereIsNotificationPage  {
    return _prefs.containsKey(StorageKeys.notificationPage);

  }bool get checkIfThereIsNotificationPageId  {
    return _prefs.containsKey(StorageKeys.notificationPageId);
  }



  //Active Locale
  Locale get activeLocale {
    return Locale(_prefs.getString(StorageKeys.activeLocale) ??
        SupportedLocales.arabic.toString());
  }

  set activeLocale(Locale activeLocal) {
    _prefs.setString(StorageKeys.activeLocale, activeLocal.toString());
  }
}