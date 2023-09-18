import 'dart:convert';
import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:hemoqr/controllers/secure_storage.dart';
import 'package:hemoqr/models/personal_login_model.dart';
import 'package:hemoqr/models/professional_login_model.dart';
import 'package:hemoqr/providers/api_providers.dart';
import 'package:hemoqr/ui/utils/constants.dart';

class AuthController extends GetxController {
  var accessToken = ''.obs;
  var refreshToken = ''.obs;
  var phoneNumber = ''.obs;
  var uid = "".obs;
  var name = ''.obs;
  var age = ''.obs;
  var image = ''.obs;
  var gender = ''.obs;
  var state = ''.obs;
  var organizationName = ''.obs;
  var profile_type = ''.obs;
  var account_type = ''.obs;
  var test_type = ''.obs;
  var profilePic = "".obs;
  var mobileNo = "".obs;
  bool isOldUser = true;
  bool isLogin = false;
  bool isProfessional = false;

  // Professional
  var ProfessionalUserStatus = "".obs;

  String isFirstTime = "true";
  var lat = "".obs;
  var long = "".obs;

  @override
  void onInit() async {
    super.onInit();

    FirebaseAnalytics.instance.logEvent(name: "app_start");
  }

  Future getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission asked = await Geolocator.requestPermission();
      // if (asked == LocationPermission.denied || asked == LocationPermission.deniedForever) {}
    }
    Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    lat.value = currentPosition.latitude.toString();
    long.value = currentPosition.longitude.toString();
    print("lat ${lat.value} | long  ${long.value} ");
  }

  login(response) {
    print("before auth login ");
    if (response != null) {
      if (isProfessional == false) {
        PersonalLoginModel logindetails = response;
        print("isExist : " + logindetails.isExists.toString());
        accessToken.value = logindetails.access;
        refreshToken.value = logindetails.refresh;
        isOldUser = logindetails.isExists;
        uid.value = logindetails.userId.toString();
        account_type.value = logindetails.userType;
        //P Means Personal MR : Means Professional
        isProfessional = false;
        if (isOldUser == false) {
          Get.offAndToNamed("/personalAccount");
        } else {
          saveUser().then(
            (value) => {
              Get.offAllNamed("/home"),
            },
          );
        }
      } else {
        log("Prof : Inside the Professional Login ");
        ProfessionalLoginModel logindetails = response;
        print(logindetails);
        accessToken.value = logindetails.access;
        refreshToken.value = logindetails.refresh;
        isOldUser = logindetails.isExists;
        uid.value = logindetails.userId.toString();
        account_type.value = logindetails.userType;
        ProfessionalUserStatus.value = logindetails.status;
        isProfessional = true;
        log("Prof : isProfessional " + isProfessional.toString());
        if (isOldUser == false) {
          Get.offAndToNamed("/professionalAccount");
        } else {
          saveUser().then(
            (value) {
              if (ProfessionalUserStatus == "0") {
                Get.offAllNamed("/accountStatus");
              } else if (ProfessionalUserStatus.value == "1") {
                Get.offAllNamed("/home");
              } else if (ProfessionalUserStatus.value == "2") {
                Get.offAllNamed("/accountStatus");
              } else if (ProfessionalUserStatus.value == "3") {
                Get.offAllNamed("/accountStatus");
              }
            },
          );
        }
      }
    } else {
      Constants.showMessage("Error", "Storing login details failed");
    }

    // secureStorage.setProfile()
  }

  Future saveUser() async {
    if (isProfessional == false) {
      await ApiServices().getPersonDetails().then((value) async {
        log("Save User Value : " + value.toString());
        if (value != "null") {
          var jsonResponse = json.decode(json.encode(value));
          log("saveing => ${jsonResponse['accountsInfo']}");

          SecureStorage secureStorage = Get.find();
          await secureStorage.setProfile(
              accessToken.value,
              refreshToken.value,
              jsonResponse['accountsInfo']['id'] ?? "",
              jsonResponse['accountsInfo']['full_name'] ?? "",
              jsonResponse['accountsInfo']['age'] ?? "",
              jsonResponse['accountsInfo']['gender'] ?? "",
              jsonResponse['accountsInfo']['state'] ?? "",
              jsonResponse['accountsInfo']['profile_pic'] ?? "",
              jsonResponse['accountsInfo']['profile_type'] ?? "",
              jsonResponse['accountsInfo']['user_type'] ?? "",
              jsonResponse['accountsInfo']['organization_name'] ?? "",
              jsonResponse['accountsInfo']['phone_number'] ?? "",
              false,
              "");

          log("name = ${jsonResponse['accountsInfo']['account_type']}");
          uid.value = jsonResponse['accountsInfo']['id'].toString();
          name.value = jsonResponse['accountsInfo']['full_name'].toString();
          age.value = jsonResponse['accountsInfo']['age'].toString();
          gender.value = jsonResponse['accountsInfo']['gender'].toString();
          state.value = jsonResponse['accountsInfo']['state'].toString();
          profilePic.value =
              jsonResponse['accountsInfo']['profile_pic'].toString();
          account_type.value =
              jsonResponse['accountsInfo']['profile_type'].toString();
          profile_type.value =
              jsonResponse['accountsInfo']['profile_type'].toString();
          organizationName.value =
              jsonResponse['accountsInfo']['organization_name'].toString();
          mobileNo.value =
              jsonResponse['accountsInfo']['phone_number'].toString();
          isFirstTime = "false";
          isProfessional = false;
        } else {
          Get.offAllNamed("/loginPersonal");
        }
      });
    } else {
      print("Inside professional");
      await ApiServices().getProfessionalDetails().then((value) async {
        if (value != null) {
          var jsonResponse = json.decode(json.encode(value));
          log("saveing => ${jsonResponse['accountsInfo']}");

          SecureStorage secureStorage = Get.find();
          await secureStorage.setProfile(
              accessToken.value,
              refreshToken.value,
              jsonResponse['accountsInfo']['id'] ?? "",
              jsonResponse['accountsInfo']['full_name'] ?? "",
              jsonResponse['accountsInfo']['age'] ?? "",
              jsonResponse['accountsInfo']['gender'] ?? "",
              jsonResponse['accountsInfo']['state'] ?? "",
              jsonResponse['accountsInfo']['profile_pic'] ?? "",
              jsonResponse['accountsInfo']['profile_type'] ?? "",
              jsonResponse['accountsInfo']['user_type'] ?? "",
              jsonResponse['accountsInfo']['organization_name'] ?? "",
              jsonResponse['accountsInfo']['phone_number'] ?? "",
              false,
              jsonResponse['accountsInfo']['status'] ?? "");

          log("name = ${jsonResponse['accountsInfo']['account_type']}");
          uid.value = jsonResponse['accountsInfo']['id'].toString();
          name.value = jsonResponse['accountsInfo']['full_name'].toString();
          age.value = jsonResponse['accountsInfo']['age'].toString();
          gender.value = jsonResponse['accountsInfo']['gender'].toString();
          state.value = jsonResponse['accountsInfo']['state'].toString();
          profilePic.value =
              jsonResponse['accountsInfo']['profile_pic'].toString();
          account_type.value =
              jsonResponse['accountsInfo']['profile_type'].toString();
          profile_type.value =
              jsonResponse['accountsInfo']['profile_type'].toString();
          organizationName.value =
              jsonResponse['accountsInfo']['organization_name'].toString();
          mobileNo.value =
              jsonResponse['accountsInfo']['phone_number'].toString();
          isFirstTime = "false";
          isProfessional = true;
          ProfessionalUserStatus.value =
              jsonResponse['accountsInfo']['status'].toString();
        }
      });
    }
  }

  Future loadUser() async {
    SecureStorage secureStorage = Get.find();
    secureStorage.getprofile().then((value) {
      print("********** values of account **********" + value.toString());
      isFirstTime = value['isFirstTime'] ?? "";
      if (value['accesstoken'] != "") {
        print(value);
        isLogin = true;
        accessToken.value = value['accesstoken'] ?? "";
        refreshToken.value = value['refreshtoken'] ?? "";
        uid.value = value['profileId'] ?? "";
        name.value = value['name'] ?? "";
        age.value = value['age'] ?? "";
        gender.value = value['gender'] ?? "";
        state.value = value['state'] ?? "";
        profilePic.value = value['profilepic'] ?? "";
        profile_type.value = value['profileType'] ?? "";
        account_type.value = value['accountType'] ?? "";
        organizationName.value = value['organizationName'] ?? "";
        phoneNumber.value = value['mobileNumber'] ?? "";
        print("Account type" + account_type.toString());

        if (account_type.toLowerCase() == "p") {
          ApiServices().getPersonDetails().then((value) {
            print(value);
            if (value != null) {
              isProfessional = false;

              Get.offAllNamed("/home");
            } else {
              ApiServices().refreshToken().then((value) {
                if (value?.successResponse?.access != null) {
                  accessToken.value = value!.successResponse!.access.toString();
                  if (accessToken != "") {
                    isProfessional = false;

                    Get.offAllNamed("/home");
                  }
                } else {
                  isLogin = false;
                  print(isFirstTime);
                  if (isFirstTime != "false") {
                    Get.offAllNamed("/onboard");
                  } else {
                    Get.offAllNamed("/loginPersonal");
                  }
                }
                // print(jsonString);
              });
            }
          });
        } else {
          ApiServices().getProfessionalDetails().then((value) {
            if (value != null) {
              isProfessional = true;
              var jsonResponse = json.decode(json.encode(value));
              print("Professional : " + jsonResponse.toString());
              ProfessionalUserStatus.value =
                  jsonResponse['accountsInfo']['status'].toString();
              if (jsonResponse['accountsInfo']['status'] == "0") {
                Get.offAllNamed("/accountStatus");
              } else if (jsonResponse['accountsInfo']['status'] == "1") {
                Get.offAllNamed("/home");
              } else if (jsonResponse['accountsInfo']['status'] == "2") {
                Get.offAllNamed("/accountStatus");
              } else if (jsonResponse['accountsInfo']['status'] == "3") {
                Get.offAllNamed("/accountStatus");
              }
            } else {
              ApiServices().refreshToken().then((value) {
                if (value?.successResponse?.access != null) {
                  accessToken.value = value!.successResponse!.access.toString();
                  if (accessToken != "") {
                    isProfessional = true;
                    if (ProfessionalUserStatus == "0") {
                      Get.offAllNamed("/accountStatus");
                    } else if (ProfessionalUserStatus.value == "1") {
                      Get.offAllNamed("/home");
                    } else if (ProfessionalUserStatus.value == "2") {
                      Get.offAllNamed("/accountStatus");
                    } else if (ProfessionalUserStatus.value == "3") {
                      Get.offAllNamed("/accountStatus");
                    }
                  }
                } else {
                  isLogin = false;
                  print(isFirstTime);
                  if (isFirstTime != "false") {
                    Get.offAllNamed("/onboard");
                  } else {
                    Get.offAllNamed("/loginProfessional");
                  }
                }
                // print(jsonString);
              });
            }
          });
        }
      } else {
        print("isFirstTime : " + isFirstTime);
        isLogin = false;
        if (isFirstTime != "false") {
          Get.offAllNamed("/onboard");
        } else {
          Get.offAllNamed("/loginPersonal");
        }
      }
    });
  }

  Future logout() async {
    isProfessional = false;
    SecureStorage secureStorage = Get.find();
    accessToken.value = '';
    phoneNumber.value = '';
    name.value = '';
    image.value = '';
    age.value = '';
    gender.value = '';
    state.value = '';
    organizationName.value = '';
    profile_type.value = '';
    account_type.value = "";
    image.value = '';
    secureStorage.logout();
    Get.offAllNamed('/loginPersonal');
  }
}
