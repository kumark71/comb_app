import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';

class PurposeController extends GetxController {
  RxString selectedCard = "".obs;
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  submit() {
    AuthController authController = Get.find();
    if (selectedCard.value == "Professional") {
      authController.isProfessional = true;
      authController.account_type.value = "mr";
      Get.toNamed("/professionalAccount");
    } else if (selectedCard.value == "Personal") {
      authController.isProfessional = false;
      authController.account_type.value = "p";
      Get.toNamed("/personalAccount");
    }
  }
}
