import 'package:get/get.dart';
import 'package:hemoqr/controllers/patient_controller.dart';

class PatientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientController>(() => PatientController(), fenix: true);
  }
}
