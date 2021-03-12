import 'package:family/color/app_color.dart';
import 'package:family/model/web_view_toast/web_view_toast.dart';
import 'package:family/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebViewBloc extends Bloc<AppWebViewEvent, AppWebViewState> {
  AppWebViewBloc(AppWebViewState initialState) : super(initialState) {
    _currentState = initialState;
    add(_InitialEvent());
  }

  AppWebViewState _currentState;
  WebViewController _webViewController;

  set webViewController(value) {
    _webViewController = value;
  }

  @override
  Stream<AppWebViewState> mapEventToState(AppWebViewEvent event) async* {
    if (event is _InitialEvent) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      _currentState.packageInfo = packageInfo;
      yield _currentState.copy();
      return;
    }
    if (event is AppWebViewTitleUpdateEvent) {
      String title = event.title;
      if (Util.isNotEmptyString(title)) {
        if (title.startsWith("\"") && title.endsWith("\"")) {
          title = title.substring(1, title.length - 1);
        }
        _currentState.title = title;
        yield _currentState.copy();
      }
      return;
    }

    // if (event is TeaWebViewOnRequestUserInfoEvent) {
    //   _webViewController
    //       .evaluateJavascript(
    //           "flutterUserInfoResponse(${GlobalBlocs.get<UserBloc>(UserBloc.blocName).state.userInfo.systemUser.toJsonString()})")
    //       .catchError((e, s) {});
    //   return;
    // }

    if (event is AppWebViewScanCodeEvent) {
      _currentState.openScanCodePage = true;
      yield _currentState.copy();
      _currentState.openScanCodePage = false;
      return;
    }

    // if (event is TeaWebViewOnTokenInvalidEvent) {
    //   GlobalBlocs.get(UserBloc.blocName).add(UserLogoutEvent());
    //   return;
    // }

    if (event is AppWebViewToastEvent) {
      var toastLength = event.data.long ?? 1 == 1 ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT;
      var toastGravity = event.data.bottom ?? 1 == 1 ? ToastGravity.BOTTOM : ToastGravity.CENTER;
      var toastColor = event.data.error ?? 0 == 1 ? AppColor.textError : AppColor.primeColor;
      Fluttertoast.showToast(
          msg: event.data.content,
          toastLength: toastLength,
          gravity: toastGravity,
          backgroundColor: toastColor,
          textColor: Colors.white);
      return;
    }

    if (event is AppWebViewImagePickerEvent) {
      _currentState.showImagePickerDialog = true;
      yield _currentState.copy();
      _currentState.showImagePickerDialog = false;
      return;
    }
  }
}

class _InitialEvent extends AppWebViewEvent {}

class AppWebViewToastEvent extends AppWebViewEvent {
  final WebViewToast data;

  AppWebViewToastEvent(this.data);
}

class AppWebViewOnTokenInvalidEvent extends AppWebViewEvent {}

class AppWebViewOnRequestUserInfoEvent extends AppWebViewEvent {}

class AppWebViewImagePickerEvent extends AppWebViewEvent {}

class AppWebViewScanCodeEvent extends AppWebViewEvent {}

class AppWebViewTitleUpdateEvent extends AppWebViewEvent {
  String title;

  AppWebViewTitleUpdateEvent(this.title);
}

abstract class AppWebViewEvent {}

class AppWebViewState {
  String title = "";
  bool showImagePickerDialog = false;
  bool openScanCodePage = false;
  PackageInfo packageInfo;

  AppWebViewState copy() {
    AppWebViewState newState = AppWebViewState();
    newState.title = title;
    newState.packageInfo = packageInfo;
    newState.openScanCodePage = openScanCodePage;
    newState.showImagePickerDialog = showImagePickerDialog;
    return newState;
  }
}

enum LoadUrlType {
  URL,
  OTHER,
}
