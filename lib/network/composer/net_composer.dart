import 'package:dio/dio.dart';
import 'package:family/network/composer/net_request_callback.dart';
import 'package:family/util/util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


abstract class NetComposer {
  static Future<T> compose<T>(Future requestFuture, NetRequestCallback<T> callback) async {
    Response response = await requestFuture.catchError((e) {
      // callback.onComplete?.call(false);
      if (callback.showNetworkErrorToast) {
        Fluttertoast.showToast(
            msg: callback.networkErrorToast,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            gravity: callback.centerToast ? ToastGravity.CENTER : ToastGravity.BOTTOM);
      }
      callback.onFailedCode?.call(-1, callback.networkErrorToast);
      return null;
    });

    if (callback.isSuccessful(response)) {
      T t;
      try {
        if (callback.specifiedDataToParse == null) {
          t = callback.parse(response.data['data']);
        } else {
          t = callback.parse(callback.specifiedDataToParse(response));
        }
      } catch (e, s) {
        print("Dio: parsingError: ${response.request?.path},\n${e.toString()} $s");

        callback.onComplete?.call(false);

        return null;
      }
      callback.onComplete?.call(true);
      callback.onSuccess?.call(t);
      return t;
    } else {
      if (callback.onFailedCode != null) {
       // int code = response.data["code"] ?? -2;
        int code = -2;
        String message;
        if(response?.data != null){
          code = response.data["code"] ?? -2;
          message = response.data["msg"];
          if(message == null){
            message = response.data["message"];
          }
        }
        callback.onFailedCode.call(code, message);
      }

      callback.onComplete?.call(false);
      String errorMessage;
      if (response?.data != null &&
          (Util.isNotEmptyString(response.data['msg']) || Util.isNotEmptyString(response.data['message']))) {
        errorMessage = Util.isNotEmptyString(response.data['msg']) ? response.data['msg'] : response.data['message'];
      }
      if (callback.showErrorMessageFromServer && Util.isNotEmptyString(errorMessage)) {
        Fluttertoast.showToast(
            msg: errorMessage,
            backgroundColor:  Colors.red,
            textColor: Colors.white,
            gravity: callback.centerToast ? ToastGravity.CENTER : ToastGravity.BOTTOM);
      }
      return null;
    }
  }
}
