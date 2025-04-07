import 'dart:io';

import 'package:carrentmanger/Utils/api_service.dart';
import 'package:carrentmanger/Utils/memory.dart';
import 'package:carrentmanger/Utils/services.dart';
import 'package:carrentmanger/models/car_rented_model.dart';
import 'package:carrentmanger/models/car_requests_model.dart';
import 'package:carrentmanger/models/car_requests_result_model.dart';
import 'package:carrentmanger/models/category_model.dart';
import 'package:carrentmanger/models/response_model.dart';
import 'package:carrentmanger/models/years_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class CarServices{
  static ApiService api = ApiService();
  static Future<List<CategoryModel>?>getCarBrandsList() async {
    List<CategoryModel>? carBrandsList = [];
    var data = await api.request(Services.getCarBrandsEndPoint, "POST",queryParamters: {
    });
    if (data != null) {
      for(var carBrandData  in data){
        carBrandsList.add(CategoryModel.fromJson(carBrandData));
      }
      return carBrandsList;
    }
    return null;
  }
  static Future<List<CarRequestModel>?>getCarRequestsList() async {
    List<CarRequestModel>? carRequestsList = [];
    var data = await api.request(Services.getCarRequestsEndPoint, "POST",queryParamters: {
      "mem_id":Get.find<StorageService>().getId,

    });
    if (data != null) {
      for(var carRequestData  in data){
        carRequestsList.add(CarRequestModel.fromJson(carRequestData));
      }
      return carRequestsList;
    }
    return null;
  }
  static Future<List<CarRequestResultModel>?>getCarRequestsResultsList(String requestId) async {
    List<CarRequestResultModel>? carRequestsResultsList = [];
    var data = await api.request(Services.getCarRequestsResultsEndPoint, "POST",queryParamters: {
      "mem_id":Get.find<StorageService>().getId,
      "request_id": requestId,

    });
    if (data != null) {
      for(var carRequestResultData  in data){
        carRequestsResultsList.add(CarRequestResultModel.fromJson(carRequestResultData));
      }
      return carRequestsResultsList;
    }
    return null;
  }

  static Future<List<CarRentedModel>?>getRentedCarsList() async {
    List<CarRentedModel>? rentedCarsList = [];
    var data = await api.request(Services.getRentedCarsEndPoint, "POST",queryParamters: {
      "mem_id":Get.find<StorageService>().getId,
    });
    if (data != null) {
      for(var rentedCarData  in data){
        rentedCarsList.add(CarRentedModel.fromJson(rentedCarData));
      }
      return rentedCarsList;
    }
    return null;
  }

  static Future<List<CategoryModel>?>getCarModelsList(String carBrandId) async {
    List<CategoryModel>? carModelsList = [];
    var data = await api.request(Services.getCarModelsEndPoint, "POST",queryParamters: {
      "make_id":carBrandId,

    });
    if (data != null) {
      for(var carBrandData  in data){
        carModelsList.add(CategoryModel.fromJson(carBrandData));
      }
      return carModelsList;
    }
    return null;
  }

  static Future<List<YearsModel>?>getYearsList() async {
    List<YearsModel>? yearsList = [];
    var data = await api.request(Services.getYearsEndPoint, "POST",queryParamters: {
    });
    if (data != null) {
      for(var yearData  in data){
        yearsList.add(YearsModel.fromJson(yearData));
      }
      return yearsList;
    }
    return null;
  }

  static Future<ResponseModel?>searchingForSpecialCar(List<String> withDriverOrNot,List<String> thePeriodOfRenting,String countryId,String cityId,String carBrandId,String carModelId,String carYearFrom,String carYearTo) async {
    var data = await api.request(Services.searchingForSpecialCarEndPoint, "POST",queryParamters: {
      "mem_id":Get.find<StorageService>().getId,
      "country_id":countryId,
      "city_id":cityId,
      "driver[]":withDriverOrNot.join('|'),
      "type[]":thePeriodOfRenting.join('|'),
      "make_id":carBrandId,
      "model_id":carModelId,
      "car_year_from":carYearFrom,
      "car_year_to":carYearTo,

    });
    if (data != null) {
      return ResponseModel.fromJson(data);
    }
    return null;
  }

  static Future<ResponseModel?>addingCarToRent(String showRoomName,List<String>? withDriverOrNot,List<String>? thePeriodOfRenting,String chosenYearOfManfacture,String countryId,String cityId,String carBrandId,String carModelId,String insuranceType, List<File>? imagesFile) async {
    final formData = dio.FormData.fromMap({
      "mem_id":Get.find<StorageService>().getId,
      "country_id":countryId,
      "city_id":cityId,
      "inc_type": insuranceType,
      "make_id":carBrandId,
      "model_id":carModelId,
      "car_year":chosenYearOfManfacture,
      "driver[]":withDriverOrNot?.join('|'),
      "type[]":thePeriodOfRenting?.join('|'),
      "showroom_name":showRoomName,
    });
    for (int i = 0; i < (imagesFile?.length??0); i++) {
      String fileName = imagesFile?[i].path
          .split('/')
          .last ?? "";
      formData.files.add(
        MapEntry(
          "imgs[]", // Key for the backend
          await dio.MultipartFile.fromFile(
              imagesFile?[i].path??"", filename: fileName),
        ),
      );
    }
    var data = await api.request(Services.addingCarEndPoint, "POST",data: formData);
    if (data != null) {
      return ResponseModel.fromJson(data);
    }
    return null;
  }
  static Future<ResponseModel?>pausingCarRequest(String requestId,) async {
    var data = await api.request(Services.pausingCarRequestEndPoint, "POST",data: {
      "mem_id":Get.find<StorageService>().getId,
      "req_id":requestId,


    });
    if (data != null) {
      return ResponseModel.fromJson(data);
    }
    return null;
  }
  static Future<ResponseModel?>pausingRentingCar(String rentedCarId,) async {
    var data = await api.request(Services.pausingRentingCarEndPoint, "POST",data: {
      "mem_id":Get.find<StorageService>().getId,
      "req_id":rentedCarId,


    });
    if (data != null) {
      return ResponseModel.fromJson(data);
    }
    return null;
  }

}