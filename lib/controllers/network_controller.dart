import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  var isConnected = true.obs;
  @override
  void onInit() async {
    super.onInit();
    print("network controller");
    checkConnectivity();
    _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  void checkConnectivity() {
    _connectivity
        .checkConnectivity()
        .then((ConnectivityResult connectivityResult) {
      updateConnectionStatus(connectivityResult);
    });
  }

  void updateConnectionStatus(ConnectivityResult connectivityResult) {
    print("network update");
    if (connectivityResult == ConnectivityResult.none) {
      isConnected.value = false;
      Get.rawSnackbar(
        messageText: const Text(
          'PLEASE CONNECT TO THE INTERNET',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        isDismissible: false,
        duration: const Duration(days: 1),
        backgroundColor: Colors.red[400]!,
        icon: const Icon(
          Icons.wifi_off,
          color: Colors.white,
          size: 35,
        ),
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED,
      );
    } else {
      isConnected.value = true;
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
