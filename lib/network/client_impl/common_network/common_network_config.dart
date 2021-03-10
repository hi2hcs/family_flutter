import 'package:dio/dio.dart';
import 'package:family/network/interface/network_config.dart';

class CommonNetworkConfig extends NetworkConfig{
  @override
  String get baseUrl => "";

  @override
  int get connectTimeout => 3000;

  @override
  int get receiveTimeout => 3000;

  @override
  ResponseType get responseType => ResponseType.json;

  @override
  int get sendTimeout => 3000;
}