// To parse this JSON data, do
//
//     final personalUserModel = personalUserModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PersonalUserModel personalUserModelFromJson(String str) =>
    PersonalUserModel.fromJson(json.decode(str));

String personalUserModelToJson(PersonalUserModel data) =>
    json.encode(data.toJson());

class PersonalUserModel {
  final AccountsInfo accountsInfo;

  PersonalUserModel({
    required this.accountsInfo,
  });

  factory PersonalUserModel.fromJson(Map<String, dynamic> json) =>
      PersonalUserModel(
        accountsInfo: AccountsInfo.fromJson(json["accountsInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "accountsInfo": accountsInfo.toJson(),
      };
}

class AccountsInfo {
  final int id;
  final String fullName;
  final String profilePic;
  final int age;
  final String gender;
  final String state;
  final String phoneNumber;
  final String userType;

  AccountsInfo({
    required this.id,
    required this.fullName,
    required this.profilePic,
    required this.age,
    required this.gender,
    required this.state,
    required this.phoneNumber,
    required this.userType,
  });

  factory AccountsInfo.fromJson(Map<String, dynamic> json) => AccountsInfo(
        id: json["id"],
        fullName: json["full_name"],
        profilePic: json["profile_pic"],
        age: json["age"],
        gender: json["gender"],
        state: json["state"],
        phoneNumber: json["phone_number"],
        userType: json["user_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "profile_pic": profilePic,
        "age": age,
        "gender": gender,
        "state": state,
        "phone_number": phoneNumber,
        "user_type": userType,
      };
}
