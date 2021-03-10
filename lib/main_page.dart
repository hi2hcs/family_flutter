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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar.getAppBar(context, "Family", leading: Container()),
      body: SafeArea(
        child: PageView.builder(itemBuilder: (context,index){
          return Container();
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColor.primeColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "信息"),
          BottomNavigationBarItem(icon: Icon(Icons.near_me_outlined), label: "发现"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "我"),
        ],
        onTap: (index) {
          setState(() {
            currentindex = index;
          });
        },
        currentIndex: currentindex,
      ),
    );
  }
}
