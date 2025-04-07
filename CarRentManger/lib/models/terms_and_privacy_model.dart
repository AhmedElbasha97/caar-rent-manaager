// To parse this JSON data, do
//
//     final termsAndPrivacyModel = termsAndPrivacyModelFromJson(jsonString);

import 'dart:convert';

List<TermsAndPrivacyModel> termsAndPrivacyModelFromJson(String str) => List<TermsAndPrivacyModel>.from(json.decode(str).map((x) => TermsAndPrivacyModel.fromJson(x)));

String termsAndPrivacyModelToJson(List<TermsAndPrivacyModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TermsAndPrivacyModel {
  String? title;
  String? titleEn;
  String? desc;
  String? descEn;

  TermsAndPrivacyModel({
    this.title,
    this.titleEn,
    this.desc,
    this.descEn,
  });

  factory TermsAndPrivacyModel.fromJson(Map<String, dynamic> json) => TermsAndPrivacyModel(
    title: json["title"],
    titleEn: json["title_en"],
    desc: json["desc"],
    descEn: json["desc_en"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "title_en": titleEn,
    "desc": desc,
    "desc_en": descEn,
  };
}
