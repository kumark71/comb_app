import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';
import 'package:hemoqr/controllers/local_controller.dart';
import 'package:hemoqr/controllers/network_controller.dart';
import 'package:hemoqr/controllers/secure_storage.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SecureStorage>(SecureStorage(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<NetworkController>(NetworkController(), permanent: true);
    Get.put<LocaleController>(LocaleController(), permanent: true);
  }
}
