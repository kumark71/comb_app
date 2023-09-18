import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hemoqr/controllers/timer.dart';
import 'package:hemoqr/ui/utils/color_constants.dart';
import 'package:hemoqr/ui/utils/constants.dart';
import 'package:hemoqr/ui/widgets/button.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:video_player/video_player.dart';

class ReactionTimer extends GetView<timerController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var fontSize = MediaQuery.of(context).textScaleFactor;
    // final ValueNotifier<double> _valueNotifier = ValueNotifier();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top + 10,
          bottom: MediaQuery.of(context).viewPadding.bottom + 15,
          left: 20,
          right: 20,
        ),
        child: Obx(
          () => Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.onTimeUp();
                    },
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "skip".tr,
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height * .01,
              ),
              Text(
                "scan_strip_timer_end".tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              Spacer(),
              SizedBox(
                // height: size.height * .18,
                // width: controller.showVideo.value == true ? size.width * .3 : size.width * .7,
                child: IgnorePointer(
                  child: SleekCircularSlider(
                    initialValue: controller.progressValue.value,
                    min: 0,
                    max: controller.defaultValue.value.toDouble(),
                    appearance: CircularSliderAppearance(
                      customWidths: CustomSliderWidths(
                        trackWidth: controller.isVideoPlayInitialized.value == true ? 7 : 15,
                        progressBarWidth: controller.isVideoPlayInitialized.value == true ? 7 : 15,
                      ),
                      customColors: CustomSliderColors(
                        trackColor: Theme.of(context).colorScheme.secondary,
                        progressBarColor: Theme.of(context).colorScheme.primary,
                        hideShadow: true,
                        dotColor: Theme.of(context).colorScheme.onSecondary,
                      ),
                      angleRange: 360,
                      startAngle: 270,
                      size: controller.isVideoPlayInitialized.value == true ? size.width * .2 : size.width * .7,
                      animationEnabled: true,
                    ),
                    onChange: (newValue) {
                      controller.progressValue.value = newValue;
                    },
                    innerWidget: (double newValue) {
                      return Center(
                        // child: Text(
                        //   "${(progressValue.value ~/ 60).toInt().toString().padLeft(1, '0')}:${(progressValue.value % 60).toInt().toString().padLeft(2, '0')}",
                        //   style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        //         color: Colors.white,
                        //         // fontWeight: FontWeight.bold,
                        //       ),
                        // ),
                        child: SizedBox(
                          child: Text(
                            "${(controller.progressValue.value ~/ 60).toInt().toString().padLeft(1, '0')}:${(controller.progressValue.value % 60).toInt().toString().padLeft(2, '0')}",
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              controller.showVideo.value == true
                  ? controller.isVideoPlayInitialized.value == true
                      ? Container(
                          color: Theme.of(context).colorScheme.secondary,
                          padding: const EdgeInsets.all(10),
                          margin: EdgeInsets.only(top: 15),
                          child: VideoPlayerC(size: size, controller: controller),
                        )
                      : SizedBox(
                          child: Constants.CustomLoader(),
                        )
                  : SizedBox(),
              Spacer(),
              CustomButton(
                buttonText: "cancel".tr,
                onPressed: () {
                  controller.stopTimer(resets: false);
                  Get.close(1);
                },
                width: size.width,
                height: size.height * .06,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoPlayerC extends StatelessWidget {
  const VideoPlayerC({
    super.key,
    required this.size,
    required this.controller,
  });

  final Size size;
  final controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          // Return false to disable the back button functionality
          return false;
        },
        child: controller.isVideoPlayInitialized.value == true
            ? SizedBox(
                height: size.height * 0.6,
                width: size.width * .7,
                child: AspectRatio(
                  aspectRatio: controller.videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(controller.videoPlayerController),
                ))
            : SizedBox(child: Constants.CustomLoader()),
      ),
    );
  }
}
