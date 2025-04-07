// To parse this JSON data, do
//
//     final yearsModel = yearsModelFromJson(jsonString);

import 'dart:convert';

List<YearsModel> yearsModelFromJson(String str) => List<YearsModel>.from(json.decode(str).map((x) => YearsModel.fromJson(x)));

String yearsModelToJson(List<YearsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class YearsModel {
  String? year;

  YearsModel({
    this.year,
  });

  factory YearsModel.fromJson(Map<String, dynamic> json) => YearsModel(
    year: "${json["year"]}",
  );

  Map<String, dynamic> toJson() => {
    "year": year,
  };
}
