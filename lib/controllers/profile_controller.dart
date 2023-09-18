import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';
import 'package:hemoqr/providers/api_providers.dart';
import 'package:hemoqr/ui/utils/constants.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  AuthController authController = Get.find();
  var profileImage = Rx<File?>(null);
  var name = "".obs;
  var age = "".obs;
  var state = "".obs;
  var phoneNumber = "".obs;
  var gender = "".obs;
  var profileUrl = "".obs;
  var orgName = "".obs;
  var profileType = "Profile".obs;
  var profileError = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadDetails();
  }

  Future loadDetails() async {
    name.value = authController.name.value;
    age.value = authController.age.value;
    state.value = authController.state.value;
    gender.value = authController.gender.value;
    profileUrl.value = authController.profilePic.value;
    phoneNumber.value = authController.phoneNumber.value;
    orgName.value = authController.organizationName.value;
    // profileType.value = authController.profile_type; // uncomment after d for doctor changes
    print(profileType);
  }

  Future<void> pickImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage.value = File(pickedImage.path);
    }
  }

  Future<void> updateProfile() async {
    var jsonResponse;
    authController.isProfessional == true
        ? ApiServices()
            .updateExistingProfessionalProfile(
                orgName.value, name.value, profileType.value, state.value, profileImage.value)
            .then(
              (values) => {
                jsonResponse = json.decode(values),
                print(jsonResponse),
                Get.back(),
                Constants.showMessage("Success", jsonResponse['message'].toString()),
                authController.saveUser().then((value) {
                  // Get.back();
                })
              },
            )
        : ApiServices()
            .updateExistingPersonalProfile(
                name.value, age.value, state.value, gender.value, phoneNumber.value, profileImage.value)
            .then(
              (values) => {
                print(values),
                jsonResponse = json.decode(values),
                Get.back(),
                Constants.showMessage("Success", jsonResponse['message'].toString()),
                authController.saveUser().then(
                  (value) {
                    // Get.back();
                  },
                )
              },
            );
  }

  onNameChanged(val) {
    name.value = val;
  }

  onAgeChanged(val) {
    age.value = val;
  }

  onStateChanged(val) {
    state.value = val;
  }

  onOrgChanged(val) {
    orgName.value = val;
  }

  void updateSelectedItem(String newValue) {
    if (newValue != "Profile") {
      profileError.value = "";
    } else {
      profileError.value = "Please Select Profile";
    }
    profileType.value = newValue;
  }
}
