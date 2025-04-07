import 'package:carrentmanger/Utils/api_service.dart';
import 'package:carrentmanger/Utils/memory.dart';
import 'package:carrentmanger/Utils/services.dart';
import 'package:carrentmanger/models/auth_model.dart';
import 'package:carrentmanger/models/profile_model.dart';
import 'package:carrentmanger/models/response_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class AuthServices {
  static ApiService api = ApiService();

  static Future<AuthModel?> logIn(
 String countryCode, String phoneNumber) async {

    // الحصول على التوكن الخاص بـ Firebase Messaging
    String? token = await FirebaseMessaging.instance.getToken();

    // التأكد من أن التوكن ليس null
    if (token == null) {
      return null;
    }

    try {
      // إرسال الطلب إلى الـ API
      var data = await api.request(
        Services.logInEndPoint,
        "POST",
        queryParamters: {
          "phone_code": countryCode,
          "phone": phoneNumber,
          "token": token,
        },
      );

      // التأكد من أن الاستجابة تحتوي على بيانات
      if (data != null) {
        return AuthModel.fromJson(data);
      }
      return null;
    } catch (e) {
      print("Error logging in: $e");
      return null;
    }
  }
  static Future<AuthModel?> signingUp(
      String name,
      String countryCode,
      String phoneNumber,
      String email) async {

    // الحصول على التوكن الخاص بـ Firebase Messaging
    String? token = await FirebaseMessaging.instance.getToken();

    // التأكد من أن التوكن ليس null
    if (token == null) {
      return null;
    }

    try {
      var data = await api.request(
        Services.signUpEndPoint,
        "POST",
        queryParamters: {
          "email": email,
          "name": name,
          "phone_code": countryCode,
          "phone": phoneNumber,
          "token": token,
        },
      );

      // التأكد من أن الاستجابة ليست null
      if (data != null) {
        return AuthModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      print("Error signing up: $e");
      return null;
    }
  }
  static Future<ResponseModel?>activatingAccount() async {

    var data = await api.request(Services.activatingAccountEndPoint, "POST",queryParamters: {
      "user_id":Get.find<StorageService>().getId,    });
    if (data != null) {
      return ResponseModel.fromJson(data);
    }
    return null;
  }
  static Future<ResponseModel?>deletingAccount() async {

    var data = await api.request(Services.deletingAccountEndPoint, "POST",queryParamters: {
      "user_id":Get.find<StorageService>().getId,    });
    if (data != null) {
      return ResponseModel.fromJson(data);
    }
    return null;
  }
  static Future<ProfileModel?>getProfileData() async {
    var data = await api.request(Services.getProfileDataEndPoint, "POST",queryParamters: {
      "mem_id":Get.find<StorageService>().getId,
    });
    if (data != null) {
      return ProfileModel.fromJson(data);
    }
    return null;
  }



}