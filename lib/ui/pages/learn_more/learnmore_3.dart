import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LM3 extends StatefulWidget {
  const LM3({super.key});

  @override
  State<LM3> createState() => _LM3State();
}

class _LM3State extends State<LM3> {
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
                      color: index == 0 || index == 1 || index == 2
                          ? Theme.of(context).colorScheme.primary
                          : Color(0xFFD9D9D9),
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
                    "assets/learnmore/image3.png",
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
                    "Rescan Strip!",
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
                          "Your",
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
                          "journey.",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Warning :",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Dont scan the strip's ",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        TextSpan(
                          text: "reaction pad close up or part of strip, ",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        TextSpan(
                          text: "complete strip should be scanned",
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: SizedBox(
                        height: size.height * .06,
                        // width: size.width * .05,
                        child: Image.asset(
                          "assets/learnmore/previous.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * .05,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/lm4");
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
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
