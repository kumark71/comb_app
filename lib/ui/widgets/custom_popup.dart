import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../utils/color_constants.dart';

class CustomPopup extends StatefulWidget {
  final String message;

  final VoidCallback onYesPressed;
  final VoidCallback onNoPressed;

  const CustomPopup({
    Key? key,
    required this.message,
    required this.onYesPressed,
    required this.onNoPressed,
  }) : super(key: key);

  @override
  CustomPopupState createState() => CustomPopupState();
}

class CustomPopupState extends State<CustomPopup> with SingleTickerProviderStateMixin {
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
              var textaspt = MediaQuery.of(context).textScaleFactor;
              return Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(15.0),
                height: size.height * 0.18,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.onPrimary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 3,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        style: BorderStyle.solid)),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        widget.message.toString(),
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              fontSize: textaspt * 15,
                              color: Colors.white,
                            ),
                      ),
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
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          child: ElevatedButton(
                            onPressed: widget.onNoPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: Text(
                              "no".tr,
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontSize: textaspt * 15,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.3,
                          height: size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          child: ElevatedButton(
                            onPressed: widget.onYesPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: Text(
                              "yes".tr,
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontSize: textaspt * 15,
                                    color: Theme.of(context).colorScheme.onSurface,
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
