import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';
import 'package:hemoqr/controllers/personal_account_controller.dart';

class PersonalAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalAccountController>(() => PersonalAccountController(), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
  }
}
