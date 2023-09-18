import 'package:get/get.dart';
import 'package:hemoqr/ui/pages/accounts/account_status.dart';

class AccountStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountStatusController>(() => AccountStatusController(),
        fenix: true);
  }
}
