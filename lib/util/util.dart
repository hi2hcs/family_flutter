import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class Util {
  static RegExp _ipRegExp = RegExp(r"^((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$");

  static int lengthOfString(String string) => (string?.length ?? 0);

  static int lengthOfList(List list) => (list?.length ?? 0);

  static bool isEmptyString(String string) => lengthOfString(string) == 0;

  static bool isEmptyList(List list) => lengthOfList(list) == 0;

  static bool isNotEmptyList(List list) => lengthOfList(list) > 0;

  static bool isNotEmptyString(String string) => lengthOfString(string) > 0;

  static bool isValidIpAddress(String ipAddress) => isNotEmptyString(ipAddress) && _ipRegExp.hasMatch(ipAddress);

  static bool isValidPrinterAddress(String address) =>
      isNotEmptyString(address) && (_ipRegExp.hasMatch(address) || address.toLowerCase() == "usb");

  /// null or valid error message
  static String getErrorMessage(Response response) {
    if (response == null ||
        response.data == null ||
        [200, 0].contains(response.data['code']) &&
            (isEmptyString(response.data['message']) && isEmptyString(response.data['msg']))) {
      return null;
    }
    return isNotEmptyString(response.data['message']) ? response.data['message'] : response.data['msg'];
  }

  static String listToFriendlyString(List<dynamic> list, {String divider = ", "}) {
    StringBuffer buffer = StringBuffer("");
    if (isNotEmptyList(list)) {
      for (int i = 0; i < list.length; i++) {
        buffer.write(list[i].toString());
        if (i < list.length - 1) {
          buffer.write(divider);
        }
      }
    }
    return buffer.toString();
  }

  static String getPhoneSuffix(String phone) {
    return isEmptyString(phone) ? "-" : phone.substring(phone.length - 4, phone.length);
  }

  static bool isValidPassword(String password) {
    if (lengthOfString(password) < 8 || lengthOfString(password) > 16) {
      return false;
    }

    int matcher1 = _containsDigit(password) ? 1 : 0;
    int matcher2 = _containsCapitalLetter(password) ? 1 : 0;
    int matcher3 = _containsLetter(password) ? 1 : 0;
    int matcher4 = _isLetterDigit(password) ? 0 : 1;

    int sum = 0;
    sum = matcher1 + matcher2 + matcher3 + matcher4;

    return sum >= 2;
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static bool _isLetterDigit(String str) {
    RegExp regex = RegExp(r"^[a-z0-9A-Z]+$");
    return regex.hasMatch(str);
  }

  static bool _containsCapitalLetter(String str) {
    return RegExp(r"[A-Z]+").hasMatch(str);
  }

  static bool _containsLetter(String str) {
    return RegExp(r"[a-z]+").hasMatch(str);
  }

  static bool _containsDigit(String str) {
    return RegExp(r"[0-9]+").hasMatch(str);
  }

  static bool containsOnlyDigits(String str){
    return RegExp(r"^[0-9]+$").hasMatch(str);
  }
}
