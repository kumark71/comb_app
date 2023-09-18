// To parse this JSON data, do
//
//     final professionalResultModel = professionalResultModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ProfessionalResultModel> professionalResultModelFromJson(String str) =>
    List<ProfessionalResultModel>.from(
        json.decode(str).map((x) => ProfessionalResultModel.fromJson(x)));

String professionalResultModelToJson(List<ProfessionalResultModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfessionalResultModel {
  final int id;
  final int patientId;
  final String perpapValue;
  final DateTime reportedDate;
  final String fullName;
  final int age;
  final String gender;
  final String state;

  ProfessionalResultModel({
    required this.id,
    required this.patientId,
    required this.perpapValue,
    required this.reportedDate,
    required this.fullName,
    required this.age,
    required this.gender,
    required this.state,
  });

  factory ProfessionalResultModel.fromJson(Map<String, dynamic> json) =>
      ProfessionalResultModel(
        id: json["id"],
        patientId: json["patient_id"],
        perpapValue: json["perpap_value"],
        reportedDate: DateTime.parse(json["reported_date"]),
        fullName: json["full_name"],
        age: json["age"],
        gender: json["gender"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "patient_id": patientId,
        "perpap_value": perpapValue,
        "reported_date": reportedDate.toIso8601String(),
        "full_name": fullName,
        "age": age,
        "gender": gender,
        "state": state,
      };
}
