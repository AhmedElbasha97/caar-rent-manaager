import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  Info? info;

  ProfileModel({
    this.info,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    info: json["info"] == null ? null : Info.fromJson(json["info"]),
  );

  Map<String, dynamic> toJson() => {
    "info": info?.toJson(),
  };
}

class Info {
  int? id;
  String? name;
  String? email;
  String? phoneCode;
  String? phone;

  Info({
    this.id,
    this.name,
    this.email,
    this.phoneCode,
    this.phone,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneCode: json["phone_code"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone_code": phoneCode,
    "phone": phone,
  };
}