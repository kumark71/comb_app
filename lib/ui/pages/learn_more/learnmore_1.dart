import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LM1 extends StatefulWidget {
  const LM1({super.key});

  @override
  State<LM1> createState() => _LM1State();
}

class _LM1State extends State<LM1> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var fontSize = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * .007,
              width: size.width,
              child: ListView.separated(
                itemCount: 5,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: size.width * .05,
                  );
                },
                itemBuilder: (context, index) {
                  return Container(
                    // height: size.height * .005,
                    width: size.width * .15,
                    decoration: BoxDecoration(
                      color: index == 0 ? Theme.of(context).colorScheme.primary : Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: SizedBox(
                  height: size.height * .4,
                  child: Image.asset(
                    "assets/learnmore/image1.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * .3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "lets_begin".tr,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    height: size.height * .04,
                    child: Row(
                      children: [
                        Text(
                          "your".tr,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6),
                          child: SizedBox(
                            child: Image.asset("assets/learnmore/healthqr.png"),
                          ),
                        ),
                        Text(
                          "journey".tr,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "to_get_accurate_results".tr,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "test_strip_should_be".tr,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        TextSpan(
                          text: "scanned_by_vertically_aligned_strip".tr,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        TextSpan(
                          text: "in_the_bounding_box".tr,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                        )
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "the_application".tr,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        TextSpan(
                          text: "should_accurately_display_mid_height_strip".tr,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        TextSpan(
                          text: "and".tr,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        TextSpan(
                          text: "background_should_be_white".tr,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed("/lm2");
                  },
                  child: SizedBox(
                    height: size.height * .06,
                    // width: size.width * .05,
                    child: Image.asset(
                      "assets/learnmore/next.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
