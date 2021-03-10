import 'package:family/color/app_color.dart';
import 'package:flutter/material.dart';

class TopBar {
  static getAppBar(BuildContext context, String title, {VoidCallback onPressed, VoidCallback onPressedTitle,List<Widget> actions,Widget leading}) {
    return AppBar(
      backgroundColor: AppColor.primeColor,
      elevation: 0,
      title: GestureDetector(
        onTap: onPressedTitle,
        child: Text(
          title,
          textScaleFactor: 1,
          style: TextStyle(fontSize: 17, color: Colors.white),
        ),
      ),
      leading: leading==null?IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: Colors.white,
          ),
          onPressed: () {
            if (onPressed == null) {
              Navigator.pop(context);
            } else {
              onPressed();
            }
          }):leading,
      centerTitle: true,
      actions: actions,
    );
  }
}
