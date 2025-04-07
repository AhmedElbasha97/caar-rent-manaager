// To parse this JSON data, do
//
//     final appDepartmentModel = appDepartmentModelFromJson(jsonString);

import 'dart:convert';

List<AppDepartmentModel> appDepartmentModelFromJson(String str) => List<AppDepartmentModel>.from(json.decode(str).map((x) => AppDepartmentModel.fromJson(x)));

String appDepartmentModelToJson(List<AppDepartmentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AppDepartmentModel {
  int? siteCars;
  int? addCars;
  int? carRentRequest;

  AppDepartmentModel({
    this.siteCars,
    this.addCars,
    this.carRentRequest,
  });

  factory AppDepartmentModel.fromJson(Map<String, dynamic> json) => AppDepartmentModel(
    siteCars: json["site_cars"],
    addCars: json["add_cars"],
    carRentRequest: json["car_rent_request"],
  );

  Map<String, dynamic> toJson() => {
    "site_cars": siteCars,
    "add_cars": addCars,
    "car_rent_request": carRentRequest,
  };
}
