// To parse this JSON data, do
//
//     final personalResultModel = personalResultModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<PersonalResultModel> personalResultModelFromJson(String str) =>
    List<PersonalResultModel>.from(
        json.decode(str).map((x) => PersonalResultModel.fromJson(x)));

String personalResultModelToJson(List<PersonalResultModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PersonalResultModel {
  final int id;
  final int personalId;
  final String perpapValue;
  final DateTime reportedDate;
  final String fullName;
  final int age;
  final String gender;
  final String state;

  PersonalResultModel({
    required this.id,
    required this.personalId,
    required this.perpapValue,
    required this.reportedDate,
    required this.fullName,
    required this.age,
    required this.gender,
    required this.state,
  });

  factory PersonalResultModel.fromJson(Map<String, dynamic> json) =>
      PersonalResultModel(
        id: json["id"],
        personalId: json["personal_id"],
        perpapValue: json["perpap_value"],
        reportedDate: DateTime.parse(json["reported_date"]),
        fullName: json["full_name"],
        age: json["age"],
        gender: json["gender"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "personal_id": personalId,
        "perpap_value": perpapValue,
        "reported_date": reportedDate.toIso8601String(),
        "full_name": fullName,
        "age": age,
        "gender": gender,
        "state": state,
      };
}
