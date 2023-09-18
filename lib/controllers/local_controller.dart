import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hemoqr/controllers/secure_storage.dart';

class LocaleController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    var getLocal = await secureStorage.getLocal();
    var local = Locale(getLocal.toString());
    print("local" + local.toString());
    if (getLocal != null) {
      Get.updateLocale(local);
    } else {
      var local = Locale("en", "US");
      Get.updateLocale(local);
    }
  }

  var selectedlocale = "".obs;
  SecureStorage secureStorage = Get.find();
  var avalableLocales = [
    PopupMenuItem(
      child: Text(
        "English",
        style: Get.textTheme.titleSmall?.copyWith(color: Colors.white),
      ),
      value: "en",
    ),
    PopupMenuItem(
      child: Text(
        "हिंदी",
        style: Get.textTheme.titleSmall?.copyWith(color: Colors.white),
      ),
      value: "hi",
    )
  ];

  changeLocale(value) {
    if (value != "" && value != null) {
      selectedlocale.value = value;
      var locale = Locale(selectedlocale.value);
      secureStorage.setLocale(selectedlocale.value);
      Get.updateLocale(locale);
    }
  }
}
