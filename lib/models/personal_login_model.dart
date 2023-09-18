// To parse this JSON data, do
//
//     final personalLoginModel = personalLoginModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PersonalLoginModel personalLoginModelFromJson(String str) =>
    PersonalLoginModel.fromJson(json.decode(str));

String personalLoginModelToJson(PersonalLoginModel data) =>
    json.encode(data.toJson());

class PersonalLoginModel {
  final String refresh;
  final String access;
  final bool isExists;
  final int userId;
  final String userType;

  PersonalLoginModel({
    required this.refresh,
    required this.access,
    required this.isExists,
    required this.userId,
    required this.userType,
  });

  factory PersonalLoginModel.fromJson(Map<String, dynamic> json) =>
      PersonalLoginModel(
        refresh: json["refresh"],
        access: json["access"],
        isExists: json["is_exists"],
        userId: json["user_id"],
        userType: json["user_type"],
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
        "is_exists": isExists,
        "user_id": userId,
        "user_type": userType,
      };
}
