import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';
import 'package:hemoqr/providers/api_providers.dart';

class ProfessionalAccountController extends GetxController {
  RxString fullName = "".obs;

  RxString state = "".obs;
  RxString selectedProfile = "Profile".obs;

  RxString fullNameError = "".obs;

  RxString stateError = "".obs;
  RxString profileError = "".obs;
  List organizations = [].obs;
  var selectedOrganization = "".obs;

  void updateSelectedItem(String newValue) {
    if (newValue != "Profile") {
      profileError.value = "";
    } else {
      profileError.value = "Please Select Profile";
    }
    selectedProfile.value = newValue;
  }

  @override
  void onInit() async {
    super.onInit();

    AuthController authController = Get.find();
    authController.getCurrentPosition();
    fullName.listen((value) {
      validateFullName(value);
    });

    state.listen((value) {
      validateState(value);
    });
    await fetchOrganizations();
  }

  Future<void> fetchOrganizations() async {
    try {
      await ApiServices().getOrganisations().then((value) {
        organizations = json.decode(value);
        selectedOrganization.value = organizations.first['id'].toString();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void validateFullName(String value) {
    fullNameError.value = "";
    if (value.isEmpty) {
      fullNameError.value = "Full name is required";
    } else {
      fullNameError.value = "";
    }
  }

  void validateState(String value) {
    stateError.value = "";
    if (value.isEmpty) {
      stateError.value = "State is required";
    } else {
      stateError.value = "";
    }
  }

  bool isSelectionValid() {
    return selectedProfile.value.isNotEmpty;
  }

  void submit() {
    print("object");
    if (selectedProfile.value == "Profile") {
      profileError.value = "Please Select Profile";
    } else {
      profileError.value = "";
    }

    if (fullName.value.isEmpty) {
      fullNameError.value = "Full Name is required";
    } else {
      fullNameError.value = "";
    }

    if (state.value.isEmpty) {
      stateError.value = "State is required";
    } else {
      stateError.value = "";
    }

    if (profileError.value.isEmpty &&
        fullNameError.value.isEmpty &&
        stateError.value.isEmpty) {
      ApiServices()
          .updateProfessionalProfile(fullName.value, selectedProfile.value,
              state.value, selectedOrganization.value)
          .then((value) async {
        if (value != null) {
          AuthController authController = Get.find();
          authController.saveUser().then((value) {
            if (authController.ProfessionalUserStatus == "0") {
              Get.offAllNamed("/accountStatus");
            } else if (authController.ProfessionalUserStatus.value == "1") {
              Get.offAllNamed("/home");
            } else if (authController.ProfessionalUserStatus.value == "2") {
              Get.offAllNamed("/accountStatus");
            } else if (authController.ProfessionalUserStatus.value == "3") {
              Get.offAllNamed("/accountStatus");
            }
          });
        } else {
          // Constants.showMessage("Error", value.reasonPhrase.toString());
        }
      });
    }
  }
}
