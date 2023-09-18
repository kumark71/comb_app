// To parse this JSON data, do
//
//     final professionalUserModel = professionalUserModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProfessionalUserModel professionalUserModelFromJson(String str) =>
    ProfessionalUserModel.fromJson(json.decode(str));

String professionalUserModelToJson(ProfessionalUserModel data) =>
    json.encode(data.toJson());

class ProfessionalUserModel {
  final AccountsInfo accountsInfo;

  ProfessionalUserModel({
    required this.accountsInfo,
  });

  factory ProfessionalUserModel.fromJson(Map<String, dynamic> json) =>
      ProfessionalUserModel(
        accountsInfo: AccountsInfo.fromJson(json["accountsInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "accountsInfo": accountsInfo.toJson(),
      };
}

class AccountsInfo {
  final int id;
  final String fullName;
  final String profileType;
  final String profilePic;
  final String state;
  final String status;
  final String organizationName;
  final String phoneNumber;
  final String userType;

  AccountsInfo({
    required this.id,
    required this.fullName,
    required this.profileType,
    required this.profilePic,
    required this.state,
    required this.status,
    required this.organizationName,
    required this.phoneNumber,
    required this.userType,
  });

  factory AccountsInfo.fromJson(Map<String, dynamic> json) => AccountsInfo(
        id: json["id"],
        fullName: json["full_name"],
        profileType: json["profile_type"] ?? "",
        profilePic: json["profile_pic"],
        state: json["state"],
        status: json["status"],
        organizationName: json["organization_name"],
        phoneNumber: json["phone_number"],
        userType: json["user_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "profile_type": profileType,
        "profile_pic": profilePic,
        "state": state,
        "status": status,
        "organization_name": organizationName,
        "phone_number": phoneNumber,
        "user_type": userType,
      };
}
