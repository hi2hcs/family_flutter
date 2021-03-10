import 'package:dio/dio.dart';
import 'package:family/network/client/net_http_client.dart';
import 'package:family/network/interface/network_config.dart';

import 'downloader_network_config.dart';

class DownloaderClient extends NetHttpClient {
  static DownloaderClient _instance;

  factory DownloaderClient() {
    if (_instance == null) {
      _instance = DownloaderClient._();
    }
    return _instance;
  }

  DownloaderClient._() : super();

  @override
  List<Interceptor> get interceptors => [];

  @override
  NetworkConfig get networkConfig => DownloaderNetworkConfig();
}
