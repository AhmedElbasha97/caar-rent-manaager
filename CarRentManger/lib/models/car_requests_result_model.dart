import 'dart:convert';

List<CarRequestResultModel> carRequestResultModelFromJson(String str) => List<CarRequestResultModel>.from(json.decode(str).map((x) => CarRequestResultModel.fromJson(x)));

String carRequestResultModelToJson(List<CarRequestResultModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CarRequestResultModel {
  int? id;
  String? make;
  String? model;
  String? year;
  List<String>? driver;
  List<String>? type;
  String? link;
  String? img;

  CarRequestResultModel({
    this.id,
    this.make,
    this.model,
    this.year,
    this.driver,
    this.type,
    this.link,
    this.img,
  });

  factory CarRequestResultModel.fromJson(Map<String, dynamic> json) => CarRequestResultModel(
    id: json["id"],
    make: json["make"],
    model: json["model"],
    year: "${json["year"]}",
    driver: json["driver"] == null ? [] : List<String>.from(json["driver"]!.map((x) => x)),
    type: json["type"] == null ? [] : List<String>.from(json["type"]!.map((x) => x)),
    link: json["link"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "make": make,
    "model": model,
    "year": year,
    "driver": driver == null ? [] : List<dynamic>.from(driver!.map((x) => x)),
    "type": type == null ? [] : List<dynamic>.from(type!.map((x) => x)),
    "link": link,
    "img": img,
  };
}