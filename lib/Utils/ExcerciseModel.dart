// To parse this JSON data, do
//
//     final excerciseModel = excerciseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ExcerciseModel> excerciseModelFromJson(String str) => List<ExcerciseModel>.from(json.decode(str).map((x) => ExcerciseModel.fromJson(x)));

String excerciseModelToJson(List<ExcerciseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExcerciseModel {
  final String excericeName;
  final String description;
  final String videoLink;
  final String equipment;

  ExcerciseModel({
    required this.excericeName,
    required this.description,
    required this.videoLink,
    required this.equipment,
  });

  factory ExcerciseModel.fromJson(Map<String, dynamic> json) => ExcerciseModel(
    excericeName: json["Excerice Name"],
    description: json["Description"],
    videoLink: json["VideoLink"],
    equipment: json["EQUIPMENT"],
  );

  Map<String, dynamic> toJson() => {
    "Excerice Name": excericeName,
    "Description": description,
    "VideoLink": videoLink,
    "EQUIPMENT": equipment,
  };
}
