import 'package:get/get.dart';

import '../controllers/professional_account_controller.dart';

class ProfessionalAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfessionalAccountController>(
        () => ProfessionalAccountController(),
        fenix: true);
  }
}
