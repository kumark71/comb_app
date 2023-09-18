import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';
import 'package:hemoqr/providers/api_providers.dart';
import 'package:hemoqr/ui/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:sensors_plus/sensors_plus.dart';

class QRScannerController extends GetxController {
  late CameraController cameraController;
  final isInitialized = false.obs;
  final videoCaptured = false.obs;
  // var countDown = 7.obs;
  final showLoader = false.obs;
  final showFocusCircle = false.obs;
  final showButtonLoader = false.obs;
  final x = 0.0.obs;
  final y = 0.0.obs;
  var patientUid = 0.obs;
  var patientFullName = "".obs;
  var patientAge = 0.obs;
  var patientGlucoValue = "".obs;

  //Accelerometer Variables
  var _x = 0.0.obs;
  var _y = 0.0.obs;
  var _z = 0.0.obs;
  var rightArrow = false.obs;
  var leftArrow = false.obs;
  var upwordArrow = false.obs;
  var bottomArrow = false.obs;
  RxBool isVideoPlayInitialized = false.obs;
  var isRecordingStart = false.obs;
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  //recording vars
  XFile? photo;
  XFile? previewPhoto;
  var fileName = "".obs;

  @override
  void onInit() {
    super.onInit();
    // initializeCamera();
    isInitialized.value = true;
    _initAccelerometer();
  }

  @override
  void onClose() {
    super.onClose();
    // cameraController.dispose();
    _accelerometerSubscription.cancel();
  }

  void _initAccelerometer() {
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      _x.value = event.x;
      _y.value = event.y;
      _z.value = event.z;
      _checkForMove();
    });
  }

  void _checkForMove() {
    if (_x > 1.5) {
      rightArrow.value = true;
    } else {
      rightArrow.value = false;
    }

    if (_x < -1.5) {
      leftArrow.value = true;
    } else {
      leftArrow.value = false;
    }

    if (_y > 2.0) {
      upwordArrow.value = true;
    } else {
      upwordArrow.value = false;
    }

    if (_y < -1.0) {
      bottomArrow.value = true;
    } else {
      bottomArrow.value = false;
    }
  }

  void initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    cameraController = CameraController(
      camera,
      ResolutionPreset.veryHigh,
      enableAudio: false,
    );

    try {
      double maxZoomLevel;
      double setZoomLevel;
      await cameraController.initialize().then((value) => {
            cameraController.getMaxZoomLevel().then((value) {
              maxZoomLevel = value;
              setZoomLevel = maxZoomLevel * 0.4;

              if (setZoomLevel.toDouble() <= maxZoomLevel.toDouble()) {
                cameraController.setZoomLevel(setZoomLevel);
                cameraController.setFocusMode(FocusMode.auto);
              } else {
                log("Opps!");
              }
            })
          });
      //i changed from 1.0 to 1.1 for video time 4 sec and 7 sec
      print("Exposure SetStepSize" +
          cameraController.getExposureOffsetStepSize().toString());
      var mxEXP = await cameraController.getMaxExposureOffset();
      var mnEXP = await cameraController.getMinExposureOffset();
      print("Exposure Max" + mxEXP.toString());
      print("Exposure Min" + mnEXP.toString());
      var step = await cameraController.getExposureOffsetStepSize();
      cameraController.setExposureOffset(1.1);
      isInitialized.value = true;

      print("TEST ****** TEST" + step.toString());
      print(_accelerometerSubscription);
      print("TEST ****** TEST" + step.toString());
    } catch (e) {
      log('Failed to initialize camera: $e');
    }
  }

  // Future<void> TakePhoto() async {
  //   if (cameraController.value.isRecordingVideo) {
  //     return;
  //   }

  //   try {
  //     await cameraController.takePicture();
  //   } on CameraException catch (e) {
  //     log('Error starting to record video: $e');
  //   }
  // }

  // Future<XFile?> takephoto() async {
  //   if (!cameraController.value.isRecordingVideo) {
  //     return null;
  //   }

  //   try {
  //     XFile file = await cameraController.takePicture();
  //     log("StopRecording Called => ${file.path} ");
  //     isRecordingStart.value = false;
  //     showButtonLoader.value = false;

  //     return file;
  //   } on CameraException catch (e) {
  //     log('Error stopping video recording: $e');
  //     return null;
  //   }
  // }

  // Future<void> capturePhoto() async {
  //   // if (rightArrow.value == false &&
  //   //     leftArrow.value == false &&
  //   //     upwordArrow.value == false &&
  //   //     bottomArrow.value == false) {
  //   //   showButtonLoader.value = true;
  //   try {
  //     // await TakePhoto();

  //     savephoto();
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   // } else {
  //   //   Constants.showMessage("Opps!", "Hold your phone steady over the strip, please.");
  //   // }
  // }
  void takePhoto() async {
    if (upwordArrow.value == false &&
        bottomArrow.value == false &&
        leftArrow.value == false &&
        rightArrow.value == false) {
      try {
        showButtonLoader.value = true;
        _accelerometerSubscription.cancel().then((value) => {print("Canle")});
        photo = await cameraController.takePicture();
        String tempName = photo!.path;
        String extension = tempName.split('/').last.split('.').last;

        DateTime now = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd_kk:mm:ss').format(now);
        String fileNameNew =
            "1234567890_${formattedDate.toString()}.$extension";

        var path = photo!.path;
        var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
        fileName.value = path.substring(0, lastSeparator + 1) + fileNameNew;
        await File(photo!.path).rename(fileName.value);

        // Update the previewPhoto with the new XFile object
        previewPhoto = XFile(fileName.value);

        // Update other state variables as needed
        videoCaptured.value = true;
        showButtonLoader.value = false;
      } catch (e) {
        log('Failed to capture photo: $e');
      }
    } else {
      Constants.showMessage(
          "Opps!", "Hold your phone steady over the strip, please.");
    }
  }

  void onTapUp(TapUpDetails details) {
    if (!videoCaptured.value && !showLoader.value) {
      x.value = details.globalPosition.dx;
      y.value = details.globalPosition.dy;
      showFocusCircle.value = true;

      Timer(const Duration(milliseconds: 500), () {
        showFocusCircle.value = false;
      });

      final Size screen = Get.size;
      final double relX = details.globalPosition.dx / screen.width;
      final double relY = details.globalPosition.dy / screen.height;
      Offset point = Offset(relX, relY);
      log("point : $point");
      cameraController.setExposureMode(ExposureMode.auto);
      cameraController.setFocusPoint(point);
      cameraController.setFocusMode(FocusMode.locked);
    }
  }

  void resetVideoCapture() {
    Get.close(2);
    _accelerometerSubscription.cancel();
    _initAccelerometer();
    isRecordingStart.value = false;

    isVideoPlayInitialized.value = false;
    // cameraController.setFlashMode(FlashMode.torch);

    videoCaptured.value = false;
    photo = null;
    // ErrorPopUp("Pay Attention".tr, "maintain_phone_level".tr);
  }

  Future uploadImages(patientId, context) async {
    showLoader.value = true;
    Get.close(1); // close the dialog
    print(fileName.value);
    print(patientId);
    if (fileName.value != "") {
      AuthController authController = Get.find();
      print(authController.isProfessional);
      if (authController.isProfessional == false) {
        ApiServices().uploadVideoPersonal(fileName.value).then((value) {
          //  Get.offAndToNamed('/processing');
          log("value => $value");
          if (value != null) {
            patientUid.value = int.parse(value['patient_id'].toString());
            patientFullName.value = value['full_name'];
            patientAge.value = int.parse(value['age'].toString());
            patientGlucoValue.value = value['prepap_value'].toString();
            Get.close(3);
            Get.toNamed("/result");
          } else {
            // ErrorPopUp(value);
          }
          showLoader.value = false;
        });
      } else {
        ApiServices()
            .uploadVideoProfessional(fileName.value, patientId)
            .then((value) {
          //  Get.offAndToNamed('/processing');
          log("value => $value");
          if (value != null) {
            patientUid.value = int.parse(value['patient_id'].toString());
            patientFullName.value = value['full_name'];
            patientAge.value = int.parse(value['age'].toString());
            patientGlucoValue.value = value['prepap_value'].toString();
            Get.close(2);
            Get.toNamed("/result");
          } else {
            // ErrorPopUp(value);
          }
          showLoader.value = false;
        });
      }
    } else {
      var pid;
      pid = patientId;
    }
  }

  Future ErrorPopUp(String title, String errormessage) {
    var context = Get.context;
    return Get.dialog(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
              height: Get.height * .25,
              width: Get.width * .9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context!).colorScheme.onSecondary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(
                      title,
                      style:
                          Theme.of(context!).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        errormessage.toString(),
                        style: Theme.of(context!)
                            .textTheme
                            .titleSmall!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: Get.width * .25,
                          height: Get.height * .06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              resetVideoCapture();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: Text(
                              "retake".tr,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
