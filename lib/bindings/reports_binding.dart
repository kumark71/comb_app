import 'package:get/get.dart';
import 'package:hemoqr/controllers/qr_scanner_controller.dart';
import 'package:hemoqr/controllers/reports_controller.dart';

class ReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportsController>(() => ReportsController(), fenix: true);
    Get.lazyPut<QRScannerController>(() => QRScannerController(), fenix: true);
  }
}
