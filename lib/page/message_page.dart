import 'dart:convert';

import 'package:family/color/app_color.dart';
import 'package:family/contants.dart';
import 'package:family/network/client_impl/common_network/common_service.dart';
import 'package:family/network/composer/net_composer.dart';
import 'package:family/network/composer/net_request_callback.dart';
import 'package:family/page/app_web_view.dart';
import 'package:family/page/app_web_view_bloc.dart';
import 'package:family/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:family/model/entry.dart';

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
  List<Content> currentList = [];

  void refresh() {
    if (isFinish) {
      print("refresh...");
      NetComposer.compose(
        CommonService.news(),
        NetRequestCallback<List<Entry>>(
            parse: (data) {
              return Entry.listFromJson(data);
            },
            onSuccess: (data) {
              var list = data.map((e) => Content.fromJson(json.decode(e.content)))?.toList();
              if (Util.isNotEmptyList(list)) {
                setState(() {
                  _refreshController.refreshCompleted();
                  currentList = list;
                });
              }
            },
            onComplete: (isSuccess) {}),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    isFinish = true;
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SmartRefresher(
            enablePullUp: false,
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
            onRefresh: () {
              refresh();
            },
            onLoading: () {},
            controller: _refreshController,
            child: ListView.builder(
              shrinkWrap: true,
              itemExtent: 81,
              itemCount: (currentList?.length ?? 0),
              itemBuilder: (context, index) {
                return buildItems(context, index);
              },
            ),
          ),
        )
      ],
    );
  }

  Widget buildItems(BuildContext context, int index) {
    String time = currentList[index]?.time;
    // String httpurl = currentList[index]?.display_url ?? "";
    String httpurl = currentList[index]?.url ?? "";
    UseInfo info = currentList[index]?.user_info;
    String name = info?.name ?? "xxx_$index";
    String desc = info?.description ?? "desc_$index";
    String url = info?.avatar_url ??
        "https://sf1-ttcdn-tos.pstatp.com/img/pgc-image/6567094cd4c249a487b66a43cfcd414d~300x300.image";
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: Contants.MARGIN_LEFT),
            height: 80,
            child: Row(
              children: [
                ClipRRect(
                  child: Container(
                    child: Image.network(
                      url,
                      cacheHeight: 120,
                      cacheWidth: 120,
                    ),
                    width: 60,
                    height: 60,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 230),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        desc,
                        style: TextStyle(fontSize: 14, color: AppColor.textHint),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        time,
                        style: TextStyle(fontSize: 13, color: AppColor.textHint),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Icon(
                        Icons.notifications_none_outlined,
                        size: 16,
                        color: AppColor.textHint,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 1,
            margin: EdgeInsets.only(left: 85),
            color: AppColor.dividerGray,
          )
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => (AppWebView(httpurl, LoadUrlType.URL)),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
