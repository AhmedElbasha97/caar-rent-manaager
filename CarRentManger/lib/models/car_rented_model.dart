// To parse this JSON data, do
//
//     final carRentedModel = carRentedModelFromJson(jsonString);

import 'dart:convert';

List<CarRentedModel> carRentedModelFromJson(String str) => List<CarRentedModel>.from(json.decode(str).map((x) => CarRentedModel.fromJson(x)));

String carRentedModelToJson(List<CarRentedModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CarRentedModel {
  int? id;
  String? make;
  String? model;
  String? year;
  List<String>? driver;
  List<String>? type;
  List<String>? imgs;
  int? status;

  CarRentedModel({
    this.id,
    this.make,
    this.model,
    this.year,
    this.driver,
    this.type,
    this.imgs,
    this.status,
  });

  factory CarRentedModel.fromJson(Map<String, dynamic> json) => CarRentedModel(
    id: json["id"],
    make: json["make"],
    model: json["model"],
    year: "${json["year"]}",
    driver: json["driver"] == null ? [] : List<String>.from(json["driver"]!.map((x) => x)),
    type: json["type"] == null ? [] : List<String>.from(json["type"]!.map((x) => x)),
    imgs: json["imgs"] == null ? [] : List<String>.from(json["imgs"]!.map((x) => x)),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "make": make,
    "model": model,
    "year": year,
    "driver": driver == null ? [] : List<dynamic>.from(driver!.map((x) => x)),
    "type": type == null ? [] : List<dynamic>.from(type!.map((x) => x)),
    "imgs": imgs == null ? [] : List<dynamic>.from(imgs!.map((x) => x)),
    "status": status,
  };
}
