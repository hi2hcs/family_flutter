import 'package:dio/src/interceptor.dart';
import 'package:family/network/client/net_http_client.dart';
import 'package:family/network/interceptor/logging_interceptor.dart';
import 'package:family/network/interceptor/token_header_interceptor.dart';
import 'package:family/network/interface/network_config.dart';


import 'common_network_config.dart';

class CommonClient extends NetHttpClient {
  static CommonClient _instance;

  factory CommonClient() {
    if (_instance == null) {
      _instance = CommonClient._();
    }
    return _instance;
  }

  CommonClient._() : super();

  @override
  List<Interceptor> get interceptors => [
    TokenHeaderInterceptor(),
    LoggingInterceptor(),
  ];

  @override
  NetworkConfig get networkConfig => CommonNetworkConfig();
}