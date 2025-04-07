// To parse this JSON data, do
//
//     final countryCodeModel = countryCodeModelFromJson(jsonString);

import 'dart:convert';

List<CountryCodeModel> countryCodeModelFromJson(String str) => List<CountryCodeModel>.from(json.decode(str).map((x) => CountryCodeModel.fromJson(x)));

String countryCodeModelToJson(List<CountryCodeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryCodeModel {
  int? id;
  String? name;
  String? code;
  String? flag;

  CountryCodeModel({
    this.id,
    this.name,
    this.code,
    this.flag,
  });

  factory CountryCodeModel.fromJson(Map<String, dynamic> json) => CountryCodeModel(
    id: json["id"],
    name: json["name"],
    code: "${json["code"]}",
    flag: json["flag"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "flag": flag,
  };
}
