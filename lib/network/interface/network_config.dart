import 'package:dio/dio.dart';

abstract class NetworkConfig {
  String get baseUrl;

  int get connectTimeout;

  int get receiveTimeout;

  int get sendTimeout;

  ResponseType get responseType;

}
