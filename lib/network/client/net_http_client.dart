import 'package:dio/dio.dart';
import 'package:family/network/interceptor/token_checking_interceptor.dart';
import 'package:family/network/interface/network_config.dart';
import 'package:flutter/material.dart';

abstract class NetHttpClient {
  Dio _dio = Dio();

  NetHttpClient() {
    BaseOptions options = BaseOptions(
      baseUrl: networkConfig.baseUrl,
      connectTimeout: networkConfig.connectTimeout,
      receiveTimeout: networkConfig.receiveTimeout,
      sendTimeout: networkConfig.sendTimeout,
      responseType: networkConfig.responseType,
    );
    _dio = Dio();
    _dio.options = options;
//    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
//      // config the http client
//      client.findProxy = (uri) {
//        //proxy all request to localhost:8888
//        return "PROXY 192.168.5.199:8888";
//      };
//      // you can also create a HttpClient to dio
//      // return HttpClient();
//    };
    _dio.interceptors.add(TokenCheckingInterceptor());
    _dio.interceptors.addAll(interceptors);
  }

  Dio get dio {
    return _dio;
  }

  @protected
  List<Interceptor> get interceptors;

  @protected
  NetworkConfig get networkConfig;
}
