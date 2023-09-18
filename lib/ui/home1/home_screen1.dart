import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';
import 'package:hemoqr/controllers/local_controller.dart';
import 'package:hemoqr/controllers/reports_controller.dart';
import 'package:upgrader/upgrader.dart';

class Home1 extends StatefulWidget {
  const Home1({Key? key});

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  AuthController authController = Get.find();
  bool isMaleSelected = false;
  bool isFemaleSelected = false;

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    LocaleController localeController = Get.find();
    Size size = MediaQuery.of(context).size;
    // var fontSize = MediaQuery.of(context).textScaleFactor;
    return WillPopScope(
        onWillPop: () => onWillPop(context),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: UpgradeAlert(
            upgrader: Upgrader(
              durationUntilAlertAgain: const Duration(milliseconds: 1),
              dialogStyle: Platform.isIOS
                  ? UpgradeDialogStyle.cupertino
                  : UpgradeDialogStyle.material,
              canDismissDialog: false,
              showIgnore: false,
              showLater: false,
              shouldPopScope: () => false,
            ),
            child: Obx(
              () => Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top,
                  bottom: MediaQuery.of(context).viewPadding.bottom,
                  right: size.width * .02,
                  left: size.width * .02,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: size.height * .05,
                          horizontal: size.width * .05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${'hi'.tr},',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                              Text(
                                "${authController.name.toString().split(" ")[0]}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: PopupMenuButton(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  icon: Icon(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    Icons.translate_rounded,
                                  ),
                                  onSelected: (value) {
                                    localeController.changeLocale(value);
                                  },
                                  itemBuilder: (context) {
                                    return localeController.avalableLocales;
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed("/profile");
                                },
                                child: authController.profilePic != ""
                                    ? CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        backgroundImage: NetworkImage(
                                          authController.profilePic.value,
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        child: Icon(
                                          Icons.person,
                                          size: 30,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (authController.isProfessional == true) {
                                    Get.toNamed("/patientdetails");
                                  } else {
                                    Get.toNamed('/qrscanner');
                                  }
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image: AssetImage(
                                              "assets/banner/takereadingcard.png",
                                            ),
                                            fit: BoxFit.fill,
                                          )),
                                      height: size.height * .22,
                                      width: size.width * 12,
                                    ),
                                    Positioned(
                                        top: size.height * 0.04,
                                        left: size.width * 0.05,
                                        child: SizedBox(
                                          width: size.width * 0.4,
                                          child: Text(
                                            "start_screening".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.width * .05,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),

                              GestureDetector(
                                onTap: () {
                                  Get.toNamed("/reports");
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image: AssetImage(
                                              "assets/banner/reportscard.png",
                                            ),
                                            fit: BoxFit.fill,
                                          )),
                                      height: size.height * .22,
                                      width: size.width * 12,
                                    ),
                                    Positioned(
                                        top: size.height * 0.04,
                                        left: size.width * 0.05,
                                        child: SizedBox(
                                          width: size.width * 0.4,
                                          child: Text(
                                            "screening_reports".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: size.width * .05,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surface,
                                                ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed("/lm1");
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "assets/banner/howtouse.png",
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      height: size.height * .22,
                                      width: size.width * .98,
                                    ),
                                    Positioned(
                                        top: size.height * 0.06,
                                        left: size.width * 0.05,
                                        child: SizedBox(
                                          width: size.width * 0.4,
                                          child: Text(
                                            "learn_more".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: size.width * .05,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surface,
                                                ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<bool> onWillPop(context) async {
    return (await showDialog(
        context: context,
        builder: (_) => Dialog(
              onSubmit: () => Navigator.of(context).pop(true),
              text: "Logout",
              buttonText: "log_out",
            )));
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: Text('Are you sure?'),
    //     content: Text(

    //     ),
    //     actions: <Widget>[
    //       TextButton(
    //         onPressed: () => Navigator.of(context).pop(false),
    //         child: Text('No'),
    //       ),
    //       TextButton(
    //         onPressed: () => Navigator.of(context).pop(true),
    //         child: Text('Yes'),
    //       ),
    //     ],
    //   ),
    // )) ??
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
                    color: Theme.of(context).colorScheme.secondary,
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.3),
                        width: 3,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        style: BorderStyle.solid)),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Text('Do you want to exit the App',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.surface,
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
                            onPressed: () => Navigator.of(context).pop(false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: Text("No",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.surface,
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
                              "Yes",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.surface,
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
