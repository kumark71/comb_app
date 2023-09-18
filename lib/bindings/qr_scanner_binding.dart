import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';

import '../controllers/qr_scanner_controller.dart';

class QRScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QRScannerController>(() => QRScannerController(), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
  }
}
