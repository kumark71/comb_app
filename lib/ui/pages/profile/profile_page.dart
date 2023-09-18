// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';

import 'package:hemoqr/ui/utils/color_constants.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isMaleSelected = false;
  bool isFemaleSelected = false;

  Future<void> _launchUrl(url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    Size size = MediaQuery.of(context).size;
    // var fontSize = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
        body: Obx(
      () => SafeArea(
        child: Column(
          children: [
            Container(
              height: size.height * 0.35,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  IconButton(
                    color: Theme.of(context).colorScheme.primary,
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                        Color(0xff7934da),
                        Color(0xffd6c3f1),
                        Color(0xffc5c2c9),
                      ]),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          authController.profilePic != ""
                              ? CircleAvatar(
                                  radius: 45,
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                  backgroundImage: NetworkImage(
                                    authController.profilePic.value,
                                  ))
                              : CircleAvatar(
                                  radius: 45,
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                  child: Icon(
                                    Icons.person,
                                    size: 40,
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              authController.name.toString().split(" ")[0],
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Container(
              height: size.height * 0.6,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Option(
                        onTap: () {
                          Get.toNamed("editprofile");
                        },
                        label: "edit_profile",
                        icon: Icon(
                          FontAwesomeIcons.penToSquare,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    Option(
                        onTap: () {
                          LaunchReview.launch(androidAppId: "com.smartqr.prepapqr", iOSAppId: "585027354");
                        },
                        label: "write_review",
                        icon: Icon(
                          FontAwesomeIcons.star,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    Option(
                        onTap: () {
                          _launchUrl("https://smartqr.co.in/#/privacyPolicy");
                        },
                        label: "privacy_policy",
                        icon: Icon(
                          FontAwesomeIcons.solidFileLines,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    Option(
                        onTap: () {
                          _launchUrl("https://smartqr.co.in/#/privacyPolicy");
                        },
                        label: "terms_of_use",
                        icon: Icon(
                          FontAwesomeIcons.solidFile,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    Option(
                        onTap: () {
                          Get.toNamed("/faq");
                        },
                        label: "faq",
                        icon: Icon(
                          FontAwesomeIcons.question,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    Option(
                        onTap: () {
                          Get.toNamed("/support");
                        },
                        label: "support".tr,
                        icon: Icon(
                          FontAwesomeIcons.solidMessage,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    Option(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) => Dialog(
                                    onSubmit: () {
                                      authController.logout();
                                    },
                                    text: "Logout",
                                    buttonText: "log_out",
                                  ));
                        },
                        label: "log_out".tr,
                        icon: Icon(
                          FontAwesomeIcons.arrowRightFromBracket,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class Option extends StatelessWidget {
  final String label;
  final Icon icon;
  final VoidCallback onTap;

  const Option({Key? key, required this.label, required this.onTap, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 25,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: .5, color: Theme.of(context).colorScheme.primary),
          ),
          child: Row(
            children: [
              icon,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  label.tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Dialog extends StatefulWidget {
  final String text;
  final String buttonText;
  final VoidCallback onSubmit;

  const Dialog({
    Key? key,
    required this.text,
    required this.buttonText,
    required this.onSubmit,
  }) : super(key: key);

  @override
  DialogState createState() => DialogState();
}

class DialogState extends State<Dialog> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              Size size = constraints.biggest;
              return Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(15.0),
                height: size.height * 0.18,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.onSecondary,
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.3),
                        width: 3,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        style: BorderStyle.solid)),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Text("logout_confirmation".tr,
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              )),
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: size.width * 0.3,
                          height: size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: Text("cancel".tr,
                                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                      color: Theme.of(context).colorScheme.surface,
                                    )),
                          ),
                        ),
                        Container(
                          width: size.width * 0.3,
                          height: size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: ElevatedButton(
                            onPressed: widget.onSubmit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: Text(
                              widget.buttonText.tr,
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.surface,
                                  ),
                            ),
                          ),
                        )
                      ],
                    )),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
