// import 'dart:async';
// import 'dart:developer';
// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hemoqr/controllers/auth_controller.dart';
// import 'package:hemoqr/providers/api_providers.dart';
// import 'package:hemoqr/ui/utils/color_constants.dart';
// import 'package:hemoqr/ui/utils/constants.dart';
// import 'package:intl/intl.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'package:video_player/video_player.dart';

// class QRScannerController extends GetxController {
//   late CameraController cameraController;
//   final isInitialized = false.obs;
//   final videoCaptured = false.obs;
//   // var countDown = 7.obs;
//   final showLoader = false.obs;
//   final showFocusCircle = false.obs;
//   final showButtonLoader = false.obs;
//   final x = 0.0.obs;
//   final y = 0.0.obs;
//   var patientUid = 0.obs;
//   var patientFullName = "".obs;
//   var patientAge = 0.obs;
//   var patientGlucoValue = 0.0.obs;
//   late VideoPlayerController videoPlayerController;

//   //Accelerometer Variables
//   var _x = 0.0.obs;
//   var _y = 0.0.obs;
//   var _z = 0.0.obs;
//   var rightArrow = false.obs;
//   var leftArrow = false.obs;
//   var upwordArrow = false.obs;
//   var bottomArrow = false.obs;
//   RxBool isVideoPlayInitialized = false.obs;
//   var isRecordingStart = false.obs;
//   late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

//   //recording vars
//   XFile? video;
//   var fileName = "".obs;
//   late Timer increaseExpostureTimer;
//   var expotureValue = 1.1.obs;

//   //timer
//   var secondsRemaining = 7.obs;
//   Timer? recordingTimer;

//   @override
//   void onInit() {
//     super.onInit();
//     initializeCamera();
//     _initAccelerometer();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//     cameraController.dispose();
//   }

//   void _initAccelerometer() {
//     _accelerometerSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
//       _x.value = event.x;
//       _y.value = event.y;
//       _z.value = event.z;
//       _checkForMove();
//     });
//   }

//   void startTimer() async {
//     print("Starting countdown...");
//     secondsRemaining.value = 7;
//     recordingTimer = await Timer.periodic(Duration(seconds: 1), recordingTimerCallback);
//   }

//   void stopTimer() {
//     recordingTimer!.cancel();
//     print("Countdown stopped.");
//   }

//   void resetTimer() {
//     stopTimer();
//     secondsRemaining.value = 7;
//   }

//   void recordingTimerCallback(Timer timer) {
//     secondsRemaining.value--;

//     if (secondsRemaining.value <= 0) {
//       timer.cancel();
//       print("Countdown complete!");
//     }
//   }

//   void _checkForMove() {
//     if (_x > 1.5) {
//       rightArrow.value = true;
//       if (isRecordingStart.value == true) {
//         stopVideoRecording();
//         resetVideoCapture();
//       }
//     } else {
//       rightArrow.value = false;
//     }

//     if (_x < -1.5) {
//       print("Move Left");
//       if (isRecordingStart.value == true) {
//         stopVideoRecording();
//         resetVideoCapture();
//       }
//       leftArrow.value = true;
//     } else {
//       leftArrow.value = false;
//     }

//     if (_y > 2.0) {
//       print("Move Up");
//       if (isRecordingStart.value == true) {
//         stopVideoRecording();
//         resetVideoCapture();
//       }

//       upwordArrow.value = true;
//     } else {
//       upwordArrow.value = false;
//     }

//     if (_y < -1.0) {
//       print("Move Downwards");
//       if (isRecordingStart.value == true) {
//         stopVideoRecording();
//         resetVideoCapture();
//       }
//       bottomArrow.value = true;
//     } else {
//       bottomArrow.value = false;
//     }
//   }

//   void initializeCamera() async {
//     final cameras = await availableCameras();
//     final camera = cameras.first;

//     cameraController = CameraController(
//       camera,
//       ResolutionPreset.high,
//       enableAudio: false,
//     );

//     try {
//       double maxZoomLevel;
//       double setZoomLevel;
//       await cameraController.initialize().then((value) => {
//             cameraController.getMaxZoomLevel().then((value) {
//               maxZoomLevel = value;
//               setZoomLevel = maxZoomLevel * 0.4;

//               if (setZoomLevel.toDouble() <= maxZoomLevel.toDouble()) {
//                 cameraController.setZoomLevel(setZoomLevel);
//                 cameraController.setFocusMode(FocusMode.auto);
//               } else {
//                 log("Opps!");
//               }
//             })
//           });
//       //i changed from 1.0 to 1.1 for video time 4 sec and 7 sec
//       cameraController.setExposureOffset(1.1);
//       isInitialized.value = true;
//     } catch (e) {
//       log('Failed to initialize camera: $e');
//     }
//   }

//   Future<void> startVideoRecording() async {
//     if (cameraController.value.isRecordingVideo) {
//       return;
//     }

//     try {
//       await cameraController.startVideoRecording();
//       isRecordingStart.value = true;
//       startTimer();
//     } on CameraException catch (e) {
//       log('Error starting to record video: $e');
//     }
//   }

//   Future<XFile?> stopVideoRecording() async {
//     if (!cameraController.value.isRecordingVideo) {
//       return null;
//     }

//     try {
//       XFile file = await cameraController.stopVideoRecording();
//       log("StopRecording Called");
//       showButtonLoader.value = false;
//       _accelerometerSubscription.cancel();
//       return file;
//     } on CameraException catch (e) {
//       log('Error stopping video recording: $e');
//       return null;
//     }
//   }

//   Future<void> captureVideo() async {
//     if (rightArrow.value == false &&
//         leftArrow.value == false &&
//         upwordArrow.value == false &&
//         bottomArrow.value == false) {
//       showButtonLoader.value = true;
//       try {
//         await startVideoRecording();
//         log("video_recording started");
//         increaseExpoture();
//       } catch (e) {
//         log(e.toString());
//       }
//     } else {
//       Constants.showMessage("Opps!", "Hold your phone steady over the strip, please.");
//     }
//   }

//   void increaseExpoture() async {
//     increaseExpostureTimer = Timer.periodic(const Duration(milliseconds: 118), (timer) async {
//       //I changed the value from 1.4 to 1.3 because the video length decrease
//       expotureValue.value = 1.1; //reseting the expoture
//       if (expotureValue.value <= 1.4) {
//         expotureValue.value += 0.005;
//         log(expotureValue.value.toString());
//         await cameraController.setExposureOffset(expotureValue.value);
//       } else {
//         saveVideo();
//       }
//     });
//   }

//   void saveVideo() async {
//     video = await stopVideoRecording();

//     if (video?.path != null) {
//       String tempName = video!.path;
//       String extension = tempName.split('/').last.split('.').last;

//       DateTime now = DateTime.now();
//       String formattedDate = DateFormat('yyyy-MM-dd_kk:mm:ss').format(now);
//       String fileNameNew = "1234567890_${formattedDate.toString()}.$extension";

//       var path = video!.path;
//       var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
//       fileName.value = path.substring(0, lastSeparator + 1) + fileNameNew;
//       File(video!.path).rename(fileName.value);

//       videoCaptured.value = true;
//       showButtonLoader.value = false;

//       increaseExpostureTimer.cancel();

//       //video player initilize after video
//       videoPlayerController = VideoPlayerController.file(File(fileName.value.toString()));

//       videoPlayerController.initialize().then((_) {
//         isVideoPlayInitialized.value = true;
//         videoPlayerController.play();
//       });
//     }
//   }

//   void onTapUp(TapUpDetails details) {
//     if (!videoCaptured.value && !showLoader.value) {
//       x.value = details.globalPosition.dx;
//       y.value = details.globalPosition.dy;
//       showFocusCircle.value = true;

//       Timer(const Duration(milliseconds: 500), () {
//         showFocusCircle.value = false;
//       });

//       final Size screen = Get.size;
//       final double relX = details.globalPosition.dx / screen.width;
//       final double relY = details.globalPosition.dy / screen.height;
//       Offset point = Offset(relX, relY);
//       log("point : $point");
//       cameraController.setExposureMode(ExposureMode.auto);
//       cameraController.setFocusPoint(point);
//       cameraController.setFocusMode(FocusMode.locked);
//     }
//   }

//   void resetVideoCapture() {
//     isRecordingStart.value = false;
//     _initAccelerometer();
//     resetTimer();
//     isVideoPlayInitialized.value = false;
//     videoCaptured.value = false;
//     video = null;
//     ErrorPopUp("Pay Attention",
//         " Video Recording Stops When Border Turns Red. Maintain Phone Level for Uninterrupted Capture.");
//   }

//   void uploadImages(patientId, context) async {
//     showLoader.value = true;
//     Get.close(1); // close the dialog
//     print(fileName.value);
//     if (fileName.value != "") {
//       AuthController authController = Get.find();
//       var pid;
//       authController.isProfessional == false ? pid = authController.uid : pid = patientId;

//       ApiServices().uploadVideo(fileName.value, pid).then((value) {
//         //  Get.offAndToNamed('/processing');
//         log("value => $value");
//         if (value != null) {
//           patientUid.value = int.parse(value['patient_id'].toString());
//           patientFullName.value = value['full_name'];
//           patientAge.value = int.parse(value['age'].toString());
//           patientGlucoValue.value = double.parse(value['gluco_value'].toString());
//           Get.close(2);
//           Get.toNamed("/result");
//         } else {
//           // ErrorPopUp(value);
//         }
//         showLoader.value = false;
//       });
//     } else {
//       Constants.showMessage("Error", "Cannot find the video");
//     }
//   }

//   Future ErrorPopUp(String title, String errormessage) {
//     var context = Get.context;
//     return Get.dialog(
//       Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Center(
//           child: Container(
//               height: Get.height * .2,
//               width: Get.width * .9,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 gradient: ColorConstant.buttonGradient,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   children: [
//                     Text(
//                       title,
//                       style: Theme.of(context!).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       child: Text(
//                         errormessage.toString(),
//                         style: Theme.of(context!).textTheme.titleSmall,
//                       ),
//                     ),
//                     Spacer(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Container(
//                           width: Get.width * .25,
//                           height: Get.height * .06,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             gradient: LinearGradient(
//                               colors: [ColorConstant.buttonGradientColor2, ColorConstant.buttonGradientColor1],
//                             ),
//                           ),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               resetVideoCapture();
//                               Get.close(2);
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.transparent,
//                               shadowColor: Colors.transparent,
//                             ),
//                             child: Text(
//                               "retake".tr,
//                               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               )),
//         ),
//       ),
//     );
//   }
// }
// // 