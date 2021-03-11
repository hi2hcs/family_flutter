import 'package:family/color/app_color.dart';
import 'package:family/widget/app_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int currentindex = 0;
  int num = 0;
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar.getAppBar(context, "Family", leading: Container()),
      body: SafeArea(
        child: PageView.builder(
          controller: controller,
          itemCount: 3,
          itemBuilder: (context, index) {
            return _page(context, index);
          },
          onPageChanged: (index) {
            setState(() {
              currentindex = index;
              num = index;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColor.primeColor,
        items: [
          BottomNavigationBarItem(
              icon: IconWithRedPoint(iconData: Icons.messenger_outline, num: num),
              label: "信息",
              activeIcon: IconWithRedPoint(iconData: Icons.messenger, num: num)),
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: "发现", activeIcon: Icon(Icons.explore)),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "我", activeIcon: Icon(Icons.person)),
        ],
        onTap: (index) {
          // controller.animateToPage(index, duration: Duration(milliseconds: 200), curve: ElasticInCurve(0.2));
          controller.jumpToPage(index);
          setState(() {
            currentindex = index;
            num = index;
          });
        },
        currentIndex: currentindex,
      ),
    );
  }

  Widget _page(BuildContext context, int index) {
    switch (index) {
      case 0:
        return Container(
          color: Colors.red,
          alignment: Alignment.center,
          child: Text("${index}"),
        );
      case 1:
        return Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: Text("${index}"),
        );
        break;
      case 2:
        return Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text("${index}"),
        );
        break;
      default:
        return Container(
          color: Colors.red,
          alignment: Alignment.center,
          child: Text("${index}"),
        );
        break;
    }
  }
}

class IconWithRedPoint extends StatelessWidget {
  const IconWithRedPoint({Key key, @required this.iconData, @required this.num}) : super(key: key);

  final int num;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(iconData),
        Visibility(
            visible: ((num ?? 0) != 0),
            child: Container(
              margin: EdgeInsets.only(left: 10),
              alignment: Alignment.center,
              width: 14,
              height: 14,
              child: Text(
                "${num ?? 0}",
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: Colors.red),
            ))
      ],
    );
  }
}
