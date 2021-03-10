import 'package:dio/dio.dart';
import 'package:family/network/client/net_http_client.dart';


abstract class NetService {
  NetHttpClient get _dioFactory;

  Dio get dio => _dioFactory.dio;
}
