import 'package:get/get.dart';

import 'package:hemoqr/controllers/purpose_controller.dart';
import 'package:hemoqr/controllers/timer.dart';

class TimerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<timerController>(() => timerController(), fenix: true);
  }
}
