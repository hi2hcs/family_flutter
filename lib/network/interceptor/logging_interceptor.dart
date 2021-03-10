import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';


class LoggingInterceptor extends Interceptor {
  Set<String> ignoredPathList;
  bool shouldPrintHeaders;

  LoggingInterceptor({this.ignoredPathList, this.shouldPrintHeaders = false});

  @override
  Future onRequest(RequestOptions options) {
    if (ignoredPathList == null || !ignoredPathList.contains(options.path)) {
      print(
          "Dio: request: ${options.method} ${options.path} ${options.method.toLowerCase() == 'get' ? options.queryParameters : ''}, ${options.method.toLowerCase() == "get" ? options.headers : json.encode(options.data)}");
      if (options.method.toLowerCase() == "post") {
        print("Dio: headers=${options.headers}");
      }
      if (shouldPrintHeaders) {
        print("Dio: request: ${options.method} ${options.path}, headers=${options.headers.toString()}");
      }
    }
    return Future.value(options);
  }

  @override
  Future onResponse(Response response) {
    if (ignoredPathList == null || !ignoredPathList.contains(response.request.path)) {
      bool isJsonResponse = response.request.responseType == ResponseType.json;
      String jsonString;
      bool isRaw = true;
      if (isJsonResponse) {
        try {
          jsonString = jsonEncode(response.data);
        } catch (e) {
          isRaw = false;
          jsonString = response.data.toString();
        }
      } else {
        jsonString = "RESPONSE CONTENT SKIPPED";
      }
      String logging = "Dio: response: ${response.request.path}, $jsonString, isRaw?$isRaw";
      int counter = (logging.length -1)~/900 +1;
      for(int i=0;i<counter;i++){
        print(logging.substring(i*900, min((i+1)*900, logging.length)));
      }

    }
    return Future.value(response);
  }

  @override
  Future onError(DioError err) async {
    if (ignoredPathList == null || !ignoredPathList.contains(err.request?.path)) {
      print("Dio: ${err.request?.path} error: $err");
    }
    return err;
  }
}
