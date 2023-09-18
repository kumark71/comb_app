import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../widgets/button.dart';
import '../../utils/color_constants.dart';
import 'htu_2.dart';

class HowToUseS1 extends StatelessWidget {
  const HowToUseS1({super.key});

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
                left: size.width * 0.2,
                bottom: size.height * 0.7,
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/h1_bg_img2.png",
                      width: size.width * 0.8,
                      height: size.width * 0.8,
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
                      "assets/images/h1_bg_img1.png",
                      width: size.width * 1,
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
                            "prick_finger".tr,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
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
                                  padding: const EdgeInsets.only(top: 3),
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
                                      "use_new_lancet".tr,
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
                                  padding: const EdgeInsets.only(top: 3),
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
                                      "set_lancet_depth".tr,
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
                                  padding: const EdgeInsets.only(top: 3),
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
                                      "set_lancet_depth".tr,
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
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: CustomButton(
                              height: size.height * .06,
                              buttonText: 'next'.tr,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => HowToUseS2(),
                                  ),
                                );
                              },
                              width: size.width,
                            ),
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
