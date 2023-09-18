// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';
import 'package:hemoqr/controllers/qr_scanner_controller.dart';
import 'package:hemoqr/ui/widgets/custom_popup.dart';
import 'package:hemoqr/ui/widgets/button.dart';

class QRScanner_old extends GetView<QRScannerController> {
  QRScanner_old({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthController authController = Get.find();
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
            context: context,
            builder: (_) => Dialog(
                  onSubmit: () {
                    // Get.close(1);
                    Get.offNamedUntil("/home", (route) => false);
                  },
                  text: "Logout",
                  buttonText: "log_out",
                ));
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Obx(() {
                if (!controller.isInitialized.value) {
                  return SizedBox(
                      height: size.height * 0.8,
                      child: const Center(child: CircularProgressIndicator()));
                } else if (controller.videoCaptured.value) {
                  return authController.isProfessional == true
                      ? VideoPreview(
                          size: size,
                          controller: controller,
                          patientId: Get.arguments[0],
                        )
                      : VideoPreview(
                          size: size,
                          controller: controller,
                          patientId: authController.uid,
                        );
                } else {
                  return FocusCircle(
                    size: size,
                    controller: controller,
                  );
                }
              }),
              Obx(() {
                if (controller.videoCaptured.value) {
                  return Container();
                } else if (controller.showLoader.value) {
                  return SizedBox(
                    height: size.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return CaptureVideo(controller: controller);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class FocusCircle extends StatelessWidget {
  final Size size;
  const FocusCircle({
    Key? key,
    required this.size,
    required this.controller,
  }) : super(key: key);

  final QRScannerController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Obx(
      () => SizedBox(
        child: Stack(children: [
          SizedBox(
            width: size.width,
            child: CameraPreview(
              controller.cameraController,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return GestureDetector(onTapUp: controller.onTapUp);
                },
              ),
            ),
          ),
          if (controller.showFocusCircle.value)
            Positioned(
                top: controller.y.value - 50,
                left: controller.x.value - 20,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5)),
                )),
          Positioned(
            left: 0,
            child: Container(
                height: size.height,
                width: size.width * 0.25,
                color: Colors.black38,
                child: controller.rightArrow.value == true
                    ? Center(
                        child: Icon(
                          FontAwesomeIcons.circleArrowRight,
                          color: Colors.white,
                          size: 35,
                        ),
                      )
                    : Container()),
          ),
          CustomPaint(
            painter: OpenPainter(),
          ),
          Positioned(
            right: 0,
            child: Container(
              height: size.height,
              width: size.width * 0.25,
              color: Colors.black38,
              child: controller.leftArrow.value == true
                  ? Center(
                      child: Icon(
                        FontAwesomeIcons.circleArrowLeft,
                        color: Colors.white,
                        size: 35,
                      ),
                    )
                  : Container(),
            ),
          ),
          Positioned(
            bottom: size.height * 0,
            left: size.width * 0.25,
            child: Container(
              height: size.height * 0.06,
              width: size.width * 0.5,
              color: Colors.black38,
            ),
          ),
          Positioned(
            top: 0,
            left: size.width * 0.25,
            child: Container(
              height: size.height * 0.06,
              width: size.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.black38,
              ),
              child: controller.upwordArrow.value == true
                  ? Center(
                      child: Icon(
                        FontAwesomeIcons.circleArrowDown,
                        color: Colors.white,
                        size: 35,
                      ),
                    )
                  : Container(),
            ),
          ),
          // Positioned(
          //     bottom: 10,
          //     child: SizedBox(
          //       width: size.width,
          //       child: Center(
          //         child: Text(
          //           "${'keep_mobile_still_during_countdown'.tr} ${controller.secondsRemaining.value} sec ",
          //           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          //         ),
          //       ),
          //     )),
/*** Alert Gradients ***/
          Positioned(
            top: 0,
            child: Container(
              height: size.height * 0.05,
              width: size.width,
              decoration: BoxDecoration(
                  gradient: controller.upwordArrow.value == false
                      ? LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                              Colors.green.withOpacity(.6),
                              Colors.transparent
                            ])
                      : LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                              Colors.red.withOpacity(.6),
                              Colors.transparent
                            ])),
            ),
          ),
          Positioned(
            left: 0,
            child: Container(
              height: size.height,
              width: size.width * 0.1,
              decoration: BoxDecoration(
                  gradient: controller.leftArrow.value == false
                      ? LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                              Colors.green.withOpacity(.6),
                              Colors.transparent
                            ])
                      : LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                              Colors.red.withOpacity(.6),
                              Colors.transparent
                            ])),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              height: size.height,
              width: size.width * 0.1,
              decoration: BoxDecoration(
                  gradient: controller.rightArrow.value == false
                      ? LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                              Colors.green.withOpacity(.6),
                              Colors.transparent
                            ])
                      : LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                              Colors.red.withOpacity(.6),
                              Colors.transparent
                            ])),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: size.height * 0.05,
              width: size.width,
              decoration: BoxDecoration(
                  gradient: controller.bottomArrow.value == false
                      ? LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                              Colors.green.withOpacity(.6),
                              Colors.transparent
                            ])
                      : LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                              Colors.red.withOpacity(.6),
                              Colors.transparent
                            ])),
            ),
          ),
          (controller.upwordArrow.value == true ||
                  controller.bottomArrow.value == true ||
                  controller.leftArrow.value == true ||
                  controller.rightArrow.value == true)
              ? Positioned(
                  child: Center(
                      child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Rotate your phone until all sides are green",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                )))
              : SizedBox(),
        ]),
      ),
    ));
  }
}

class VideoPreview extends StatelessWidget {
  const VideoPreview({
    super.key,
    required this.size,
    required this.controller,
    this.patientId,
  });

  final patientId;
  final Size size;
  final QRScannerController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: SizedBox(
              height: size.height * 0.82,
              width: size.width,
              child:
                  //  controller.isVideoPlayInitialized.value == true
                  // ?
                  Image.file(
                File(controller.previewPhoto!.path.toString()),
              )
              // : const Center(child: CircularProgressIndicator(),),
              ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: size.width * 0.4,
                height: size.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomPopup(
                          message: "confirm_retake_video".tr,
                          onYesPressed: () {
                            Navigator.pop(context);
                            // controller.resetVideoCapture();
                            controller.ErrorPopUp("Pay Attention",
                                "Please note that image capture will stop when the border turns red. Keep your phone level for uninterrupted capture.");
                          },
                          onNoPressed: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                  ),
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  label: Text(
                    "retake".tr,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
              CustomButton(
                height: size.height * .06,
                buttonText: 'submit'.tr,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomPopup(
                          message: "confirm_upload_video".tr,
                          onYesPressed: () {
                            controller.uploadImages(patientId, context); // temp
                          },
                          onNoPressed: () {
                            Get.back();
                          });
                    },
                  );
                },
                width: size.width * 0.4,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CaptureVideo extends StatelessWidget {
  const CaptureVideo({
    super.key,
    required this.controller,
  });

  final QRScannerController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Column(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'click_to_focus_strip'.tr,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surface,
                ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Container(
                padding: const EdgeInsets.all(5.0),
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: controller.showButtonLoader.value == false
                    ? IconButton(
                        style: IconButton.styleFrom(
                          side:
                              const BorderSide(width: 5.0, color: Colors.white),
                        ),
                        onPressed: () async {
                          controller.takePhoto();
                        },
                        icon: const Icon(
                          FontAwesomeIcons.camera,
                          color: Colors.black,
                        ),
                      )
                    : const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ))))
          ],
        ),
      ]),
    );
  }
}

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;

    var paint1 = Paint()
      ..color = Color(0xffaeafb2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawRect(
        Offset(width * 0.1, height * 0.2) & Size(width * 0.5, height * 0.7),
        paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Dialog extends StatefulWidget {
  final String text;
  final String buttonText;
  final VoidCallback onSubmit;

  const Dialog({
    Key? key,
    required this.text,
    required this.buttonText,
    required this.onSubmit,
  }) : super(key: key);

  @override
  DialogState createState() => DialogState();
}

class DialogState extends State<Dialog> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              Size size = constraints.biggest;
              return Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(15.0),
                height: size.height * 0.18,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.secondary,
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.3),
                        width: 3,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        style: BorderStyle.solid)),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Text('Are you sure you want to stop the test?',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.surface,
                              )),
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: size.width * 0.3,
                          height: size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: Text("No",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                    )),
                          ),
                        ),
                        Container(
                          width: size.width * 0.3,
                          height: size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: ElevatedButton(
                            onPressed: widget.onSubmit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: Text(
                              "Yes",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                            ),
                          ),
                        )
                      ],
                    )),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
