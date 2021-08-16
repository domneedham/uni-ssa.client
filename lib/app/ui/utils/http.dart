import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ssa_app/app/data/providers/auth_provider.dart';

abstract class SsaHttp {
  static const String _AUTHORISATION_STRING = 'Authorization';

  static String get accessToken => GetStorage().read('access_token');
  static String get refreshToken => GetStorage().read('refresh_token');

  static String get accessBearerToken => "Bearer $accessToken";
  static String get refreshBearerToken => "Bearer $refreshToken";

  static Map<String, String> get bearerHeaders {
    return {_AUTHORISATION_STRING: accessBearerToken};
  }

  static Map<String, String> get refreshHeaders {
    return {_AUTHORISATION_STRING: refreshBearerToken};
  }

  static String get baseUrl => "http://localhost:8080/api";

  static Request<dynamic> addRequestModifier(Request<dynamic> request) {
    request.headers[_AUTHORISATION_STRING] = SsaHttp.accessBearerToken;
    return request;
  }

  static Future<Request<dynamic>> addAuthenticator(
      Request<dynamic> request) async {
    final res = await AuthProvider.to.refreshToken();
    if (res["access_token"] != null) {
      request.headers[_AUTHORISATION_STRING] = res["access_token"]!;
    }
    return request;
  }
}
