// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';
import 'package:hemoqr/controllers/qr_scanner_controller.dart';
import 'package:hemoqr/ui/utils/constants.dart';
import 'package:hemoqr/ui/widgets/button.dart';
import 'package:hemoqr/ui/widgets/custom_popup.dart';

class QRScanner extends StatelessWidget {
  const QRScanner({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: CameraAwesomeBuilder.custom(
            previewAlignment: Alignment.center,
            saveConfig: SaveConfig.photo(),
            builder: (cameraState, previewSize, previewRect) {
              return cameraState.when(
                onPreparingCamera: (state) =>
                    const Center(child: CircularProgressIndicator()),
                onPhotoMode: (state) =>
                    TakePhotoUI(cameraState: state, size: size),
              );
            },
          ),
        ),
      ),
    );
  }
}

class TakePhotoUI extends StatefulWidget {
  final PhotoCameraState cameraState;
  Size size;

  TakePhotoUI({
    Key? key,
    required this.cameraState,
    required this.size,
  }) : super(key: key);

  @override
  State<TakePhotoUI> createState() => _TakePhotoUIState();
}

class _TakePhotoUIState extends State<TakePhotoUI> {
  @override
  void initState() {
    super.initState();
    widget.cameraState.sensorConfig
        .setAspectRatio(CameraAspectRatios.ratio_16_9);
    widget.cameraState.sensorConfig.setZoom(0);

    widget.cameraState.focus();
  }

  AuthController authController = Get.find();
  QRScannerController controller = Get.find();

  Future<void> captureAndNavigateToImage() async {
    if (controller.upwordArrow.value == false &&
        controller.bottomArrow.value == false &&
        controller.leftArrow.value == false &&
        controller.rightArrow.value == false) {
      CaptureRequest capturedRequest = await widget.cameraState.takePhoto();
      String? imagePath = capturedRequest.when(
        single: (single) => single.file!.path,
      );
      if (imagePath != null) {
        print(imagePath);
        if (authController.isProfessional == true) {
          final arguments = Get.arguments;
          if (arguments != null && arguments.length > 0) {
            final patientId = arguments[0];
            Get.to(() => DisplayImage(
                  size: widget.size,
                  controller: controller,
                  patientId: patientId,
                  imagePath: imagePath,
                ));
          }
        } else {
          Get.to(() => DisplayImage(
                size: widget.size,
                controller: controller,
                patientId: authController.uid,
                imagePath: imagePath,
              ));
        }
      }
    } else {
      Constants.showMessage(
          "Opps!", "Hold your phone steady over the strip, please.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            Expanded(
              child: SizedBox(
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      child: Container(
                          height: widget.size.height,
                          width: widget.size.width * 0.1,
                          color: Colors.black,
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
                    Positioned(
                      right: 0,
                      child: Container(
                        height: widget.size.height,
                        width: widget.size.width * 0.1,
                        color: Colors.black,
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
                      bottom: widget.size.height * 0,
                      child: Container(
                        height: widget.size.height * 0.2,
                        width: widget.size.width,
                        color: Colors.black,
                        child: controller.bottomArrow.value == true
                            ? Center(
                                child: Icon(
                                  FontAwesomeIcons.circleArrowUp,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              )
                            : Container(),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                        height: widget.size.height * 0.2,
                        width: widget.size.width,
                        decoration: BoxDecoration(
                          color: Colors.black,
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
                    Positioned(
                      top: 0,
                      child: Container(
                        height: widget.size.height * 0.05,
                        width: widget.size.width,
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
                        height: widget.size.height,
                        width: widget.size.width * 0.1,
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
                        height: widget.size.height,
                        width: widget.size.width * 0.1,
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
                        height: widget.size.height * 0.05,
                        width: widget.size.width,
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
                    Positioned(
                        child: (controller.upwordArrow.value == true ||
                                controller.bottomArrow.value == true ||
                                controller.leftArrow.value == true ||
                                controller.rightArrow.value == true)
                            ? Center(
                                child: Container(
                                color: Colors.white,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Rotate your phone until all sides are green",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    )),
                              ))
                            : Container())
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.black,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        style: IconButton.styleFrom(
                          side:
                              const BorderSide(width: 5.0, color: Colors.white),
                        ),
                        onPressed: () async {
                          // Call the captureAndNavigateToImage function
                          captureAndNavigateToImage();
                        },
                        icon: const Icon(
                          Icons.camera,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            )
          ],
        ));
  }
}

class DisplayImage extends StatefulWidget {
  final String imagePath;
  final patientId;
  final Size size;
  final QRScannerController controller;

  const DisplayImage({
    required this.imagePath,
    Key? key,
    required this.size,
    required this.controller,
    this.patientId,
  }) : super(key: key);

  @override
  State<DisplayImage> createState() => _DisplayImageState();
}

class _DisplayImageState extends State<DisplayImage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Return false to disable the back button functionality
        return false;
      },
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Image.file(
                File(widget.imagePath),
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: widget.size.width * 0.4,
                    height: widget.size.height * 0.06,
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
                                widget.controller.ErrorPopUp("pay_attention".tr,
                                    "maintain_phone_level".tr);
                              },
                              onNoPressed: () {},
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
                    height: widget.size.height * .06,
                    buttonText: 'submit'.tr,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomPopup(
                              message: "confirm_upload_video".tr,
                              onYesPressed: () {
                                widget.controller.fileName.value =
                                    widget.imagePath;
                                widget.controller.uploadImages(
                                    widget.patientId, context); // temp
                              },
                              onNoPressed: () {
                                Get.back();
                              });
                        },
                      );
                    },
                    width: widget.size.width * 0.4,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
