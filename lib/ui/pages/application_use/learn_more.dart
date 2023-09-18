import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LearnMore extends StatefulWidget {
  const LearnMore({super.key});

  @override
  State<LearnMore> createState() => _LearnMoreState();
}

class _LearnMoreState extends State<LearnMore> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> guideItems = [
      {
        'title': 'understanding_vaginal_ph'.tr,
        'image': 'assets/images/learnmore/1.png'
      },
      {
        'title': 'unveiling_the_basics'.tr,
        'image': 'assets/images/learnmore/2.png'
      },
      {
        'title': 'the_science_behind_balance'.tr,
        'image': 'assets/images/learnmore/3.png'
      },
      {
        'title': 'getting_to_know_your_body'.tr,
        'image': 'assets/images/learnmore/4.png'
      },
      {
        'title': 'preventive_benefits_of_regular_screening'.tr,
        'image': 'assets/images/learnmore/5.png'
      },
      {
        'title': 'navigating_a_ph_conscious_lifestyle'.tr,
        'image': 'assets/images/learnmore/6.png'
      },
    ];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "learn_more".tr,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              Expanded(
                // Wrap the ListView.builder with Expanded
                child: ListView.builder(
                  itemCount: guideItems.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          minLeadingWidth: 100,
                          contentPadding: EdgeInsets.all(20),
                          title: Text(
                            guideItems[index]['title']!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                          leading: SizedBox(
                            child: Image.asset(
                              guideItems[index]['image']!,
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 0.5,
                        )
                      ],
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
}
