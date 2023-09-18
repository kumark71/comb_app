import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';
import 'package:hemoqr/models/personal_result_model.dart';
import 'package:hemoqr/models/professional_result_model.dart';
import 'package:hemoqr/providers/api_providers.dart';
import 'package:hemoqr/ui/widgets/button.dart';
import 'package:hemoqr/ui/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:talker/talker.dart';

class ReportsController extends GetxController {
  final talker = Talker();

  List<PersonalResultModel> personalResults = [];
  var professionalResult = [];
  // var jsonData = [].obs;
  var personalFilteredData = [].obs;
  var professionalFilteredData = [].obs;
  var isloading = false.obs;
  var selectedDate = ''.obs;
  var dateCount = ''.obs;
  var range = ''.obs;
  var rangeCount = ''.obs;
  var selectedRange = "".obs;
  var isLoading = 0.obs;
  var isButtonLoading = false.obs;
  // SelectionPopupModel? selectedDropDownValue;

  @override
  void onInit() async {
    AuthController authController = Get.find();
    super.onInit();
    if (authController.isProfessional == false) {
      getPersonalReports();
    } else {
      getProfessonalReports();
    }
    talker.good('Result Called');
  }

  generateRow() {
    AuthController authController = Get.find();
    log(authController.isProfessional.toString());
    var context = Get.context;
    if (authController.isProfessional == false) {
      if (personalFilteredData.length == 0) {
        return personalResults.map((result) {
          return DataRow(
            cells: [
              DataCell(Text(
                result.fullName,
                style: Theme.of(context!).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                    ),
              )),
              DataCell(Text(
                DateFormat('dd-MM-yyyy hh:mm ').format(result.reportedDate),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                    ),
              )),
              DataCell(
                Text(
                  '${result.age.toString()}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
              DataCell(
                Text(
                  '${result.perpapValue.toString()}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
            ],
          );
        }).toList();
      } else {
        return personalFilteredData.map((result) {
          return DataRow(
            cells: [
              DataCell(
                Text(
                  result.fullName,
                  style: Theme.of(context!).textTheme.bodyMedium!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
              DataCell(
                Text(
                  DateFormat('dd-MM-yyyy hh:mm ').format(result.reportedDate),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
              DataCell(
                Text(
                  '${result.age.toString()}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
              DataCell(
                Text(
                  result.perpapValue.toString(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
            ],
          );
        }).toList();
      }
    } else {
      if (professionalFilteredData.length == 0) {
        return professionalResult.map(
          (result) {
            return DataRow(
              cells: [
                DataCell(Text(
                  result.fullName,
                  style: Theme.of(context!).textTheme.bodyMedium!.copyWith(
                        color: Colors.black,
                      ),
                )),
                DataCell(Text(
                  DateFormat('dd-MM-yyyy hh:mm ').format(result.reportedDate),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black,
                      ),
                )),
                DataCell(
                  Text(
                    result.age != 0 ? '${result.age.toString()}' : 'NA',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ),
                DataCell(
                  Text(
                    result.perpapValue.toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ),
              ],
            );
          },
        ).toList();
      } else {
        return professionalFilteredData.map(
          (result) {
            return DataRow(
              cells: [
                DataCell(Text(
                  result.fullName,
                  style: Theme.of(context!).textTheme.bodyMedium!.copyWith(
                        color: Colors.black,
                      ),
                )),
                DataCell(Text(
                  DateFormat('dd-MM-yyyy hh:mm ').format(result.reportedDate),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black,
                      ),
                )),
                DataCell(
                  Text(
                    result.age != 0 ? '${result.age.toString()}' : 'NA',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ),
                DataCell(Text(
                  result.glucoValue.toString(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black,
                      ),
                )),
              ],
            );
          },
        ).toList();
      }
    }
  }

  getProfessonalReports() {
    isLoading.value = 1;

    ApiServices().professionalReports().then((value) {
      isLoading.value = 0;
      if (value != null) {
        talker.good("Report Value : " + value.toString());
        professionalResult = value;
      } else {
        // Get.back();
      }
    });
  }

  getPersonalReports() {
    isLoading.value = 1;
    talker.good("Personal");
    ApiServices().personalReports().then((value) {
      isLoading.value = 0;
      if (value != null) {
        personalResults = value;
      } else {
        // Get.back();
      }
    });
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      range.value = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
          // ignore: lines_longer_than_80_chars
          ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
    } else if (args.value is DateTime) {
      selectedDate.value = args.value.toString();
    } else if (args.value is List<DateTime>) {
      dateCount.value = args.value.length.toString();
    } else {
      rangeCount.value = args.value.length.toString();
    }
  }

  showDatePicker(context) {
    AuthController authController = Get.find();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return Container(
          // color: Colors.transparent,
          decoration: BoxDecoration(),
          height: size.height * .5, // Adjust the height as needed
          child: Column(
            children: [
              ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    onPressed: () {
                      var splitStr = ((range.value).split("- "));
                      if (splitStr[0].trim() == splitStr[1].trim()) {
                        selectedRange.value = splitStr[0].trim();
                      } else {
                        selectedRange.value = range.value;
                      }
                      talker.good(splitStr);
                      DateTime startDate =
                          DateFormat('dd/MM/yyyy').parse(splitStr[0]);
                      DateTime endDate =
                          DateFormat('dd/MM/yyyy').parse(splitStr[1]);

                      log("Start Date " + startDate.toString());

                      log("End Date " + endDate.toString());
                      if (authController.isProfessional == true) {
                        professionalFilteredData.value =
                            professionalResult.where((item) {
                          DateTime createdAt = item.reportedDate;

                          if (startDate == endDate) {
                            return createdAt.day == startDate.day &&
                                createdAt.month == startDate.month &&
                                createdAt.year == startDate.year;
                          } else {
                            return createdAt.isAfter(startDate) &&
                                createdAt.isBefore(endDate);
                          }
                        }).toList();
                        if (professionalFilteredData.isEmpty) {
                          Constants.showMessage(
                            'Opps!',
                            'No Data Found',
                          );
                        }
                      } else {
                        personalFilteredData.value =
                            personalResults.where((item) {
                          DateTime createdAt = item.reportedDate;

                          if (startDate == endDate) {
                            return createdAt.day == startDate.day &&
                                createdAt.month == startDate.month &&
                                createdAt.year == startDate.year;
                          } else {
                            return createdAt.isAfter(startDate) &&
                                createdAt.isBefore(endDate);
                          }
                        }).toList();
                        if (personalFilteredData.isEmpty) {
                          Constants.showMessage(
                            'Opps!',
                            'No Data Found',
                          );
                        }
                      }
                      Navigator.pop(context);
                    },
                    width: size.width * .4,
                    height: size.height * .05,
                    buttonText: "Submit",
                  ),
                  CustomButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    width: size.width * .4,
                    // variant: ButtonVariant.OutlineBluegray500,
                    // fontStyle: ButtonFontStyle.RobotoRomanMedium16Black90084,
                    buttonText: "cancel", height: size.height * .05,
                  )
                ],
              ),
              Expanded(
                child: SfDateRangePicker(
                  onSelectionChanged: onSelectionChanged,
                  selectionMode: DateRangePickerSelectionMode.range,
                  backgroundColor: Colors.transparent,
                  selectionColor: Colors.limeAccent,
                  startRangeSelectionColor: Colors.pink.withOpacity(.1),
                  endRangeSelectionColor: Colors.pink.withOpacity(.1),
                  todayHighlightColor: Colors.black,
                  headerStyle: DateRangePickerHeaderStyle(
                    textStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.black),
                  ),
                  yearCellStyle: DateRangePickerYearCellStyle(
                    todayTextStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.black),
                    textStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.black),
                  ),
                  initialSelectedRange:
                      PickerDateRange(DateTime.now(), DateTime.now()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> exportToPersonalPDF(List<PersonalResultModel> jsonData) async {
    isButtonLoading.value = true;
    Directory? appDocDir = await getExternalStorageDirectory();
    if (appDocDir != null) {
      String appDocPath = appDocDir.path;
      File file = File('$appDocPath/prepap_reports.pdf');

      final pdf = pw.Document();

      int recordsPerPage = 30;
      int totalPages = (jsonData.length / recordsPerPage).ceil();

      for (int page = 0; page < totalPages; page++) {
        int startIndex = page * recordsPerPage;
        int endIndex = (startIndex + recordsPerPage) <= jsonData.length
            ? startIndex + recordsPerPage
            : jsonData.length;

        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Table.fromTextArray(
                data: <List<String>>[
                  ["Name", "DateTime", "Result"],
                  for (int i = startIndex; i < endIndex; i++)
                    [
                      jsonData[i].fullName,
                      DateFormat('yyyy-MM-dd HH:mm:ss')
                          .format(jsonData[i].reportedDate),
                      jsonData[i].perpapValue.toString(),
                    ],
                ],
              );
            },
          ),
        );
      }

      Uint8List pdfBytes = await pdf.save();

      await file.writeAsBytes(pdfBytes);

      String filePath = file.path;
      talker.good(filePath);

      openfile(filePath);
    } else {
      talker.good('External storage directory not available');
    }
  }

  Future<void> exportToProfessionalPDF(
      List<ProfessionalResultModel> jsonData) async {
    isButtonLoading.value = true;
    talker.good(jsonData[0].reportedDate);
    Directory? appDocDir = await getExternalStorageDirectory();
    if (appDocDir != null) {
      String appDocPath = appDocDir.path;
      File file = File('$appDocPath/prepap_reports.pdf');

      final pdf = pw.Document();

      int recordsPerPage = 30;
      int totalPages = (jsonData.length / recordsPerPage).ceil();

      for (int page = 0; page < totalPages; page++) {
        int startIndex = page * recordsPerPage;
        int endIndex = (startIndex + recordsPerPage) <= jsonData.length
            ? startIndex + recordsPerPage
            : jsonData.length;

        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Table.fromTextArray(
                data: <List<String>>[
                  ["Name", "DateTime", "Result"],
                  for (int i = startIndex; i < endIndex; i++)
                    [
                      jsonData[i].fullName,
                      DateFormat('yyyy-MM-dd HH:mm:ss')
                          .format(jsonData[i].reportedDate),
                      jsonData[i].perpapValue.toString(),
                    ],
                ],
              );
            },
          ),
        );
      }

      Uint8List pdfBytes = await pdf.save();

      await file.writeAsBytes(pdfBytes);

      String filePath = file.path;
      talker.good(filePath);

      openfile(filePath);
    } else {
      talker.good('External storage directory not available');
    }
  }

  openfile(filePath) {
    OpenFile.open(filePath).then((value) {
      isButtonLoading.value = false;
    });
    talker.good("fff $filePath");
  }
}
