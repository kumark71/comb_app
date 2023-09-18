import 'dart:developer';

import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';
import 'package:hemoqr/providers/api_providers.dart';
import 'package:hemoqr/ui/utils/constants.dart';

class PersonalAccountController extends GetxController {
  AuthController authController = Get.find();
  RxBool isMaleSelected = false.obs;
  RxBool isFemaleSelected = false.obs;
  RxString fullName = "".obs;
  RxInt age = 0.obs;
  RxString state = "".obs;
  RxString mobileNumber = "".obs;
  RxString gender = "F".obs;

  RxString genderError = "".obs;
  RxString fullNameError = "".obs;
  RxString ageError = "".obs;
  RxString stateError = "".obs;
  RxString mobileNumberError = "".obs;

  @override
  void onInit() {
    super.onInit();
    AuthController authController = Get.find();
    authController.getCurrentPosition();
    fullName.listen((value) {
      fullNameValidation(value);
    });
    age.listen((value) {
      ageValidation(value);
    });
    state.listen((value) {
      stateValidation(value);
    });
  }

  void fullNameValidation(String val) {
    fullNameError.value = "";

    if (val.trim().isEmpty) {
      fullNameError.value = "Full name is required";
    } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(val)) {
      fullNameError.value = "Invalid characters in full name";
    } else {
      fullNameError.value = "";
    }
  }

  void ageChanged(int val) {
    age.value = val;
  }

  void ageValidation(int val) {
    ageError.value = "";
    if (val <= 0) {
      ageError.value = "Age must be greater than zero";
    } else {
      ageError.value = "";
    }
  }

  void stateValidation(String val) {
    stateError.value = "";
    if (val.isEmpty) {
      stateError.value = "State is required";
    } else {
      stateError.value = "";
    }
  }

  void submit() {
    bool hasError = false;

    if (fullName.value.isEmpty) {
      fullNameError.value = "Full name is required";
      hasError = true;
    } else {
      fullNameError.value = "";
    }

    if (age.value == 0) {
      ageError.value = "Age is required";
      hasError = true;
    } else {
      ageError.value = "";
    }

    if (state.value.isEmpty) {
      stateError.value = "State is required";
      hasError = true;
    } else {
      stateError.value = "";
    }

    if (!hasError) {
      if (fullName.value != "" && age.value != 0 && state.value != "") {
        ApiServices()
            .updatePersonalProfile(fullName.value, age.value.toString(),
                state.value, gender.value, authController.phoneNumber, null)
            .then((value) {
          if (value != null) {
            authController
                .saveUser()
                .then((value) => {Get.offAllNamed("/home")});
          } else {
            // Constants.showMessage("Error", value.reasonPhrase.toString());
          }
        });
      }
    } else {
      Constants.showMessage("title", "message");
    }
  }
}
