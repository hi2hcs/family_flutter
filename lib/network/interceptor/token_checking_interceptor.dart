
import 'package:dio/dio.dart';
class TokenCheckingInterceptor extends Interceptor {
  @override
  Future onResponse(Response response) {
    if (response != null && response.data != null && (response.data is Map) && response.data["code"] != null) {
      int code = response.data["code"];
      print("Dio: /core/getInfo == response.request.path: ${("/core/getInfo" == response.request.path)}");
      // if (code == 303 || (code == 401 && ("/core/getInfo" == response.request.path))) {
      //   GlobalBlocs.get(UserBloc.blocName).add(UserLogoutEvent());
      // }
    }
    return Future.value(response);
  }
}
