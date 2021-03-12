import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'web_view_toast.g.dart';

@JsonSerializable()
class WebViewToast{
  String content;
  int bottom;
  int error;
  int long;

  WebViewToast({this.content, this.bottom, this.error, this.long});

  factory WebViewToast.formJson(Map<String, dynamic> json)=> _$WebViewToastFromJson(json);

}