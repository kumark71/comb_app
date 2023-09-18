// To parse this JSON data, do
//
//     final professionalLoginModel = professionalLoginModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProfessionalLoginModel professionalLoginModelFromJson(String str) =>
    ProfessionalLoginModel.fromJson(json.decode(str));

String professionalLoginModelToJson(ProfessionalLoginModel data) =>
    json.encode(data.toJson());

class ProfessionalLoginModel {
  final String refresh;
  final String access;
  final int userId;
  final String userType;
  final bool isExists;
  final String status;

  ProfessionalLoginModel({
    required this.refresh,
    required this.access,
    required this.userId,
    required this.userType,
    required this.isExists,
    required this.status,
  });

  factory ProfessionalLoginModel.fromJson(Map<String, dynamic> json) =>
      ProfessionalLoginModel(
        refresh: json["refresh"],
        access: json["access"],
        userId: json["user_id"],
        userType: json["user_type"],
        isExists: json["is_exists"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
        "user_id": userId,
        "user_type": userType,
        "is_exists": isExists,
        "status": status,
      };
}
