
import 'package:dio/dio.dart';
import 'package:family/network/client_impl/common_network/common_client.dart';

abstract class CommonService {
  static Dio _dio = CommonClient().dio;
  static final String _news = "http://is.snssdk.com/api/news/feed/v51/";

  static Future<Response> news() async {
    return await _dio.get(_news);
  }
}
