import 'package:flutter/material.dart';

abstract class AppColor {
  static const Color primeColor = Color(0xFFA2C14D);
  static const Color primeColorAccent = Color(0x77A2C14D);
  static const Color textBlack = Color(0xFF494B4D);
  static const Color textHint = Color(0xFFA0A4A7);
  static const Color dividerGray = Color(0xFFE2E5E7);
  static const Color textError = Color(0xFFF04B4B);
  static const Color backgroundColor = Color(0xFFE5E5E5);
  static const Color lightBackgroundColor = Color(0xFFF2F2F2);
  static const Color linkBlue = Color(0xFF4E9FF0);
}

abstract class TeaSize {
  static const double titleTextSize = 17;
}

abstract class TeaStyle {
  static const TextStyle titleTextStyle =
  TextStyle(fontSize: 17, color: AppColor.textBlack);
}