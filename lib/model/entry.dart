import 'dart:convert';

import 'package:family/util/util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entry.g.dart';

@JsonSerializable()
class Entry {
  String content;
  String code;

  Entry({this.content, this.code});

  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);

  Map<String, dynamic> toJson() => _$EntryToJson(this);

  static List<Entry> listFromJson(List jsonList) {
    return Util.isEmptyList(jsonList) ? [] : jsonList.map((e) => Entry.fromJson(e)).toList();
  }

  static List<Map> listToJson(List<Entry> list) {
    return Util.isEmptyList(list) ? [] : list.map((e) => e.toJson()).toList();
  }
}

@JsonSerializable()
class Content {
  @JsonKey(ignore: true)
  static final int min = 60 * 1000;
  @JsonKey(ignore: true)
  static final int hour = 60 * min;
  @JsonKey(ignore: true)
  static final int day = 24 * hour;

  int publish_time;
  UseInfo user_info;
  String display_url;
  String url;

  Content({this.user_info, this.publish_time,this.display_url,this.url});

  String get time {
    String timestr = "";
    if (publish_time == null) {
      return "";
    }
    var dateTime = DateTime.fromMillisecondsSinceEpoch(publish_time);
    var now = DateTime.now();
    var duations = now.compareTo(dateTime);
    if (duations <= min) {
      timestr = "刚刚";
    } else if (duations <= hour) {
      var i = duations / min;
      timestr = "${i.toInt()}分钟前";
    } else if (duations <= day) {
      timestr = "${dateTime.hour}:${dateTime.minute}";
    } else {
      timestr = "${dateTime.month}/${dateTime.day}";
    }
    return timestr;
  }

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonSerializable()
class UseInfo {
  ///user_info
  String avatar_url;
  String name;
  String description;

  UseInfo({this.avatar_url, this.name, this.description});

  factory UseInfo.fromJson(Map<String, dynamic> json) => _$UseInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UseInfoToJson(this);
}
