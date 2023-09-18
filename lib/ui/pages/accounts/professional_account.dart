import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hemoqr/controllers/professional_account_controller.dart';

import '../../widgets/button.dart';
import '../../utils/color_constants.dart';
import '../../widgets/text_form_field.dart';

class ProfessionalAccount extends StatefulWidget {
  const ProfessionalAccount({super.key});

  @override
  State<ProfessionalAccount> createState() => _ProfessionalAccountState();
}

class _ProfessionalAccountState extends State<ProfessionalAccount> {
  String selectedItem = 'Profile';

  @override
  Widget build(BuildContext context) {
    ProfessionalAccountController professionalAccController = Get.find();
    Size size = MediaQuery.of(context).size;
    var fontSize = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
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
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Obx(() => InputField(
                              icon: const Icon(
                                Icons.person,
                              ),
                              label: "Full Name",
                              errorValue:
                                  professionalAccController.fullNameError.value,
                              onChanged: (value) {
                                professionalAccController.fullName.value =
                                    value;
                              },
                            )),
                      ),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: .5,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 22),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.apartment_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                            iconSize: 24,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surface,
                                                ),
                                            onChanged: (newVal) {
                                              professionalAccController
                                                  .selectedOrganization
                                                  .value = newVal.toString();
                                            },
                                            value: professionalAccController
                                                .selectedOrganization.value,
                                            items: professionalAccController
                                                .organizations
                                                .map((item) {
                                              return DropdownMenuItem(
                                                value: item['id'].toString(),
                                                child: Text(
                                                  item['organization_name']
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                      ),
                                                ),
                                              );
                                            }).toList(),
                                            // Show the selected organization's name here
                                            hint: professionalAccController
                                                    .selectedOrganization
                                                    .value
                                                    .isEmpty
                                                ? Text('Select an Organization')
                                                : Text(
                                                    professionalAccController
                                                        .selectedOrganization
                                                        .value,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium!
                                                        .copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                        ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  professionalAccController
                                              .profileError.value !=
                                          ""
                                      ? Text(
                                          professionalAccController
                                              .profileError.value,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium
                                              ?.copyWith(
                                                fontSize: fontSize * 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.red,
                                              ),
                                        )
                                      : SizedBox()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: .5,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 22),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.cases_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            value: professionalAccController
                                                .selectedProfile.value,
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                            iconSize: 24,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surface,
                                                ),
                                            onChanged: (String? newValue) {
                                              if (newValue != null) {
                                                professionalAccController
                                                    .updateSelectedItem(
                                                        newValue);
                                              } else {
                                                // Handle the validation error
                                                // For example, display an error message
                                                // or set a flag indicating that the selection is invalid
                                              }
                                            },
                                            items: <String>[
                                              'Profile',
                                              'Doctor',
                                              'Nurse',
                                              'Asha Worker',
                                              'Other',
                                            ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium!
                                                        .copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                        ),
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  professionalAccController
                                              .profileError.value !=
                                          ""
                                      ? Text(
                                          professionalAccController
                                              .profileError.value,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium
                                              ?.copyWith(
                                                fontSize: fontSize * 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.red,
                                              ),
                                        )
                                      : SizedBox()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Obx(() => InputField(
                              icon: const Icon(
                                Icons.house,
                              ),
                              label: "State",
                              errorValue:
                                  professionalAccController.stateError.value,
                              onChanged: (value) {
                                professionalAccController.state.value = value;
                              },
                            )),
                      ),
                    ],
                  ),
                ),
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
                      professionalAccController.submit();
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
