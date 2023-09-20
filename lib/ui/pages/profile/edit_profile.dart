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
            child:
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: size.width*0.05),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child:
                      Text(
                        'lets_setup_your'.tr,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontFamily: 'Montserrat',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:  size.width*0.05),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'account'.tr,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height*0.04,),

                  authController.isProfessional == true
                      ? SizedBox(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6.0, horizontal: 10),
                                child: InputField(
                                  onChanged: (val) {
                                    profileController.onNameChanged(val);
                                  },
                                  icon: Icon(
                                    Icons.person,
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
                                    FontAwesomeIcons.calendar,
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        profileController.onGenderChanged('male');
                                      },
                                      child: Container(
                                        height: size.height*0.08,
                                        width: size.width*0.4,
                                        decoration: BoxDecoration(
                                          color: profileController.gender=="male"? Color.fromRGBO(150, 83, 238, 1):Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child:
                                              Icon(Icons.male,color:
                                              profileController.gender!="male"? Color.fromRGBO(150, 83, 238, 1):Colors.white,
                                            ),
                                              
                                              
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child:
                                              Text('male'.tr,style: TextStyle(fontSize: 16,color:profileController.gender!="male"? Color.fromRGBO(150, 83, 238, 1):Colors.white, )
                                              ),


                                            ),
                                          ],
                                        ),

                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        profileController.onGenderChanged('female');
                                      },
                                      child: Container(
                                        height: size.height*0.08,
                                        width: size.width*0.4,
                                        decoration: BoxDecoration(
                                          color: profileController.gender=="female"? Color.fromRGBO(150, 83, 238, 1):Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child:
                                              Icon(Icons.female,color:
                                              profileController.gender!="female"? Color.fromRGBO(150, 83, 238, 1):Colors.white,
                                              ),


                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child:
                                              Text('female'.tr,style: TextStyle(fontSize: 16,color:profileController.gender!="female"? Color.fromRGBO(150, 83, 238, 1):Colors.white, )
                                              ),


                                            ),
                                          ],
                                        ),

                                      ),
                                    )
                                  ],
                                )
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


                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: GestureDetector(
                                  onTap: () {
                                    profileController.updateProfile();
                                  },
                                  child: Container(
                                    height: size.height*0.08,
                                    width: size.width*0.8,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(150, 83, 238, 1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child:
                                    Align(
                                      alignment: Alignment.center,
                                        child: Text('submit'.tr,style:TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),))

                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
