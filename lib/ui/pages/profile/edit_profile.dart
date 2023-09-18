import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';
import 'package:hemoqr/controllers/profile_controller.dart';
import 'package:hemoqr/ui/widgets/text_form_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  ProfileController profileController = Get.find();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    var fontSize = MediaQuery.of(context).textScaleFactor;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Obx(
      () => Container(
        height: size.height,
        width: size.width,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "cancel".tr,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                    Text(
                      "edit_profile".tr,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        profileController.updateProfile();
                      },
                      child: Text(
                        "save".tr,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 10,
                  thickness: 1,
                  indent: 8,
                  endIndent: 8,
                  color: Colors.black38,
                ),
                authController.isProfessional == true
                    ? SizedBox(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                // Text(profileController.profileImage.value.toString()),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: profileController.profileImage.value ==
                                          null
                                      ? profileController.profileUrl == ""
                                          ? CircleAvatar(
                                              radius: 80,
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              backgroundImage: profileController
                                                          .profileImage.value !=
                                                      null
                                                  ? FileImage(profileController
                                                      .profileImage.value!)
                                                  : null,
                                              child: profileController
                                                          .profileImage.value ==
                                                      null
                                                  ? Icon(
                                                      Icons.person,
                                                      size: 40,
                                                    )
                                                  : Container(),
                                            )
                                          : CircleAvatar(
                                              radius: 80,
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              backgroundImage: NetworkImage(
                                                  profileController
                                                      .profileUrl.value))
                                      : CircleAvatar(
                                          radius: 80,
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          backgroundImage: profileController
                                                      .profileImage.value !=
                                                  null
                                              ? FileImage(profileController
                                                  .profileImage.value!)
                                              : null,
                                          child: profileController
                                                      .profileImage.value ==
                                                  null
                                              ? Icon(
                                                  Icons.person,
                                                  size: 40,
                                                )
                                              : Container(),
                                        ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        profileController
                                            .pickImageFromGallery();
                                      },
                                      color: Colors.white,
                                      icon: Icon(Icons.image),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6.0, horizontal: 10),
                              child: InputField(
                                onChanged: (val) {
                                  profileController.onNameChanged(val);
                                },
                                icon: Icon(
                                  Icons.edit,
                                ),
                                label: "name",
                                initialValue: profileController.name.value,
                                inputType: TextInputType.text,
                                errorValue: '',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6.0, horizontal: 10),
                              child: InputField(
                                readOnly: true,
                                onChanged: (val) {
                                  profileController.onOrgChanged(val);
                                },
                                icon: Icon(
                                  FontAwesomeIcons.houseCircleCheck,
                                ),
                                label: "Organization Name",
                                initialValue: profileController.orgName.value,
                                inputType: TextInputType.name,
                                errorValue: '',
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       vertical: 8.0, horizontal: 22),
                            //   child: Row(
                            //     children: [
                            //       Icon(
                            //         Icons.cases_rounded,
                            //         color:
                            //             Theme.of(context).colorScheme.primary,
                            //       ),
                            //       const SizedBox(width: 10),
                            //       Expanded(
                            //         child: DropdownButtonHideUnderline(
                            //           child: DropdownButton<String>(
                            //             dropdownColor:
                            //                 ColorConstant.borderColor,
                            //             value:
                            //                 profileController.profileType.value,
                            //             icon: const Icon(
                            //               Icons.arrow_drop_down,
                            //               color: Colors.white,
                            //             ),
                            //             iconSize: 24,
                            //             style: TextStyle(
                            //               color: Colors.white,
                            //               fontSize: fontSize * 22,
                            //             ),
                            //             onChanged: (String? newValue) {
                            //               if (newValue != null) {
                            //                 profileController
                            //                     .updateSelectedItem(newValue);
                            //               } else {
                            //                 // Handle the validation error
                            //                 // For example, display an error message
                            //                 // or set a flag indicating that the selection is invalid
                            //               }
                            //             },
                            //             items: <String>[
                            //               'Profile',
                            //               'Doctor',
                            //               'Nurse',
                            //               'Asha Worker',
                            //               'Other',
                            //             ].map<DropdownMenuItem<String>>(
                            //               (String value) {
                            //                 return DropdownMenuItem<String>(
                            //                   value: value,
                            //                   child: Text(
                            //                     value,
                            //                     style: Theme.of(context)
                            //                         .textTheme
                            //                         .labelMedium,
                            //                   ),
                            //                 );
                            //               },
                            //             ).toList(),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6.0, horizontal: 10),
                              child: InputField(
                                readOnly: true,
                                onChanged: (p0) {},
                                icon: Icon(
                                  FontAwesomeIcons.mobile,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                label: "Mobile Number",
                                initialValue:
                                    profileController.phoneNumber.value,
                                inputType: TextInputType.number,
                                errorValue: '',
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Stack(
                                children: [
                                  // Text(profileController.profileImage.value.toString()),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: profileController
                                                .profileImage.value ==
                                            null
                                        ? profileController.profileUrl == ""
                                            ? CircleAvatar(
                                                radius: 80,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                backgroundImage:
                                                    profileController
                                                                .profileImage
                                                                .value !=
                                                            null
                                                        ? FileImage(
                                                            profileController
                                                                .profileImage
                                                                .value!)
                                                        : null,
                                                child: profileController
                                                            .profileImage
                                                            .value ==
                                                        null
                                                    ? Icon(
                                                        Icons.person,
                                                        size: 50,
                                                      )
                                                    : Container(),
                                              )
                                            : CircleAvatar(
                                                radius: 80,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                backgroundImage: NetworkImage(
                                                    profileController
                                                        .profileUrl.value))
                                        : CircleAvatar(
                                            radius: 80,
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            backgroundImage: profileController
                                                        .profileImage.value !=
                                                    null
                                                ? FileImage(profileController
                                                    .profileImage.value!)
                                                : null,
                                            child: profileController
                                                        .profileImage.value ==
                                                    null
                                                ? Icon(
                                                    Icons.person,
                                                    size: 50,
                                                  )
                                                : Container(),
                                          ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          profileController
                                              .pickImageFromGallery();
                                        },
                                        color: Colors.white,
                                        icon: Icon(Icons.image),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6.0, horizontal: 10),
                              child: InputField(
                                onChanged: (val) {
                                  profileController.onNameChanged(val);
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.userPen,
                                ),
                                label: "name".tr,
                                initialValue: profileController.name.value,
                                inputType: TextInputType.text,
                                errorValue: '',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6.0, horizontal: 10),
                              child: InputField(
                                onChanged: (val) {
                                  profileController.onAgeChanged(val);
                                },
                                length: 2,
                                icon: const Icon(
                                  FontAwesomeIcons.solidUser,
                                ),
                                label: "age".tr,
                                initialValue: profileController.age.value,
                                inputType: TextInputType.number,
                                errorValue: '',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6.0, horizontal: 10),
                              child: InputField(
                                onChanged: (val) {
                                  profileController.onStateChanged(val);
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.house,
                                ),
                                label: "state".tr,
                                initialValue: profileController.state.value,
                                inputType: TextInputType.name,
                                errorValue: '',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6.0, horizontal: 10),
                              child: InputField(
                                readOnly: true,
                                onChanged: (p0) {},
                                icon: const Icon(
                                  FontAwesomeIcons.mobile,
                                ),
                                label: "mobile_number".tr,
                                initialValue:
                                    profileController.phoneNumber.value,
                                inputType: TextInputType.number,
                                errorValue: '',
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
