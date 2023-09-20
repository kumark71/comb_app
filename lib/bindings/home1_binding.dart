import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';
import 'package:hemoqr/controllers/home_controller.dart';
import 'package:hemoqr/controllers/reports_controller.dart';

import '../controllers/home1_controller.dart';

class Home1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Home1Controller>(() => Home1Controller(), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<ReportsController>(() => ReportsController(), fenix: true);
  }
}
