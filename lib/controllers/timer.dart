import 'dart:async';

import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';
import 'package:video_player/video_player.dart';

class timerController extends GetxController {
  var defaultValue = 160.obs;
  var progressValue = 160.0.obs;
  var isStarted = false.obs;
  var focusedMins = 0.obs;
  var showVideo = false.obs;
  late Timer timer;
  VideoPlayerController videoPlayerController = VideoPlayerController.asset('assets/videos/timer.mp4');
  var isVideoPlayInitialized = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(
      Duration(seconds: 1),
      () {
        startTimer();
      },
    );
    Future.delayed(
      Duration(seconds: 4),
      () {
        startVideo();
      },
    );
  }
  // video

  void startVideo() {
    showVideo.value = true;
    videoPlayerController.initialize().then((_) {
      isVideoPlayInitialized.value = true;
      videoPlayerController.setLooping(true);
      videoPlayerController.play();
      videoPlayerController.setVolume(0);
    });
  }

  // Timer

  void startTimer() {
    focusedMins.value = progressValue.value.toInt();
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (progressValue <= 1) {
          timer.cancel();
          progressValue.value = defaultValue.value.toDouble();
          isStarted.value = false;
          onTimeUp();
        } else {
          progressValue.value--;
        }
      },
    );
  }

  void onTimeUp() {
    AuthController authController = Get.find();
    stopTimer();
    if (authController.isProfessional == true) {
      Get.offAndToNamed("/qrscanner", arguments: [0]);
    } else {
      Get.offAndToNamed("/qrscanner");
    }
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    timer.cancel();
  }

  void reset() {
    timer.cancel();
    progressValue.value = defaultValue.value.toDouble();
    isStarted.value = false;
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    videoPlayerController.pause();
    videoPlayerController.dispose();
    Get.delete<timerController>();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    videoPlayerController.dispose();
  }
}
