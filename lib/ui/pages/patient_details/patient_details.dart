import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hemoqr/controllers/patient_controller.dart';
import 'package:hemoqr/ui/widgets/text_form_field.dart';
import '../../widgets/button.dart';

class PatientDetails extends StatefulWidget {
  const PatientDetails({super.key});

  @override
  State<PatientDetails> createState() => PatientDetailsState();
}

class PatientDetailsState extends State<PatientDetails> {
  @override
  Widget build(BuildContext context) {
    PatientController patientController = Get.find();
    Size size = MediaQuery.of(context).size;
    // var fontSize = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: Obx(
        () => Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    children: [
                      IconButton(
                        color: Theme.of(context).colorScheme.primary,
                        icon: const Icon(Icons.arrow_back_ios_new),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Patient Details",
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
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: InputField(
                        readOnly: patientController.isOtpSent.value == true
                            ? true
                            : false,
                        errorValue: patientController.fullNameError.value,
                        onChanged: (value) {
                          patientController.fullName.value = value;
                        },
                        icon: Icon(
                          Icons.person,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        label: "name".tr,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: InputField(
                        readOnly: patientController.isOtpSent.value == true
                            ? true
                            : false,
                        errorValue: patientController.ageError.value,
                        onChanged: (value) {
                          try {
                            final age = int.parse(value);
                            patientController.ageChanged(age);
                          } catch (e) {
                            patientController.ageChanged(0);
                          }
                        },
                        icon: Icon(
                          Icons.calendar_month,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        label: "age".tr,
                        inputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: InputField(
                        length: 10,
                        errorValue: patientController.mobileNumberError.value,
                        onChanged: (value) {
                          patientController.mobileNumber.value = value;
                        },
                        icon: Icon(
                          FontAwesomeIcons.mobile,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        label: "mobile_number".tr,
                        inputType: TextInputType.number,
                      ),
                    ),
                    // patientController.isOtpSent.value == true
                    //     ? Padding(
                    //         padding: const EdgeInsets.symmetric(vertical: 4.0),
                    //         child: InputField(
                    //           length: 4,
                    //           errorValue:
                    //               patientController.mobileNumberError.value,
                    //           onChanged: (value) {
                    //             patientController.otpChanged(value);
                    //           },
                    //           icon: Icon(
                    //             Icons.password,
                    //             color: Theme.of(context).colorScheme.primary,
                    //           ),
                    //           label: "Otp",
                    //           inputType: TextInputType.number,
                    //         ),
                    //       )
                    //     : SizedBox(),
                    // GestureDetector(
                    //   onTap: () {
                    //     patientController.editNum();
                    //   },
                    //   child: patientController.isOtpSent == true
                    //       ? Container(
                    //           padding: EdgeInsets.all(8),
                    //           width: size.width,
                    //           child: Text(
                    //             "Edit Mobile Number",
                    //             textAlign: TextAlign.end,
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .labelLarge!
                    //                 .copyWith(
                    //                   color: Theme.of(context)
                    //                       .colorScheme
                    //                       .onPrimary,
                    //                 ),
                    //           ))
                    //       : Container(),
                    // ),
                  ],
                ),
                // patientController.isOtpSent.value == true
                //     ? CustomButton(
                //         height: size.height * .06,
                //         buttonText: 'Verify and Start Capturing',
                //         onPressed: () {
                //           // patientController.isOtpSent.value = true;
                //           patientController.submit();
                //         },
                //         width: size.width,
                //       )
                //     : patientController.isNumber == true
                //         ? patientController.buttonLoading.value == false
                //             ? CustomButton(
                //                 height: size.height * .06,
                //                 buttonText: 'Send Otp',
                //                 onPressed: () {
                //                   patientController.sendOtp();
                //                 },
                //                 width: size.width,
                //               )
                //             : CircleAvatar(
                //                 backgroundColor:
                //                     Theme.of(context).colorScheme.primary,
                //                 radius: 30,
                //                 child: CircularProgressIndicator(
                //                   color: Colors.white,
                //                 ))
                //         : CustomButton(
                //             height: size.height * .06,
                //             buttonText: 'start_screening'.tr,
                //             onPressed: () {
                //               FocusScope.of(context).unfocus();

                //               patientController.submit();
                //             },
                //             width: size.width,
                //           ),

                CustomButton(
                  height: size.height * .06,
                  buttonText: 'Submit and Start Capturing',
                  onPressed: () {
                    // patientController.isOtpSent.value = true;
                    patientController.submit();
                  },
                  width: size.width,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
