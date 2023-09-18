import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'color_constants.dart';

class Constants {
  static const serverUrl = "http://34.93.115.221/"; //TEst
  // static const serverUrl = "http://34.107.205.97/"; //Prod
  // static const serverUrl = 'http://192.168.1.14:9000/';

  static showMessage(title, message) {
    Get.snackbar(title, message,
        titleText: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        messageText: Text(
          message,
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        snackPosition: SnackPosition.TOP,
        colorText: ColorConstant.fontColor,
        showProgressIndicator: true,
        progressIndicatorBackgroundColor: Color(0xFF7936D0),
        progressIndicatorValueColor:
            AlwaysStoppedAnimation(Color.fromARGB(255, 197, 162, 242)),
        snackStyle: SnackStyle.FLOATING,
        borderRadius: 10,
        backgroundColor: const Color.fromARGB(184, 255, 255, 255),
        duration: const Duration(seconds: 2));
    print("after message");
  }

  static CustomLoader() {
    return Center(
      child: SpinKitWaveSpinner(
        waveColor: Color(0xff41019d),
        trackColor: Colors.yellow.shade200,
        color: Color(0xffbda6d3),
        size: 70.0,
      ),
    );
  }
}
