import 'package:family/color/app_color.dart';
import 'package:family/page/find_page.dart';
import 'package:family/page/me_page.dart';
import 'package:family/page/message_page.dart';
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
  String title = "信息";
  PageController controller = PageController();
  MessagePage messagePage;
  Widget findePage;
  Widget mePage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar.getAppBar(context, title, leading: Container()),
      body: SafeArea(
        child: PageView.builder(
          controller: controller,
          itemCount: 3,
          itemBuilder: (context, index) {
            return _page(context, index);
          },
          onPageChanged: (index) {
            setState(() {
              print("......onPageChanged.......$index");
              currentindex = index;
              num = index;
              setTitle(index);
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
            setTitle(index);
            print("......setTitle.......$index");
          });
        },
        currentIndex: currentindex,
      ),
    );
  }

  void setTitle(int index) {
    if (index == 0) {
      title = "信息";
    } else if (index == 1) {
      title = "发现";
    } else {
      title = "我";
    }
  }

  Widget _page(BuildContext context, int index) {
    switch (index) {
      case 0:
        print(".............0");
        if (messagePage == null) {
          messagePage = MessagePage();
        }
        if(currentindex==0){
          messagePage.currentState?.refresh();
        }
        return messagePage;
        break;
      case 1:
        print(".............1");
        if (findePage == null) {
          findePage = FindPage();
        }
        return findePage;
        break;
      case 2:
        print(".............2");
        if (mePage == null) {
          mePage = MePage();
        }
        return mePage;
        break;
      // default:
      //   if (messagePage == null) {
      //     messagePage = MessagePage();
      //   }
      //   return messagePage;
    }
  }

  @override
  void dispose() {
    messagePage = null;
    findePage = null;
    mePage = null;
    super.dispose();
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
