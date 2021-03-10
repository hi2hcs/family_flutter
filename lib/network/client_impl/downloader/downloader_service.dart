import 'package:dio/dio.dart';
import 'downloader_client.dart';

abstract class DownloaderService {
  static Future<bool> downloadImageFromAliOss(String url, String path) async {
    Response response = await DownloaderClient().dio.download(url, path).catchError((e) {
      print("downloadImageFromAliOss: $e");
    });
    return response?.statusCode == 200;
  }
}
