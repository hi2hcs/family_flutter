import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NetRequestCallback<@required T> {
  final bool showNetworkErrorToast;

  final String networkErrorToast;

  final Iterable<int> successCode;

  bool isSuccessful(Response response) {
    return response?.statusCode == 200 &&
        response.data != null &&
        ///暂时注释掉
        // (successCode.contains(response.data['code'])) &&
        additionalCheck(response);
  }

  bool Function(Response response) additionalCheck;
  final bool showErrorMessageFromServer;
  @Deprecated("")
  final Function(bool isSuccessful) onComplete;
  final Function(int code, String message) onFailedCode;
  final Function(T data) onSuccess;
  final T Function(dynamic data) parse;
  final dynamic Function(Response response) specifiedDataToParse;
  final bool centerToast;

  static bool _defaultAdditionalCheck(Response response) => true;

  NetRequestCallback(
      {this.onComplete,
      this.onSuccess,
      @required this.parse,
      this.showErrorMessageFromServer = true,
      this.additionalCheck = _defaultAdditionalCheck,
      this.successCode = const [200, 0],
      this.networkErrorToast = "网络连接失败，请检查网络后重试",
      this.showNetworkErrorToast = true,
      this.onFailedCode,
      this.centerToast = false,
      this.specifiedDataToParse});
}
