import 'package:family/color/app_color.dart';
import 'package:family/page/friends_dynamic_page.dart';
import 'package:family/widget/app_web_view.dart';
import 'package:family/widget/app_web_view_bloc.dart';
import 'package:family/widget/horizontalcontent_widget.dart';
import 'package:family/widget/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class FindPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          HorizontalContentWidget(
            icon: Icon(
              Icons.camera,
              color: AppColor.primeColor,
            ),
            label: "朋友圈",
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FriendsDynamicPage(),
                ),
              );
            },
          ),
          Widgets.devider(),
          HorizontalContentWidget(
            icon: Icon(
              Icons.qr_code_outlined,
              color: AppColor.linkBlue,
            ),
            label: "扫一扫",
            onTap: () async {
              const url = 'http://flutter.dev';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                Fluttertoast.showToast(msg: "无法打开浏览器");
              }
            },
          ),
          Widgets.lineNoComplete(EdgeInsets.only(left: 50)),
          HorizontalContentWidget(
            icon: Icon(
              Icons.vibration_outlined,
              color: AppColor.linkBlue,
            ),
            label: "摇一摇",
            onTap: () {},
          ),
          Widgets.devider(),
          HorizontalContentWidget(
            icon: Icon(
              Icons.remove_red_eye_outlined,
              color: Colors.orangeAccent,
            ),
            label: "看一看",
            onTap: () {},
          ),
          Widgets.lineNoComplete(EdgeInsets.only(left: 50)),
          HorizontalContentWidget(
            icon: Icon(
              Icons.stream,
              color: Colors.red,
            ),
            label: "搜一搜",
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => (AppWebView("https://www.baidu.com",
                      LoadUrlType.URL)),
                ),
              );
            },
          ),
          Widgets.devider(),
          HorizontalContentWidget(
            icon: Icon(
              Icons.live_tv,
              color: AppColor.linkBlue,
            ),
            label: "直播",
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(

                  builder: (context) => (AppWebView("https://www.bilibili.com/", LoadUrlType.URL)),
                ),
              );
            },
          ),
          Widgets.devider(),
          HorizontalContentWidget(
            icon: Icon(
              Icons.all_inclusive_rounded,
              color: AppColor.linkBlue,
            ),
            label: "小程序",
            onTap: () {},
          ),
          Expanded(
              child: Container(
            color: AppColor.lightBackgroundColor,
          ))
        ],
      ),
    );
  }
}
