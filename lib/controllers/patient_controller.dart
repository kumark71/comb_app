import 'package:get/get.dart';
import 'package:hemoqr/providers/api_providers.dart';

class PatientController extends GetxController {
  RxBool isMaleSelected = false.obs;
  RxBool isFemaleSelected = false.obs;

  RxString fullName = "".obs;
  RxInt age = 0.obs;
  RxString mobileNumber = "".obs;
  RxString otp = "".obs;
  RxBool isNumber = false.obs;
  RxBool isOtpSent = false.obs;

  RxString gender = "F".obs;
  RxString genderError = "".obs;
  RxString fullNameError = "".obs;
  RxString ageError = "".obs;
  RxString mobileNumberError = "".obs;

  var buttonLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fullName.listen((value) {
      fullNameValidation(value);
    });
    age.listen((value) {
      ageValidation(value);
    });

    mobileNumber.listen((value) {
      mobileNumberValidation(value);
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

  void otpChanged(value) {
    otp.value = value;
  }

  void ageValidation(int val) {
    ageError.value = "";
    if (val <= 0) {
      ageError.value = "Age must be greater than zero";
    } else {
      ageError.value = "";
    }
  }

  void mobileNumberValidation(String val) {
    mobileNumberError.value = "";
    if (!RegExp(r'^[0-9]{10}$').hasMatch(val)) {
      mobileNumberError.value = "Invalid mobile number";
    } else {
      mobileNumberError.value = "";
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

    if (!hasError) {
      if (fullName.value != "") {
        Map<String, dynamic> requestData = {
          "full_name": fullName.value,
          "age": age.value,
          "gender": gender.value,
          "state": "no",
        };
        if (mobileNumber.value.isNotEmpty) {
          requestData["contact_number"] = "+91${mobileNumber.value}";
        }
        ApiServices().createPatient(requestData).then((value) {
          print(value);
          if (value != null) {
            Get.close(1);
            Get.offAndToNamed("/qrscanner", arguments: [value]);
          } else {}
        });
      }
    }
  }

  // sendOtp() {
  //   if (mobileNumberError.value == "") {
  //     buttonLoading.value = true;
  //     ApiServices()
  //         .sendOtp({"phone_number": "+91${mobileNumber}"}).then((value) {
  //       if (value != null) {
  //         Constants.showMessage("Success!", value['message']);
  //         isOtpSent.value = true;
  //         buttonLoading.value = false;
  //       }
  //     });
  //   } else {
  //     Constants.showMessage("Opps!", "Please Enter Valid Mobile");
  //   }
  // }

  // void editNum() {
  //   isOtpSent.value = false;
  // }
}
