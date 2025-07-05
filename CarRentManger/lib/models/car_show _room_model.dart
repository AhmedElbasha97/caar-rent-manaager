
import 'dart:convert';

CarShowRoomModel carShowRoomModelFromJson(String str) {
  final jsonData = json.decode(str);
  return CarShowRoomModel.fromJson(jsonData);
}

String carShowRoomModelToJson(CarShowRoomModel data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class CarShowRoomModel {
  String? name;

  CarShowRoomModel({
    this.name,
  });

  factory CarShowRoomModel.fromJson(Map<String, dynamic> json) => CarShowRoomModel(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
