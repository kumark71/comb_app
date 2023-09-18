import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/color_constants.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        color: Theme.of(context).colorScheme.primary,
                        icon: Icon(Icons.arrow_back_ios_new),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "faq".tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: quotes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: _buildExpandableTile(quotes[index])),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableTile(item) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        collapsedIconColor: Theme.of(context).colorScheme.surface,
        iconColor: Theme.of(context).colorScheme.surface,
        title: Text(
          item['question'],
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.surface,
              fontWeight: FontWeight.bold),
        ),
        children: <Widget>[
          ListTile(
            title: Text(
              item['ans'],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.surface,
                  ),
            ),
          )
        ],
      ),
    );
  }

  final List quotes = [
    {
      "ans":
          "Pre-PapQR consist of a test strip and a mobile application which provides tests for the detection of vaginal Ph.",
      "question": "What is Pre-PapQR ?"
    },
    {
      "ans": '''
    • Pre-PapQR consists of a test strip and a mobile application which provides tests for the detection of vaginal Ph.\n
    • Dispose of the test if the pouch is open or the test pad changes from yellow to any other colour.\n
    • Avoid touching the test pad or swab tip with bare hands or any other substance.\n
    • Use each test strip once; do not reuse.\n
    • High humidity and temperature can impact results so use the test right after removing it from the pouch.\n
    • Use a white background while scanning the test strip.\n
    • Avoid scanning the test strip in sunlight.\n
    • Keep the mobile phone stable and avoid shaking while scanning the test strip in the mobile application.\n
  ''',
      "question":
          "What are the Precautions to be taken while performing the test ?"
    },
    {
      "ans":
          '''Blurry images can lead to inaccurate object detection and, consequently, incorrect pH readings.''',
      "question": "Can I use blurr image to get results?"
    },
    {
      "ans":
          '''A clear and unobstructed white background is essential for accurate readings. Any objects in the background can lead to incorrect results.''',
      "question": "What should be the background behind the test strip?"
    },
    {
      "ans":
          '''The strip needs to be fully inside the bounding box, and the corners should match for accurate readings. This means that the strip should be well-aligned with the bounding box.s''',
      "question": "How should the strip placed ?"
    },
    {
      "ans":
          '''The strip needs to be fully inside the bounding box, and the corners should match for accurate readings. This means that the strip should be well-aligned with the bounding box.s''',
      "question": "How should the strip placed ?"
    },
  ];
}
