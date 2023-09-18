import 'package:get/get.dart';

import 'package:hemoqr/controllers/purpose_controller.dart';

class PurposeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurposeController>(() => PurposeController(), fenix: true);
  }
}
