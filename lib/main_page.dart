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
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColor.primeColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "信息"),
          BottomNavigationBarItem(icon: Icon(Icons.near_me_outlined), label: "发现"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "我"),
        ],
        onTap: (index) {
          controller.animateToPage(index, duration: Duration(milliseconds: 200), curve: SawTooth(index));
          // controller.jumpToPage(index);
          setState(() {
            currentindex = index;
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
          alignment: Alignment.center,
          child: Text("${index}"),
        );
      case 1:
        return Container(
          alignment: Alignment.center,
          child: Text("${index}"),
        );
        break;
      case 2:
        return Container(
          alignment: Alignment.center,
          child: Text("${index}"),
        );
        break;
      default:
        return Container(
          alignment: Alignment.center,
          child: Text("${index}"),
        );
        break;
    }
  }
}
