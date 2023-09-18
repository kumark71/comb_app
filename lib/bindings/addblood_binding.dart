import 'package:get/get.dart';
import 'package:hemoqr/controllers/addblood_controller.dart';

import 'package:hemoqr/controllers/purpose_controller.dart';
import 'package:hemoqr/controllers/timer.dart';

class AddBloodBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddBloodController>(() => AddBloodController(), fenix: true);
  }
}
