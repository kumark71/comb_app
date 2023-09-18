import 'dart:developer';

import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';
import 'package:hemoqr/providers/api_providers.dart';
import 'package:hemoqr/ui/utils/constants.dart';

class LoginController extends GetxController {
  AuthController authContoller = Get.find();
  RxString mobile = "".obs;
  RxString mobileError = "".obs;
  RxString otp = "".obs;
  RxString otpError = "".obs;
  RxInt isSentOtp = 0.obs;
  RxBool isnewUser = true.obs;
  RxBool isLoading = false.obs;
  var buttonLoading = false.obs;

  @override
  void onInit() {
    buttonLoading.value = false;
    log(authContoller.isLogin.toString());

    super.onInit();
    mobile.listen((value) {
      mobileValidation(value);
    });
    otp.listen((value) {
      otpValidation(value);
    });
  }

  mobileChanged(String val) {
    mobile.value = val;
  }

  otpChanged(String val) {
    otp.value = val;
  }

  mobileValidation(String val) {
    mobileError.value = "";
    if (val.isEmpty) {
      mobileError.value = "Mobile number is required";
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(val)) {
      mobileError.value = "Invalid mobile number";
    }
    else {
      mobileError.value = "";
    }
  }

  otpValidation(String val) {
    if (val.isEmpty) {
      otpError.value = 'OTP is required';
    } else if (val.length != 4) {
      otpError.value = 'Invalid OTP';
    } else {
      otpError.value = '';
    }
  }

  void editNum() {
    isSentOtp.value = 0;
    // mobile.value = "";
  }

  Future<void> sendOtp() async {
    if (mobileError.value == "" && mobile.value != "") {
      buttonLoading.value = true;
      await ApiServices()
          .sendOtp({"phone_number": "+91${mobile}"}).then((value) {
        if (value != null) {
          Constants.showMessage("Success!", value['message']);
          buttonLoading.value = false;
          isSentOtp.value = 1;
        }
      });
      buttonLoading.value = false;
    } else {
      Constants.showMessage("Opps!", "Please Enter a Valid Mobile Number");
    }
  }

  verifyOTP() {
    if (otpError.value == "" && otp.value != "") {
      if (authContoller.isProfessional == true) {
        loginProfessional();
      } else {
        print("Personal");
        loginPersonal();
      }
    } else {
      Constants.showMessage("Opps!", "Please enter a 4-digit OTP");
    }
  }

  loginPersonal() async {
    print("Personal Login");
    buttonLoading.value = true;
    try {
      await ApiServices().loginPersonal({
        "phone_number": "+91${mobile.value.toString()}",
        "otp": otp.value.toString()
      }).then((value) {
        if (value != null) {
          authContoller.phoneNumber.value = mobile.value.toString();
          authContoller.login(value)?.then((value) => {});
        } else {
          buttonLoading.value = false;
        }
      });
    } catch (e) {
      buttonLoading.value = false;
      log("error while login => ${e.toString()}");
    }
  }

  loginProfessional() async {
    print("Professional Login");
    buttonLoading.value = true;
    try {
      await ApiServices().loginProfessional({
        "phone_number": "+91${mobile.value.toString()}",
        "otp": otp.value.toString()
      }).then((value) {
        if (value != null) {
          authContoller.phoneNumber.value = mobile.value.toString();
          authContoller.login(value)?.then((value) => {});
        } else {
          buttonLoading.value = false;
        }
      });
    } catch (e) {
      buttonLoading.value = false;
      log("error while login => ${e.toString()}");
    }
  }
}
