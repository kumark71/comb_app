import 'package:get/get.dart';
import 'package:hemoqr/controllers/faq_controller.dart';

class FaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaqController>(() => FaqController(), fenix: true);
  }
}
