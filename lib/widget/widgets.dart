import 'package:family/color/app_color.dart';
import 'package:family/contants.dart';
import 'package:flutter/material.dart';

class Widgets {
  static Widget forwardIcon() {
    return Icon(
      Icons.arrow_forward_ios_rounded,
      size: 16,
      color: AppColor.textHint,
    );
  }

  static Widget devider() {
    return Container(
      height: Contants.DIVIDE,
      color: AppColor.lightBackgroundColor,
    );
  }

  static Widget line() {
    return Container(
      height: Contants.LINE_HEIGHT,
      color: AppColor.lightBackgroundColor,
    );
  }

  static Widget lineNoComplete(EdgeInsetsGeometry margin) {
    return Container(
      margin: margin ?? EdgeInsets.all(0),
      height: Contants.LINE_HEIGHT,
      color: AppColor.lightBackgroundColor,
    );
  }
}
