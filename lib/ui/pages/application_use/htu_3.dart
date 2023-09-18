import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../widgets/button.dart';
import '../../utils/color_constants.dart';

class HowToUseS3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var fontSize = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Positioned(
                // left: size.width * 0.2,
                // bottom: size.height * 0.7,
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/h3_bg_img2.png",
                      width: size.width * 0.8,
                      // height: size.width * 0.8,
                    ),
                    // Add other widgets for this position
                  ],
                ),
              ),
              Positioned(
                right: 0,
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/h3_bg_img1.png",
                      // width: size.width * 1,
                      height: size.width * 1,
                    ),
                    // Add other widgets for this position
                  ],
                ),
              ),
              Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.45,
                          ),
                          Text(
                            "scan_test_strip_timer".tr,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                            maxLines: 4,
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 1),
                                  child: Icon(
                                    FontAwesomeIcons.diamond,
                                    color: Theme.of(context).colorScheme.primary,
                                    size: 15,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: SizedBox(
                                    width: size.width * 0.7,
                                    child: Text(
                                      "wait_till_timer_end".tr,
                                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 1),
                                  child: Icon(
                                    FontAwesomeIcons.diamond,
                                    color: Theme.of(context).colorScheme.primary,
                                    size: 15,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: SizedBox(
                                    width: size.width * 0.7,
                                    child: Text(
                                      "get_glucose_readings".tr,
                                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(
                            flex: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: size.width * 0.4,
                                height: size.height * .06,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: Text(
                                    "back".tr,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                              ),
                              CustomButton(
                                height: size.height * .06,
                                buttonText: 'home'.tr,
                                onPressed: () {
                                  Get.offAllNamed('/home');
                                },
                                width: size.width * 0.4,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
