import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';
import 'package:video_player/video_player.dart';

class AddBloodController extends GetxController {
  VideoPlayerController videoPlayerController = VideoPlayerController.asset('assets/videos/addblood.mp4');
  var isVideoPlayInitialized = false.obs;
  @override
  void onInit() {
    super.onInit();
    videoPlayerController.initialize().then((_) {
      isVideoPlayInitialized.value = true;

      videoPlayerController.play();

      videoPlayerController.setVolume(0);
    });
    Future.delayed(
      Duration(seconds: 8),
      () {
        AuthController authController = Get.find();
        if (authController.isProfessional) {
          Get.offAndToNamed("/ReactionTimer", arguments: [Get.arguments[0]]);
        } else {
          Get.offAndToNamed("/ReactionTimer");
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.pause();
    videoPlayerController.dispose();
    Get.delete<AddBloodController>();
  }

  @override
  void onClose() {
    // TODO: implement onClose

    videoPlayerController.dispose();
    super.onClose();
  }
}
