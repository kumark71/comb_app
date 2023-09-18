import 'package:get/get.dart';
import 'package:hemoqr/providers/api_providers.dart';
import 'package:hemoqr/ui/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportContoller extends GetxController {
  var loading = false.obs;
  var message = "".obs;
  @override
  void onInit() {
    super.onInit();
    message.listen((val) {
      messageChanged(val);
    });
  }

  messageChanged(String val) {
    message.value = val;
  }

  void makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: "9284345170",
    );
    await launchUrl(launchUri);
  }

  // String? encodeQueryParameters(Map<String, String> params) {
  //   return params.entries
  //       .map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
  //       .join('&');
  // }

  void sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'info@smartqr.co.in',
      // query: encodeQueryParameters(<String, String>{
      //   'subject': '',
      // }),
    );

    await launchUrl(emailLaunchUri);
  }

  uploadTicket() {
    if (message.value != "") {
      loading.value = true;
      ApiServices().raiseSupportTicket(message.value).then(
        (value) {
          if (value != null) {
            print(value);
            loading.value = false;
            Get.back();
            Constants.showMessage("Success", value);
          }
          print("error" + value.toString());
        },
      );
      //Upload in API
    } else {
      Constants.showMessage("Opps!", "Please Enter The Message");
    }
  }
}
