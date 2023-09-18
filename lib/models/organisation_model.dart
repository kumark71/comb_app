// To parse this JSON data, do
//
//     final organizationsModel = organizationsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<OrganizationsModel> organizationsModelFromJson(String str) =>
    List<OrganizationsModel>.from(
        json.decode(str).map((x) => OrganizationsModel.fromJson(x)));

String organizationsModelToJson(List<OrganizationsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrganizationsModel {
  final int id;
  final String organizationName;
  final String smartqrManager;

  OrganizationsModel({
    required this.id,
    required this.organizationName,
    required this.smartqrManager,
  });

  factory OrganizationsModel.fromJson(Map<String, dynamic> json) =>
      OrganizationsModel(
        id: json["id"],
        organizationName: json["organization_name"],
        smartqrManager: json["smartqr_manager"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "organization_name": organizationName,
        "smartqr_manager": smartqrManager,
      };
}
