import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessagePage extends StatefulWidget {
  MessagePageState currentState;
  @override
  State<StatefulWidget> createState() {
    currentState = MessagePageState();
    return currentState;
  }
}

class MessagePageState extends State<MessagePage> with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController = RefreshController();
  bool isFinish = false;
  String title = "xxxxxx";

  @override
  void didUpdateWidget(covariant MessagePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("MessagePage didUpdateWidget...........");
  }

  void refresh() {
    print("refresh...........${isFinish}");
    if (isFinish) {
      setState(() {
        title = "YYYYYY";
      });
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    print("MessagePage reassemble...........");
  }

  @override
  void updateKeepAlive() {
    super.updateKeepAlive();
    print("MessagePage updateKeepAlive...........");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("MessagePage didChangeDependencies...........");
  }

  @override
  void initState() {
    super.initState();
    isFinish = true;
    print("MessagePage initState...........");
  }

  @override
  Widget build(BuildContext context) {
    print("MessagePage build...........");
    return Column(
      children: [
        Expanded(
          child: SmartRefresher(
            enablePullUp: true,
            enablePullDown: true,
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = Text("上拉加载更多");
                } else if (mode == LoadStatus.loading) {
                  body = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(width: 25, height: 25, child: CircularProgressIndicator(strokeWidth: 3)),
                    SizedBox(width: 5),
                    Text('正在加载...')
                  ]);
                } else if (mode == LoadStatus.canLoading) {
                  body = Container();
                } else {
                  body = Text("没有更多数据了...");
                }
                return Container(
                  height: 50.0,
                  child: Center(child: body),
                );
              },
            ),
            onLoading: () {},
            controller: _refreshController,
            child: ListView.builder(
              shrinkWrap: true,
              itemExtent: 100,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  child: Text(title ?? "null"),
                  color: Colors.red,
                  height: 100,
                  margin: EdgeInsets.only(bottom: 1),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
