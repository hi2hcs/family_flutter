import 'package:dio/dio.dart';
import 'package:family/network/interface/network_config.dart';


class DownloaderNetworkConfig extends NetworkConfig{
  @override
  String get baseUrl => null;

  @override
  int get connectTimeout => 3000;

  @override
  int get receiveTimeout => 7000;

  @override
  ResponseType get responseType => ResponseType.stream;

  @override
  int get sendTimeout => 3000;
}