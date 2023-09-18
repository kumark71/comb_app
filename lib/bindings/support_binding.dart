import 'package:get/get.dart';
import 'package:hemoqr/controllers/support_controller.dart';

class SupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupportContoller>(() => SupportContoller(), fenix: true);
  }
}
