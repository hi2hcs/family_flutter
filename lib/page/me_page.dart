import 'package:family/color/app_color.dart';
import 'package:family/contants.dart';
import 'package:family/widget/horizontalcontent_widget.dart';
import 'package:family/widget/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  void initState() {
    print("MePage initState...........");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(Contants.MARGIN_LEFT),
              alignment: Alignment.centerLeft,
              height: 130,
              width: double.infinity,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      child: Image.network(
                          "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=986391830,165024746&fm=26&gp=0.jpg"
                          // "https://sf1-ttcdn-tos.pstatp.com/img/pgc-image/6567094cd4c249a487b66a43cfcd414d~300x300.image"
                          ),
                      height: 60,
                      width: 60,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "钢铁侠",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "账户：110119112",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                  Widgets.forwardIcon(),
                ],
              ),
            ),
          ),
          Widgets.devider(),
          HorizontalContentWidget(
            icon: Icon(
              Icons.cloud_done_outlined,
              color: AppColor.primeColor,
            ),
            label: "支付",
            onTap: () {},
          ),
          Widgets.devider(),
          HorizontalContentWidget(
            icon: Icon(
              Icons.collections_bookmark_outlined,
              color: Colors.cyan,
            ),
            label: "收藏",
            onTap: () {},
          ),
          Widgets.lineNoComplete(EdgeInsets.only(left: 50)),
          HorizontalContentWidget(
            icon: Icon(
              Icons.image_outlined,
              color: AppColor.linkBlue,
            ),
            label: "朋友圈",
            onTap: () {},
          ),
          Widgets.lineNoComplete(EdgeInsets.only(left: 50)),
          HorizontalContentWidget(
            icon: Icon(
              Icons.account_balance_wallet_outlined,
              color: AppColor.linkBlue,
            ),
            label: "卡包",
            onTap: () {},
          ),
          Widgets.lineNoComplete(EdgeInsets.only(left: 50)),
          HorizontalContentWidget(
            icon: Icon(
              Icons.emoji_emotions_outlined,
              color: Colors.orangeAccent,
            ),
            label: "表情",
            onTap: () {},
          ),
          Widgets.devider(),
          HorizontalContentWidget(
            icon: Icon(
              Icons.settings,
              color: AppColor.linkBlue,
            ),
            label: "设置",
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
