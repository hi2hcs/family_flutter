import 'dart:convert';
import 'dart:convert' as convert;

import 'package:family/color/app_color.dart';
import 'package:family/model/web_view_toast/web_view_toast.dart';
import 'package:family/util/util.dart';
import 'package:family/widget/app_web_view_bloc.dart';
import 'package:family/widget/qrcode_reader_view.dart';
import 'package:family/widget/show_picture_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebView extends StatefulWidget {
  final String initialUrl;
  final LoadUrlType type;

  AppWebView(this.initialUrl, this.type, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  AppWebViewBloc _bloc;
  WebViewController _webViewController;
  Set<JavascriptChannel> _javaScriptChannels;

  @override
  void initState() {
    super.initState();
    _javaScriptChannels = _getJavaScriptChannels();
    _bloc = AppWebViewBloc(AppWebViewState());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppWebViewBloc, AppWebViewState>(
      cubit: _bloc,
      builder: (context, state) {
        return WillPopScope(
          // ignore: missing_return
          onWillPop: () => goBack(context),
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, size: 20),
                onPressed: () => goBack(context),
              ),
              title: Text(
                state.title,
                style: AppStyle.titleTextStyle,
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.close, size: 25),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            body: state.packageInfo == null
                ? Container()
                : WebView(
                    initialUrl: widget.type == LoadUrlType.URL
                        ? widget.initialUrl
                        // ? '${widget.initialUrl}?token=${UserBloc.token}&appVersion=${state.packageInfo.version}'
                        : widget.initialUrl,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (controller) {
                      _webViewController = controller;
                      _bloc.webViewController = controller;
                    },
                    navigationDelegate: (request) {
                      if (request.url.startsWith("teacore://")) {
                        return NavigationDecision.prevent;
                      }
                      return NavigationDecision.navigate;
                    },
                    onPageFinished: (value) {
                      _webViewController.evaluateJavascript("document.title").then((result) {
                        _bloc.add(AppWebViewTitleUpdateEvent(result));
                      });
                    },
                    javascriptChannels: _javaScriptChannels,
                  ),
          ),
        );
      },
      listener: (context, state) async {
        if (state.showImagePickerDialog) {
          ShowPictureBottomSheet.openModalBottomSheet(context: context).then((value) {
            if (value is PickedFile) {
              String name = basename(value.path);
              value.readAsBytes().then((bytes) {
                _webViewController
                    ?.evaluateJavascript('jsImagePickerResult("${convert.base64Encode(bytes)},$name,${bytes.length}")');
              });
            }
          });
        }
        if (state.openScanCodePage) {
          Map<PermissionGroup, PermissionStatus> permissions =
              await PermissionHandler().requestPermissions([PermissionGroup.camera]);
          if (permissions[PermissionGroup.camera] == PermissionStatus.granted) {
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
              return QrCodeReaderView(
                scanBoxRatio: 0.7,
                // ignore: missing_return
                onScan: (value) {
                  _webViewController?.evaluateJavascript('jsScanCodeResult("$value")');
                },
              );
            }));
          } else {
            Fluttertoast.showToast(msg: "请打开摄像头权限");
          }
        }
      },
    );
  }

  Set<JavascriptChannel> _getJavaScriptChannels() {
    return Set.from([
      JavascriptChannel(
          name: "flutterScanCode",
          onMessageReceived: (JavascriptMessage message) {
            _bloc.add(AppWebViewScanCodeEvent());
          }),
      JavascriptChannel(
          name: "flutterImagePicker",
          onMessageReceived: (JavascriptMessage message) {
            _bloc.add(AppWebViewImagePickerEvent());
          }),
      JavascriptChannel(
          name: "flutterUserInfo",
          onMessageReceived: (JavascriptMessage message) {
            _bloc.add(AppWebViewOnRequestUserInfoEvent());
          }),
      JavascriptChannel(
          name: "flutterGetUserInfo",
          onMessageReceived: (JavascriptMessage message) {
            _bloc.add(AppWebViewOnRequestUserInfoEvent());
          }),
      JavascriptChannel(
          name: "flutterInvalidToken",
          onMessageReceived: (JavascriptMessage message) {
            _bloc.add(AppWebViewOnTokenInvalidEvent());
          }),
      JavascriptChannel(
          name: "flutterToast",
          onMessageReceived: (JavascriptMessage message) {
            if (Util.isEmptyString(message.message)) {
              return;
            }
            Map<String, dynamic> map;
            try {
              map = json.decode(message.message);
            } catch (e) {}
            if (map == null || !map.containsKey("content") || Util.isEmptyString(map["content"])) {
              return;
            }

            _bloc.add(AppWebViewToastEvent(WebViewToast.formJson(map)));
          })
    ]);
  }

  goBack(BuildContext context) {
    if (_webViewController == null) {
      Navigator.of(context).pop();
      return;
    }
    _webViewController.canGoBack().then((value) {
      if (value) {
        _webViewController.goBack();
      } else {
        Navigator.of(context).pop();
      }
    });
  }
}
