import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';
import 'package:hemoqr/controllers/personal_account_controller.dart';

import '../../widgets/button.dart';
import '../../utils/color_constants.dart';
import '../../widgets/text_form_field.dart';

class PersonalAccount extends StatefulWidget {
  const PersonalAccount({super.key});

  @override
  State<PersonalAccount> createState() => _PersonalAccountState();
}

class _PersonalAccountState extends State<PersonalAccount> {
  @override
  Widget build(BuildContext context) {
    PersonalAccountController personalAccController = Get.find();
    AuthController authController = Get.find();
    Size size = MediaQuery.of(context).size;
    var fontSize = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  color: Theme.of(context).colorScheme.primary,
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Let’s setup your account",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.0),
                        child: Obx(
                          () => InputField(
                            errorValue:
                                personalAccController.fullNameError.value,
                            onChanged: (value) {
                              personalAccController.fullName.value = value;
                            },
                            icon: const Icon(
                              Icons.person,
                            ),
                            label: "Full Name",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Obx(
                          () => InputField(
                            length: 3,
                            errorValue: personalAccController.ageError.value,
                            onChanged: (value) {
                              try {
                                final age = int.parse(value);
                                personalAccController.ageChanged(age);
                              } catch (e) {
                                personalAccController.ageChanged(0);

                                print('Error parsing age: $value');
                              }
                            },
                            icon: const Icon(
                              Icons.calendar_month,
                            ),
                            label: "Age",
                            inputType: TextInputType.number,
                          ),
                        ),
                      ),
                      /*Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      personalAccController.gender.value = "male";
                                      personalAccController.genderError.value = "";
                                      personalAccController.isMaleSelected.value = true;
                                      personalAccController.isFemaleSelected.value = false;
                                    },
                                    child: Obx(
                                      () => Container(
                                        padding: const EdgeInsets.symmetric(vertical: 4),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2,
                                              color: personalAccController.isMaleSelected.value
                                                  ? Theme.of(context).colorScheme.primary
                                                  : Theme.of(context).colorScheme.onSecondary),
                                          borderRadius: BorderRadius.circular(15),
                                          color: ColorConstant.cardBgColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(FontAwesomeIcons.mars,
                                                  size: 23,
                                                  color: personalAccController.isMaleSelected.value
                                                      ? Theme.of(context).colorScheme.primary
                                                      : Theme.of(context).colorScheme.onSecondary),
                                              SizedBox(width: size.width * 0.02),
                                              Text(
                                                "Male",
                                                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                                    color: personalAccController.isMaleSelected.value
                                                        ? Theme.of(context).colorScheme.primary
                                                        : Theme.of(context).colorScheme.onSecondary),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      personalAccController.gender.value = "female";
                                      personalAccController.genderError.value = "";
                                      personalAccController.isMaleSelected.value = false;
                                      personalAccController.isFemaleSelected.value = true;
                                    },
                                    child: Obx(
                                      () => Container(
                                        padding: const EdgeInsets.symmetric(vertical: 4),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2,
                                              color: personalAccController.isFemaleSelected.value
                                                  ? Theme.of(context).colorScheme.primary
                                                  : Theme.of(context).colorScheme.onSecondary),
                                          borderRadius: BorderRadius.circular(15),
                                          color: ColorConstant.cardBgColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(FontAwesomeIcons.venus,
                                                  size: 23,
                                                  color: personalAccController.isFemaleSelected.value
                                                      ? Theme.of(context).colorScheme.primary
                                                      : Theme.of(context).colorScheme.onSecondary),
                                              SizedBox(width: size.width * 0.02),
                                              Text(
                                                "Female",
                                                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                                    color: personalAccController.isFemaleSelected.value
                                                        ? Theme.of(context).colorScheme.primary
                                                        : Theme.of(context).colorScheme.onSecondary),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Obx(() => personalAccController.genderError.value != ""
                                ? Text(
                                    personalAccController.genderError.value,
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                          fontSize: fontSize * 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.red,
                                        ),
                                  )
                                : const SizedBox()),
                          ],
                        ),
                      ), */
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Obx(
                          () => InputField(
                            errorValue: personalAccController.stateError.value,
                            onChanged: (value) {
                              personalAccController.state.value = value;
                            },
                            icon: const Icon(
                              Icons.house,
                            ),
                            label: "State",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Obx(
                          () => InputField(
                            errorValue:
                                personalAccController.mobileNumberError.value,
                            onChanged: (value) {
                              personalAccController.mobileNumber.value = value;
                            },
                            icon: const Icon(
                              FontAwesomeIcons.mobile,
                            ),
                            readOnly: true,
                            label: "Mobile Number",
                            initialValue:
                                authController.phoneNumber.value.toString(),
                            inputType: TextInputType.number,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //
                Spacer(
                  flex: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15),
                  child: CustomButton(
                    height: size.height * .06,
                    buttonText: 'Submit',
                    onPressed: () {
                      personalAccController.submit();
                    },
                    width: size.width,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
