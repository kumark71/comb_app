import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/button.dart';
import '../../utils/color_constants.dart';

import 'onboarding_2.dart';

class OnboardingOne extends StatelessWidget {
  const OnboardingOne({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var fontSize = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: size.height * .5,
              width: size.width,
              child: Image.asset(
                "assets/bg/ob1bg.png",
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: size.height * .4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        AutoSizeText(
                          "Anemia screening tool",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                // fontSize: fontSize * 30,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CustomButton(
                      height: size.height * .06,
                      buttonText: 'Next',
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => OnboardingTwo(),
                          ),
                        );
                      },
                      width: size.width,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
