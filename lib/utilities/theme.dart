import 'package:flutter/material.dart';

class CustomTheme {
  static Color darkBluePrimaryColor = const Color.fromRGBO(53, 88, 205, 1);
  static Color lightGreyBackgroundColor = const Color.fromRGBO(232, 232, 232, 1);
  static Color darkBlueTitleColor = const Color.fromRGBO(22, 26, 51, 1);
  static Color darkGrayTitleColor = const Color.fromRGBO(107, 107, 107, 1);
  static Color lightBlueButtonColor = const Color.fromRGBO(213, 222, 255, 1);

  static List<BoxShadow> defaultCardBoxShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      spreadRadius: 0,
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];
}
