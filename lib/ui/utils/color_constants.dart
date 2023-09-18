import 'package:flutter/material.dart';

class ColorConstant {
  static const Color primaryColor = Color(0xFF123456);
  static const Color white = Colors.white;
  static const Color secondaryColor = Color(0xFF789ABC);
  static const Color accentColor = Color(0xFFDEF123);
  static const Color textColor = Color(0xFF000000);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static Color textfieldbgColor = Colors.grey.withOpacity(0.2);
  static Color cardBgColor = Colors.white.withOpacity(0.1);
  static const Color avtarbgColor = Color(0xff70B7C4);
  static const Color createAccount = Color(0xff4833DA);
  static const Color black = Colors.black;
  static const Color buttonColor = Color(0xff107887);
  static const Color iconColor = Color(0xff66EAFD);
  static const Color fontColor = Color(0xff677299);
  static const Color borderColor = Color(0xff6EC2D3);

  static const Color whiteA700 = Color(0xffffff);
  //Colors for BackgroundGradient
  static const Color gradientColor1 = Color(0xff005F85);
  static const Color gradientColor2 = Color(0xff18C6DC);

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [gradientColor1, gradientColor2],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Colors for ButtonGradient
  static const Color buttonGradientColor1 = Color(0xff1E6AE1);
  static const Color buttonGradientColor2 = Color(0xff5D14D4);
  static const LinearGradient buttonGradient = LinearGradient(
    colors: [buttonGradientColor1, buttonGradientColor2],
  );
}
