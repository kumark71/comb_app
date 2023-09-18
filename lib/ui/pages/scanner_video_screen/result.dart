import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';
import 'package:hemoqr/controllers/qr_scanner_controller.dart';
import '../../widgets/button.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  QRScannerController qrScannerController = Get.find();
  AuthController authController = Get.find();
  void _showDetailsDialog(
      BuildContext context, String title, String wtm, String wth, String wtd) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 3, color: Theme.of(context).colorScheme.primary),
              borderRadius: BorderRadius.circular(20)),
          actionsPadding: EdgeInsets.all(12),
          insetPadding: EdgeInsets.all(12),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: MediaQuery.of(context).textScaleFactor * 18,
                    ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                      size: 30,
                      color: Theme.of(context).colorScheme.primary,
                      Icons.close))
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "what_it_means".tr,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: MediaQuery.of(context).textScaleFactor * 18,
                    ),
              ),
              Text(
                wtm,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: MediaQuery.of(context).textScaleFactor * 15,
                    ),
              ),
              SizedBox(height: 16),
              Text(
                "why_it_happens".tr,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: MediaQuery.of(context).textScaleFactor * 18,
                    ),
              ),
              Text(
                wth,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: MediaQuery.of(context).textScaleFactor * 15,
                    ),
              ),
              SizedBox(height: 16),
              Text(
                "what_to_do".tr,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: MediaQuery.of(context).textScaleFactor * 18,
                    ),
              ),
              Text(
                wtd,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: MediaQuery.of(context).textScaleFactor * 15,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // var fontSize = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          color: Theme.of(context).colorScheme.primary,
                          icon: Icon(Icons.arrow_back_ios_new),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "result".tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: size.height * 0.45,
                        width: size.width,
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            authController.profilePic != ""
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                        authController.profilePic.value))
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    child: Icon(
                                      Icons.person,
                                      size: 50,
                                    )),
                            Text(
                              qrScannerController.patientFullName.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: size.width * .3,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.female,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: SizedBox(
                                          child: AutoSizeText(
                                            authController.gender == "f"
                                                ? "Female"
                                                : "Female",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .textScaleFactor *
                                                          15,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * .04,
                                  child: VerticalDivider(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    thickness: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * .3,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: SizedBox(
                                          child: AutoSizeText(
                                            qrScannerController.patientAge == 0
                                                ? "NA yrs"
                                                : "${qrScannerController.patientAge} yrs",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .textScaleFactor *
                                                          15,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              color: Theme.of(context).colorScheme.onSurface,
                              thickness: .5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.gas_meter,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: SizedBox(
                                    width: size.width * 0.5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AutoSizeText(
                                          "Vaginal Ph Health",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                                fontSize: MediaQuery.of(context)
                                                        .textScaleFactor *
                                                    15,
                                              ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: AutoSizeText(
                                            "${qrScannerController.patientGlucoValue}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .textScaleFactor *
                                                          15,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (qrScannerController
                                            .patientGlucoValue.value
                                            .toLowerCase() ==
                                        "normal") {
                                      _showDetailsDialog(
                                          context,
                                          "mild_imbalance".tr,
                                          "vaginal_pH_info".tr,
                                          "vaginal_pH_cause".tr,
                                          "vaginal_pH_solution".tr);
                                    } else if (qrScannerController
                                            .patientGlucoValue.value
                                            .toLowerCase() ==
                                        "mild") {
                                      _showDetailsDialog(
                                          context,
                                          "moderate_imbalance".tr,
                                          "vaginal_pH_info_2".tr,
                                          '''vaginal_pH_cause_2'''.tr,
                                          "vaginal_pH_solution_2".tr);
                                    } else if (qrScannerController
                                            .patientGlucoValue.value
                                            .toLowerCase() ==
                                        "severe") {
                                      _showDetailsDialog(
                                          context,
                                          "severe_imbalance".tr,
                                          "vaginal_pH_info_3".tr,
                                          "vaginal_pH_cause_3".tr,
                                          "vaginal_pH_solution_3".tr);
                                    }
                                  },
                                  icon: Icon(Icons.info),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: size.width * 0.4,
                      height: size.height * .06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.offNamedUntil("/home", (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: Text(
                          "home".tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                    ),
                    CustomButton(
                      height: size.height * .06,
                      buttonText: 'scan_again'.tr,
                      onPressed: () {
                        Get.offAndToNamed("/qrscanner",
                            arguments: [qrScannerController.patientUid.value]);
                      },
                      width: size.width * 0.4,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
