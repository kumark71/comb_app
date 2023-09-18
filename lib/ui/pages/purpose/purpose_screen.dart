import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';
import 'package:hemoqr/controllers/login_controller.dart';

import '../../../controllers/purpose_controller.dart';
import '../../utils/color_constants.dart';
import '../../widgets/cards.dart';

class PurposeScreen extends StatefulWidget {
  const PurposeScreen({super.key});

  @override
  State<PurposeScreen> createState() => _PurposeScreenState();
}

class _PurposeScreenState extends State<PurposeScreen> {
  PurposeController purposeController = Get.find();
  LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  color: Theme.of(context).colorScheme.primary,
                  icon: Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    loginController.isLoading.value = false;
                    Get.offAndToNamed("/loginPersonal");
                  },
                ),
                SizedBox(height: size.height * 0.01),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: Container(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Do you want to use PrePapQR for",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                              SizedBox(height: size.height * 0.1),
                              PurposeCard(
                                size: size,
                                title: "Personal Use",
                                desc:
                                    '''If you want to take readings only for “yourself”''',
                                icon: Icon(
                                  Icons.person,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 30,
                                ),
                                isSelected:
                                    purposeController.selectedCard.value ==
                                        'Personal',
                                onPressed: () {
                                  setState(() {
                                    purposeController.selectedCard.value =
                                        'Personal';
                                  });
                                },
                              ),
                              const SizedBox(height: 20),
                              PurposeCard(
                                size: size,
                                title: "Professional Use",
                                desc:
                                    '''If you want to take readings for lager number of individuls apart from “self” (health camp, hospitals, clinics etc).''',
                                icon: Icon(
                                  Icons.groups,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 30,
                                ),
                                isSelected:
                                    purposeController.selectedCard.value ==
                                        'Professional',
                                onPressed: () {
                                  setState(() {
                                    purposeController.selectedCard.value =
                                        'Professional';
                                  });
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AuthController().getCurrentPosition();
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Please select a use before proceeding",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: size.height * .07,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: ElevatedButton(
                    onPressed: purposeController.selectedCard.value != ""
                        ? () {
                            purposeController.submit();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text(
                      "Next",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.surface,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
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
