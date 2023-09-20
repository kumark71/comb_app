import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';
import 'package:hemoqr/controllers/reports_controller.dart';
import 'package:hemoqr/models/personal_result_model.dart';
import 'package:hemoqr/models/professional_result_model.dart';
import 'package:hemoqr/ui/utils/constants.dart';

class ScreeningReport extends StatefulWidget {
  const ScreeningReport({super.key});

  @override
  State<ScreeningReport> createState() => Screening_ReportState();
}

class Screening_ReportState extends State<ScreeningReport> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var fontSize = MediaQuery.of(context).textScaleFactor;
    ReportsController reportsController = Get.find();
    AuthController authController = Get.find();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Obx(
          () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            "screening_reports".tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: .5,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                            onTap: () {
                              reportsController.showDatePicker(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateTime.now().toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                                Icon(
                                  FontAwesomeIcons.calendar,
                                  size: 25,
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              ],
                            ),
                          ),
                        )),
                    reportsController.isButtonLoading.value == false
                        ? GestureDetector(
                            onTap: () {
                              if (authController.isProfessional != false) {
                                if (reportsController
                                    .professionalResult.isNotEmpty) {
                                  if (reportsController
                                      .professionalFilteredData.isEmpty) {
                                    reportsController.exportToProfessionalPDF(
                                        reportsController.professionalResult
                                            .cast<ProfessionalResultModel>());
                                  } else {
                                    reportsController.exportToProfessionalPDF(
                                        reportsController
                                            .professionalFilteredData
                                            .cast<ProfessionalResultModel>());
                                  }
                                } else {
                                  Constants.showMessage(
                                      "Opps!", "Data Not Found");
                                }
                              } else {
                                if (reportsController
                                    .personalResults.isNotEmpty) {
                                  if (reportsController
                                      .personalFilteredData.isEmpty) {
                                    reportsController.exportToPersonalPDF(
                                        reportsController.personalResults);
                                  } else {
                                    reportsController.exportToPersonalPDF(
                                        reportsController.personalFilteredData
                                            .cast<Map<String, dynamic>>()
                                            .cast<PersonalResultModel>());
                                  }
                                } else {
                                  Constants.showMessage(
                                      "Opps!", "Data Not Found");
                                }
                              }
                            },
                            child: Icon(
                              Icons.download_for_offline_sharp,
                              size: 40,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )
                        : CircularProgressIndicator()
                  ],
                ),
                reportsController.isLoading == 0
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xFF4C5272), width: 0.5)),
                          height: size.height * 0.7,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Obx(
                                () => DataTable(
                                    columnSpacing: 10,
                                    headingRowColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        return Theme.of(context)
                                            .colorScheme
                                            .secondary;
                                      },
                                    ),
                                    headingTextStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: fontSize * 20),
                                    border: TableBorder.all(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0xFFEAEAEA),
                                        width: 0.2),
                                    columns: <DataColumn>[
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'name'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'date'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'test_type'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'age'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'result'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    rows: reportsController.generateRow()),
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Constants.CustomLoader(),
                      ),
              ]),
        ),
      ),
    );
  }
}
