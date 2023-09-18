import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hemoqr/controllers/addblood_controller.dart';
import 'package:hemoqr/ui/utils/color_constants.dart';
import 'package:hemoqr/ui/utils/constants.dart';

import 'package:video_player/video_player.dart';

class AddBlood extends GetView<AddBloodController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var fontSize = MediaQuery.of(context).textScaleFactor;
    AddBloodController addBloodController = Get.find();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top,
          bottom: MediaQuery.of(context).viewPadding.bottom,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Spacer(),
            Text(
              "add_blood_video_next".tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            // Spacer(),
            Container(
              color: Theme.of(context).colorScheme.secondary,
              padding: const EdgeInsets.all(10),
              child: VideoPlayerB(
                size: size,
                controller: controller,
              ),
            ),
            // Spacer(),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerB extends StatelessWidget {
  const VideoPlayerB({
    super.key,
    required this.size,
    required this.controller,
  });

  final Size size;
  final AddBloodController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => WillPopScope(
          onWillPop: () async {
            // Return false to disable the back button functionality
            return false;
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: SizedBox(
                    height: size.height * 0.7,
                    width: size.width,
                    child: controller.isVideoPlayInitialized.value == true
                        ? AspectRatio(
                            aspectRatio: controller.videoPlayerController.value.aspectRatio,
                            child: VideoPlayer(controller.videoPlayerController),
                          )
                        : SizedBox(child: Constants.CustomLoader())),
              ),
            ],
          ),
        ));
  }
}
