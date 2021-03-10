import 'package:dio/dio.dart';


class TokenHeaderInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) {
    // options.headers.addAll({"Authorization": UserBloc.token});
    return Future.value(options);
  }
}
