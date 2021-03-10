import 'package:dio/dio.dart';

class SignatureInterceptor extends Interceptor {
  SignatureInterceptor();

  @override
  Future onRequest(RequestOptions options) {
    return Future.value(options);
  }
}
