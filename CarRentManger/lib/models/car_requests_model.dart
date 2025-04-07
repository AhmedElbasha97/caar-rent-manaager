// To parse this JSON data, do
//
//     final carRequestModel = carRequestModelFromJson(jsonString);

import 'dart:convert';

List<CarRequestModel> carRequestModelFromJson(String str) => List<CarRequestModel>.from(json.decode(str).map((x) => CarRequestModel.fromJson(x)));

String carRequestModelToJson(List<CarRequestModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CarRequestModel {
  int? id;
  String? make;
  String? model;
  String? yearFrom;
  String? yearTo;
  List<String>? driver;
  List<String>? type;
  int? status;

  CarRequestModel({
    this.id,
    this.make,
    this.model,
    this.yearFrom,
    this.yearTo,
    this.driver,
    this.type,
    this.status,
  });

  factory CarRequestModel.fromJson(Map<String, dynamic> json) => CarRequestModel(
    id: json["id"],
    make: json["make"],
    model: json["model"],
    yearFrom: "${json["year_from"]}",
    yearTo: "${json["year_to"]}",
    driver: json["driver"] == null ? [] : List<String>.from(json["driver"]!.map((x) => x)),
    type: json["type"] == null ? [] : List<String>.from(json["type"]!.map((x) => x)),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "make": make,
    "model": model,
    "year_from": yearFrom,
    "year_to": yearTo,
    "driver": driver == null ? [] : List<dynamic>.from(driver!.map((x) => x)),
    "type": type == null ? [] : List<dynamic>.from(type!.map((x) => x)),
    "status": status,
  };
}
