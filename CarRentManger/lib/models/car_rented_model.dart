// To parse this JSON data, do
//
//     final carRentedModel = carRentedModelFromJson(jsonString);

import 'dart:convert';

List<CarRentedModel> carRentedModelFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<CarRentedModel>.from(jsonData.map((x) => CarRentedModel.fromJson(x)));
}

String carRentedModelToJson(List<CarRentedModel> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class CarRentedModel {
  int? id;
  City? country;
  City? city;
  Make? make;
  Make? model;
  String? year;
  String? showroomName;
  List<String>? driver;
  int? incType;
  List<String>? type;
  List<String>? imgs;
  int? edit;
  int? status;

  CarRentedModel({
    this.id,
    this.country,
    this.city,
    this.make,
    this.model,
    this.year,
    this.showroomName,
    this.driver,
    this.incType,
    this.type,
    this.imgs,
    this.edit,
    this.status,
  });

  factory CarRentedModel.fromJson(Map<String, dynamic> json) => new CarRentedModel(
    id: json["id"] == null ? null : json["id"],
    country: json["country"] == null ? null : City.fromJson(json["country"]),
    city: json["city"] == null ? null : City.fromJson(json["city"]),
    make: json["make"] == null ? null : Make.fromJson(json["make"]),
    model: json["model"] == null ? null : Make.fromJson(json["model"]),
    year: "${json["year"]}",
    showroomName: json["showroom_name"] == null ? null : json["showroom_name"],
    driver: json["driver"] == null ? null : new List<String>.from(json["driver"].map((x) => x)),
    incType: json["inc_type"] == null ? null : json["inc_type"],
    type: json["type"] == null ? null : new List<String>.from(json["type"].map((x) => x)),
    imgs: json["imgs"] == null ? null : new List<String>.from(json["imgs"].map((x) => x)),
    edit: json["edit"] == null ? null : json["edit"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "country": country == null ? null : country?.toJson(),
    "city": city == null ? null : city?.toJson(),
    "make": make == null ? null : make?.toJson(),
    "model": model == null ? null : model?.toJson(),
    "year": year == null ? null : year,
    "showroom_name": showroomName == null ? null : showroomName,
    "driver": driver == null ? null : List<dynamic>.from(driver!.map((x) => x)),
    "inc_type": incType == null ? null : incType,
    "type": type == null ? null : List<dynamic>.from(type!.map((x) => x)),
    "imgs": imgs == null ? null : List<dynamic>.from(imgs!.map((x) => x)),
    "edit": edit == null ? null : edit,
    "status": status == null ? null : status,
  };
}

class City {
  int? id;
  String? name;
  String? nameEn;

  City({
    this.id,
    this.name,
    this.nameEn,
  });

  factory City.fromJson(Map<String, dynamic> json) => new City(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    nameEn: json["name_en"] == null ? null : json["name_en"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "name_en": nameEn == null ? null : nameEn,
  };
}

class Make {
  int? id;
  String? name;

  Make({
    this.id,
    this.name,
  });

  factory Make.fromJson(Map<String, dynamic> json) => new Make(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}
