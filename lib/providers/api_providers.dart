import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hemoqr/controllers/qr_scanner_controller.dart';
import 'package:hemoqr/models/personal_login_model.dart';
import 'package:hemoqr/models/personal_result_model.dart';
import 'package:hemoqr/models/personal_user_model.dart';
import 'package:hemoqr/models/professional_login_model.dart';
import 'package:hemoqr/models/professional_result_model.dart';
import 'package:hemoqr/models/professional_user_dart.dart';
import 'package:hemoqr/models/refresh_token_model.dart';
import 'package:http/http.dart' as http;
import 'package:hemoqr/ui/utils/constants.dart';
import 'package:hemoqr/controllers/auth_controller.dart';

class ApiServices extends GetConnect {
  AuthController authController = Get.find();
  //*** LOGIN PERSONAL ***//
  Future loginPersonal(jsonArray) async {
    try {
      Response response = await post(
        "${Constants.serverUrl}user/personal/authenticate/",
        jsonEncode(jsonArray),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        return personalLoginModelFromJson(response.bodyString.toString());
      } else {
        print("Personal in api after fail ${response.body}");
        Constants.showMessage("Opps!!", response.body["message"]);
      }
    } catch (e) {
      print("exception =>${e.toString()}");
      return null;
    }
  }

  //*** LOGIN PROFESSIONAL ***//
  Future loginProfessional(jsonArray) async {
    try {
      print("in api before calling");
      final response = await http.post(
        Uri.parse("${Constants.serverUrl}user/professional/authenticate/"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(jsonArray),
      );
      print("in api after calling");
      print(response.body);
      if (response.statusCode == 200) {
        print("in api after success");

        Map<String, dynamic> responseBody = json.decode(response.body);

        print(responseBody["is_exists"]);
        print(responseBody['access']);
        return professionalLoginModelFromJson(response.body);
      } else {
        print("in api after fail ${response.body}");
        // Log the response body
        print(response.body);
        Constants.showMessage("Oops!!", response.reasonPhrase.toString());
        return null; // Return null in case of an error
      }
    } catch (e) {
      print("exception =>${e.toString()}");
      return null; // Return null in case of an exception
    }
  }

  //*** FETCH PERSONAL PROFILE ***//
  Future getPersonDetails() async {
    try {
      Response response = await get(
          "${Constants.serverUrl}user/personal/accounts/",
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authController.accessToken}'
          });

      print(response.bodyString.toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        return personalUserModelFromJson(response.bodyString.toString());
      } else {
        log(response.body);

        return null;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //*** FETCH PROFESSIONAL PROFILE ***//
  Future getProfessionalDetails() async {
    try {
      Response response = await get(
          "${Constants.serverUrl}user/professional/accounts/",
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authController.accessToken}'
          });

      print(response.bodyString.toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        return professionalUserModelFromJson(response.bodyString.toString());
      } else {
        log("This is the : " + response.body);

        return null;
      }
    } catch (e) {
      log("This is the :" + e.toString());
    }
  }

  //*** FETCH ALL ORGANISATIONS ***//
  Future getOrganisations() async {
    try {
      final response = await http.get(
        Uri.parse("${Constants.serverUrl}user/allOrganizations/"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authController.accessToken}',
        },
      );

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        print(response.body);
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //*** CREATE PROFESSIONAL USER  ***//
  Future updateProfessionalProfile(
      name, profileType, state, organization) async {
    try {
      var accessToken = authController.accessToken;
      var lat = authController.lat.value;
      var long = authController.long.value;

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${Constants.serverUrl}user/professional/Profile/"),
      );

      request.headers['Authorization'] = 'Bearer $accessToken';
      request.fields['full_name'] = name;
      request.fields['profile_type'] = profileType.toString()[0];
      request.fields['state'] = state;
      if (lat != "" && long != "") {
        request.fields['latitude'] = lat;
        request.fields['longitude'] = long;
      }
      request.fields['organization_id'] = organization;

      var response = await request.send();
      print(response);

      //Read response content as a string;
      var responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return response;
      } else {
        Constants.showMessage("Error", response.reasonPhrase.toString());
        return null;
      }
    } catch (e) {
      Constants.showMessage("Error", e.toString());
    }
  }

  //*** CREATE PERSONAL USER  ***//
  Future updatePersonalProfile(
      name, age, state, gender, contact, profilepicFile) async {
    try {
      var accessToken = authController.accessToken;
      var lat = authController.lat.value;
      var long = authController.long.value;
      print("lat ${lat}, | long ${long}");
      print(accessToken);
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${Constants.serverUrl}user/personal/Profile/"),
      );
      request.headers['Authorization'] = 'Bearer $accessToken';

      if (name != "") {
        request.fields['full_name'] = name;
      }
      if (contact != "") {
        request.fields['contact_number'] = "+91$contact";
      }
      if (age != "") {
        request.fields['age'] = age;
      }
      if (state != "") {
        request.fields['state'] = state;
      }
      if (gender != "") {
        request.fields['gender'] = gender[0];
      }
      // request.fields['profile_pic'] = profilepicFile;
      if (lat != "" && long != "") {
        request.fields['latitude'] = lat;
        request.fields['longitude'] = long;
      }
      if (profilepicFile != null) {
        var stream = http.ByteStream(profilepicFile.openRead());
        var length = await profilepicFile.length();
        var multipartFile = http.MultipartFile('profile_pic', stream, length,
            filename: profilepicFile.path.split('/').last);
        request.files.add(multipartFile);
      }

      var response = await request.send();
      var responseString = await response.stream
          .bytesToString(); //Read response content as a string

      if (response.statusCode == 200) {
        return responseString;
      } else {
        Constants.showMessage("Error", response.reasonPhrase.toString());
        return null;
      }
    } catch (e) {
      Constants.showMessage("Error", e.toString());
    }
  }

  //*** CREATE PATIENT USER  ***//
  Future createPatient(jsonArray) async {
    try {
      var accessToken = authController.accessToken;
      print(jsonArray);
      Response response = await post(
          "${Constants.serverUrl}user/patient/create/", jsonEncode(jsonArray),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          });
      print(response.statusCode);
      print("patient id " + response.body['patient_id'].toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        Constants.showMessage(
          "Success",
          response.body["message"].toString(),
        );
        return response.body['patient_id'].toString();
      } //else if
      else {
        print(response.body["message"].toString());
        Constants.showMessage(
          "Opps!",
          response.body["message"].toString(),
        );
        print(response.bodyString);
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  //*** SEND OTP  ***//
  Future sendOtp(jsonArray) async {
    print("${Constants.serverUrl}user/generateOtp/");
    try {
      print(jsonEncode(jsonArray));
      Response response = await post(
        "${Constants.serverUrl}user/generateOtp/",
        jsonEncode(jsonArray),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.body != null && response.body.isNotEmpty) {
        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 200) {
          return response.body;
        } else {
          print(response);
          Constants.showMessage("Error", response.body['message'].toString());
        }
      } else {
        print("Response body is empty.");
      }
    } catch (e) {
      print(e);
    }
  }

  //*** UPLOAD IMAGE PERSONAL  ***//
  Future uploadVideoPersonal(imagePath) async {
    // try {
    Get.toNamed("/processing");
    var accessToken = authController.accessToken;
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        "${Constants.serverUrl}app/personal/uploadImage/",
      ), // Replace with your API endpoint
    );
    request.headers['Authorization'] = 'Bearer $accessToken';
    var imageStream =
        http.ByteStream(Stream.castFrom(File(imagePath).openRead()));
    var imageLength = await File(imagePath).length();
    var imageMultipartFile = http.MultipartFile(
        'image_file', imageStream, imageLength,
        filename: 'image.jpg');
    request.files.add(imageMultipartFile);
    var response = await request.send();
    var jsonResponse = await response.stream.bytesToString();
    var decodedResponse = json.decode(jsonResponse);
    print("Upload image response" + decodedResponse.toString());
    if (response.statusCode == 200) {
      print('Video upload Successfull');
      return decodedResponse;
    } else {
      Get.close(1);
      ErrorPopUp(decodedResponse['message']);
      return null;
    }
  }

  //*** UPLOAD IMAGE PROFESSIONAL  ***//
  Future uploadVideoProfessional(imagepath, patientId) async {
    // try {
    Get.toNamed("/processing");
    var accessToken = authController.accessToken;
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        "${Constants.serverUrl}app/professional/uploadImage/",
      ), // Replace with your API endpoint
    );

    request.headers['Authorization'] = 'Bearer $accessToken';
    request.fields['patient_id'] = patientId.toString();
    print(patientId.toString());

    var imageStream =
        http.ByteStream(Stream.castFrom(File(imagepath).openRead()));
    var imageLength = await File(imagepath).length();
    var imageMultipartFile = http.MultipartFile(
        'image_file', imageStream, imageLength,
        filename: 'image.jpg');
    request.files.add(imageMultipartFile);

    var response = await request.send();
    // var responseString = await response.stream.bytesToString();
    // print(responseString);

    var jsonResponse = await response.stream.bytesToString();
    var decodedResponse = json.decode(jsonResponse);
    print("Upload image response" + decodedResponse.toString());
    if (response.statusCode == 200) {
      //  Constants.showMessage("Successfull", responseString['message'] )

      QRScannerController qrScannerController = Get.find();

      print('Video upload Successfull');

      return decodedResponse;
    } else {
      Get.close(1);
      ErrorPopUp(decodedResponse['message']);
      return null;
    }
    // } catch (e) {
    //   Get.close(2);
    //   print('Error uploading video: $e');
    // }
  }

  Future ErrorPopUp(String errormessage) {
    var context = Get.context;

    QRScannerController qrScannerController = Get.find();

    return Get.dialog(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
              height: Get.height * .2,
              width: Get.width * .9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context!).colorScheme.onPrimary,
                    Theme.of(context).colorScheme.onSecondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(
                      "Error While Processing",
                      style:
                          Theme.of(context!).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        errormessage.toString(),
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: Get.width * .25,
                          height: Get.height * .06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Get.close(2);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: Text(
                              "Home",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                        Container(
                          width: Get.width * .25,
                          height: Get.height * .06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Get.close(1);
                              qrScannerController.resetVideoCapture();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: Text(
                              "Retake",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

//*** GET PERSONAL REPORTS  ***//
  Future<List<PersonalResultModel>?> personalReports() async {
    try {
      var accessToken = authController.accessToken;

      Response response = await post(
          "${Constants.serverUrl}app/personal/reports/", jsonEncode({}),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          });
      print(json.decode(response.bodyString.toString()));

      if (response.statusCode == 200) {
        // Constants.showMessage("Success", response.body.toString());
        // print("personal reports" + response.body.toString());
        return personalResultModelFromJson(response.bodyString.toString());
      } else {
        Constants.showMessage("Error", response.body.message.toString());

        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

//*** GET PROFESSIONAL REPORTS  ***//
  Future<List<ProfessionalResultModel>?> professionalReports() async {
    try {
      var accessToken = authController.accessToken;

      Response response = await post(
          "${Constants.serverUrl}app/professional/allpatient/report/",
          jsonEncode({}),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          });
      print("professional reports" + response.body.toString());

      if (response.statusCode == 200) {
        // Constants.showMessage("Success", response.body.toString());
        print("professional reports" + response.body.toString());
        return professionalResultModelFromJson(response.bodyString.toString());
      } else {
        Constants.showMessage(
          "Error",
          response.body['message'].toString(),
        );

        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

//***  REFRESH TOKEN  ***//
  Future<APIResponse?> refreshToken() async {
    try {
      var refreshToken = authController.refreshToken.value;

      Response response = await post(
        "${Constants.serverUrl}user/token/refresh/",
        jsonEncode({"refresh": refreshToken}),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print("Refresh Token" + response.body.toString());
        Map<String, dynamic> jsonMap = json.decode(json.encode(response.body));

        APIResponse apiResponse = APIResponse.fromJson(jsonMap);
        if (apiResponse.successResponse != null) {
          return apiResponse;
        }

        return null;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

//*** UPDATE PERSONAL PROFILE  ***//
  Future updateExistingPersonalProfile(
      name, age, state, gender, contact, profilepicFile) async {
    try {
      var accessToken = authController.accessToken;
      var lat = authController.lat.value;
      var long = authController.long.value;
      print("LAT" + lat + long);
      print(accessToken);
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${Constants.serverUrl}user/update/personal/Profile/"),
      );
      request.headers['Authorization'] = 'Bearer $accessToken';
      print(name);

      if (name != "") {
        request.fields['full_name'] = name;
      }
      if (contact != "") {
        request.fields['contact_number'] = "+91$contact";
      }
      if (age != "") {
        request.fields['age'] = age;
      }
      if (state != "") {
        request.fields['state'] = state;
        if (lat != "" && long != "") {
          request.fields['latitude'] = lat;
          request.fields['longitude'] = long;
        }
      }
      if (gender != "") {
        request.fields['gender'] = gender[0];
      }

      // request.fields['profile_pic'] = profilepicFile;

      if (profilepicFile != null) {
        var stream = http.ByteStream(profilepicFile.openRead());
        var length = await profilepicFile.length();
        var multipartFile = http.MultipartFile('profile_pic', stream, length,
            filename: profilepicFile.path.split('/').last);
        request.files.add(multipartFile);
      }

      var response = await request.send();
      var responseString = await response.stream
          .bytesToString(); //Read response content as a string

      if (response.statusCode == 200) {
        return responseString;
      } else {
        Constants.showMessage("Error", response.reasonPhrase.toString());
        return null;
      }
    } catch (e) {
      Constants.showMessage("Error", e.toString());
    }
  }

//*** UPDATE PROFESSIONAL PROFILE  ***//
  Future updateExistingProfessionalProfile(
      orgname, name, profileType, state, profilepicFile) async {
    try {
      var accessToken = authController.accessToken;

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${Constants.serverUrl}user/update/professional/Profile/"),
      );

      request.headers['Authorization'] = 'Bearer $accessToken';

      if (orgname != "") {
        request.fields['organization_name'] = orgname;
      }
      if (name != "") {
        request.fields['full_name'] = name;
      }
      if (profileType != "") {
        request.fields['profile_type'] = profileType.toString()[0];
      }
      if (state != "") {
        request.fields['state'] = state;
      }

      if (profilepicFile != null) {
        var stream = http.ByteStream(profilepicFile.openRead());
        var length = await profilepicFile.length();
        var multipartFile = http.MultipartFile('profile_pic', stream, length,
            filename: profilepicFile.path.split('/').last);
        request.files.add(multipartFile);
      }

      var response = await request.send();

      //Read response content as a string;
      var responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return responseString;
      } else {
        Constants.showMessage("Error", response.reasonPhrase.toString());
        return null;
      }
    } catch (e) {
      Constants.showMessage("Error", e.toString());
    }
  }

//*** RAISE SUPPORT TICKET  ***//
  Future raiseSupportTicket(ticket) async {
    try {
      var accessToken = authController.accessToken;

      Response response = await post(
        "${Constants.serverUrl}/app/userSupport/",
        jsonEncode({"message": ticket}),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );
      Map<String, dynamic> jsonMap = json.decode(json.encode(response.body));
      if (response.statusCode == 200) {
        // print(jsonMap['message']);
        return jsonMap['message'];
      } else {
        Constants.showMessage("Error", jsonMap['message']);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
