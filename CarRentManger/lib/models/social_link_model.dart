// To parse this JSON data, do
//
//     final socialLinkModel = socialLinkModelFromJson(jsonString);

import 'dart:convert';

List<SocialLinkModel> socialLinkModelFromJson(String str) => List<SocialLinkModel>.from(json.decode(str).map((x) => SocialLinkModel.fromJson(x)));

String socialLinkModelToJson(List<SocialLinkModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SocialLinkModel {
  String? facebook;
  String? x;
  String? instagram;
  String? youtube;
  String? android;
  String? ios;
  String? whatsapp;

  SocialLinkModel({
    this.facebook,
    this.x,
    this.instagram,
    this.youtube,
    this.android,
    this.ios,
    this.whatsapp,
  });

  factory SocialLinkModel.fromJson(Map<String, dynamic> json) => SocialLinkModel(
    facebook: json["facebook"],
    x: json["x"],
    instagram: json["instagram"],
    youtube: json["youtube"],
    android: json["android"],
    ios: json["ios"],
    whatsapp: json["whatsapp"],
  );

  Map<String, dynamic> toJson() => {
    "facebook": facebook,
    "x": x,
    "instagram": instagram,
    "youtube": youtube,
    "android": android,
    "ios": ios,
    "whatsapp": whatsapp,
  };
}
