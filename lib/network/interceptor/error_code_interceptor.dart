import 'package:dio/dio.dart';

class ErrorCodeInterceptor extends Interceptor {
  @override
  Future onResponse(Response response) {
    return Future.value(response);
  }
}
