import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hemoqr/controllers/auth_controller.dart';

import '../../utils/color_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController authController = Get.find();
  @override
  void initState() {
    super.initState();

    authController.loadUser();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: size.height,
      width: size.width,
      child: Center(
          child: SizedBox(
              height: size.height * .10,
              width: size.height * .10,
              child: Image(image: AssetImage("assets/images/prepapqr.png")))),
    ));
  }
}
