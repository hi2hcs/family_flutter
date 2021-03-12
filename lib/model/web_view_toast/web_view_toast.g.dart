// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_view_toast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebViewToast _$WebViewToastFromJson(Map<String, dynamic> json) {
  return WebViewToast(
    content: json['content'] as String,
    bottom: json['bottom'] as int,
    error: json['error'] as int,
    long: json['long'] as int,
  );
}

Map<String, dynamic> _$WebViewToastToJson(WebViewToast instance) =>
    <String, dynamic>{
      'content': instance.content,
      'bottom': instance.bottom,
      'error': instance.error,
      'long': instance.long,
    };
