// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entry _$EntryFromJson(Map<String, dynamic> json) {
  return Entry(
    content: json['content'] as String,
    code: json['code'] as String,
  );
}

Map<String, dynamic> _$EntryToJson(Entry instance) => <String, dynamic>{
      'content': instance.content,
      'code': instance.code,
    };

Content _$ContentFromJson(Map<String, dynamic> json) {
  return Content(
    user_info: json['user_info'] == null
        ? null
        : UseInfo.fromJson(json['user_info'] as Map<String, dynamic>),
    publish_time: json['publish_time'] as int,
    display_url: json['display_url'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'publish_time': instance.publish_time,
      'user_info': instance.user_info,
      'display_url': instance.display_url,
      'url': instance.url,
    };

UseInfo _$UseInfoFromJson(Map<String, dynamic> json) {
  return UseInfo(
    avatar_url: json['avatar_url'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$UseInfoToJson(UseInfo instance) => <String, dynamic>{
      'avatar_url': instance.avatar_url,
      'name': instance.name,
      'description': instance.description,
    };
