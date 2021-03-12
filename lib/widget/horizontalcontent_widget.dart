import 'package:family/color/app_color.dart';
import 'package:family/widget/widgets.dart';
import 'package:flutter/material.dart';

class HorizontalContentWidget extends StatefulWidget {
  const HorizontalContentWidget({
    Key key,
    @required Widget this.icon,
    @required String this.label,
    VoidCallback this.onTap,
    Widget this.leftWidget,
    Widget this.rightWidget,
  }) : super(key: key);
  final icon;
  final label;
  final leftWidget;
  final rightWidget;
  final onTap;

  @override
  State<StatefulWidget> createState() => HorizontalContentWidgetState();
}

class HorizontalContentWidgetState extends State<HorizontalContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        child: InkWell(
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap();
            }
          },
          splashColor: AppColor.dividerGray,
          child: Container(
            height: 55,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                widget.icon ?? Container(),
                Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    widget.label ?? "",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                (widget.leftWidget ?? Container()),
                Expanded(child: Container()),
                (widget.rightWidget ?? Container()),
                Widgets.forwardIcon(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
