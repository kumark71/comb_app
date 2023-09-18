import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../utils/color_constants.dart';

class ProcessingPage extends StatefulWidget {
  const ProcessingPage({Key? key}) : super(key: key);

  @override
  State<ProcessingPage> createState() => _ProcessingPageState();
}

class _ProcessingPageState extends State<ProcessingPage> {
  @override
  Widget build(BuildContext context) {
    var textaspt = MediaQuery.of(context).textScaleFactor;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: constraints.maxHeight * 0.05,
                    horizontal: constraints.maxWidth * 0.1,
                  ),
                  child: SizedBox(
                    height: 250,
                    width: 250,
                    child: Image.asset("assets/images/processing.png"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: constraints.maxHeight * 0.01,
                  ),
                  child: Text(
                    "processing_message".tr,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Lottie.asset(
                      height: 30, 'assets/lotties/processing.json'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
