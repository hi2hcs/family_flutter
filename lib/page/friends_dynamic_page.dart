import 'package:family/color/app_color.dart';
import 'package:flutter/cupertino.dart';

class FriendsDynamicPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FriendsDynamicState();
}

class FriendsDynamicState extends State<FriendsDynamicPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primeColor,
    );
  }
}
