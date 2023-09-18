import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage extends GetxController {
  static final sstorage = FlutterSecureStorage();

  Future setToken(access, refresh) async {
    await sstorage.write(key: "accesstoken", value: access);
    await sstorage.write(key: "refreshtoken", value: refresh);
  }

  Future setProfile(
      access,
      refresh,
      profileId,
      name,
      age,
      gender,
      state,
      profilepic,
      profileType,
      account_type,
      organizationName,
      mobile,
      isFirstTime,
      professioalUserStatus) async {
    print("prited from set profile" +
        "access : " +
        access.toString() +
        "refresh : " +
        refresh.toString() +
        "profileId : " +
        profileId.toString() +
        "name : " +
        name.toString() +
        "age : " +
        age.toString() +
        "gender : " +
        gender.toString() +
        "state : " +
        state.toString() +
        "profilepic : " +
        profilepic.toString() +
        "profileType : " +
        profileType.toString() +
        "account_type : " +
        account_type.toString() +
        "organizationName : " +
        organizationName.toString() +
        "mobile : " +
        mobile.toString() +
        "isFirstTime : " +
        isFirstTime.toString() +
        " professioalUserStatus : " +
        professioalUserStatus.toString());
    await sstorage.write(key: "accesstoken", value: access);
    await sstorage.write(key: "refreshtoken", value: refresh);
    await sstorage.write(key: "profileId", value: profileId.toString());
    await sstorage.write(key: "name", value: name);
    await sstorage.write(key: "age", value: age.toString());
    await sstorage.write(key: "profileType", value: profileType);
    await sstorage.write(key: "accountType", value: account_type);
    await sstorage.write(key: "mobileNumber", value: mobile);
    await sstorage.write(key: "gender", value: gender);
    await sstorage.write(key: "profilepic", value: profilepic);
    await sstorage.write(key: "state", value: state);
    await sstorage.write(key: "organizationName", value: organizationName);
    await sstorage.write(key: "isFirstTime", value: isFirstTime.toString());
    await sstorage.write(
        key: "professioalUserStatus", value: professioalUserStatus.toString());
  }

  Future getprofile() async {
    var details = <String, dynamic>{};
    try {
      details['accesstoken'] = await sstorage.read(key: "accesstoken") ?? "";
      details['refreshtoken'] = await sstorage.read(key: "refreshtoken") ?? "";
      details['profileId'] = await sstorage.read(key: "profileId") ?? "";
      details['name'] = await sstorage.read(key: "name") ?? "";
      details['age'] = await sstorage.read(key: "age") ?? "";
      details['gender'] = await sstorage.read(key: "gender") ?? "";
      details['state'] = await sstorage.read(key: "state") ?? "";
      details['profilepic'] = await sstorage.read(key: "profilepic") ?? "";
      details['profileType'] = await sstorage.read(key: "profileType") ?? "";
      details['mobileNumber'] = await sstorage.read(key: "mobileNumber") ?? "";
      details['accountType'] = await sstorage.read(key: "accountType") ?? "";
      details['organizationName'] =
          await sstorage.read(key: "organizationName");
      details['isFirstTime'] = await sstorage.read(key: "isFirstTime") ?? "";
      details['professioalUserStatus'] =
          await sstorage.read(key: "professioalUserStatus") ?? "";
      return details;
    } catch (e) {
      log(e.toString());
      return details;
    }
  }

  Future logout() async {
    sstorage.deleteAll();
    await sstorage.write(key: "isFirstTime", value: "false");
  }

  Future setLocale(String value) async {
    await sstorage.write(key: "local", value: value);
  }

  Future<String?> getLocal() {
    return sstorage.read(key: "local");
  }
}
