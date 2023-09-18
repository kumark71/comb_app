import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/button.dart';
import '../../utils/color_constants.dart';

class OnboardingTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var fontSize = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: Container(
        height: size.height, // Adjust the height as needed
        width: size.width, // Adjust the width as needed

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: size.height * .6,
                width: size.width,
                child: Image.asset(
                  "assets/bg/ob2bg.png",
                  fit: BoxFit.fill,
                )),
            SizedBox(
              height: size.height * .4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          "Screening Anemia with HemoQR: Your First Step towards Better Health",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                          maxLines: 4,
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                        //   child: Text(
                        //     "No need to buy separate reader device, your smart phone is enough to measure your Vaginal Ph",
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .bodySmall
                        //         ?.copyWith(
                        //           // fontSize: fontSize * 15,
                        //           color: Theme.of(context).colorScheme.onPrimary,
                        //         ),
                        //     maxLines: 3,
                        //   ),
                        // ),
                        // Add spacer between text and button
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CustomButton(
                      height: size.height * .06,
                      buttonText: 'Login',
                      onPressed: () {
                        Get.offAllNamed('/loginPersonal');
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
