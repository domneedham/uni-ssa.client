import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ssa_app/app/data/providers/auth_provider.dart';
import 'package:ssa_app/app/data/services/box_service.dart';

const String _AUTHORISATION_STRING = 'Authorization';

String get accessToken => GetStorage().read('access_token');
String get refreshToken => GetStorage().read('refresh_token');

String get accessBearerToken => 'Bearer $accessToken';
String get refreshBearerToken => 'Bearer $refreshToken';

/// The headers that need to be used for a standard authorised HTTP request.
Map<String, String> get bearerHeaders {
  return {_AUTHORISATION_STRING: accessBearerToken};
}

/// The headers taht need to be used for a refresh token HTTP request.
Map<String, String> get refreshHeaders {
  return {_AUTHORISATION_STRING: refreshBearerToken};
}

String get baseUrl => 'http://localhost:8080/api';

/// The function that should be inserted before all standard requests.
///
/// This will set the request headers to use access token.
Request<dynamic> addRequestModifier(Request<dynamic> request) {
  request.headers[_AUTHORISATION_STRING] = accessBearerToken;
  return request;
}

/// The function should be used on a 403 return from the server.
///
/// This will create a new access token and set the data to local storage
/// and rewrite the request headers with it.
Future<Request<dynamic>> addAuthenticator(Request<dynamic> request) async {
  final res = await AuthProvider.to.refreshToken();
  if (res[BoxService.ACCESS_TOKEN] != null) {
    // rewrite new auth token
    BoxService.to.writeAuthTokens(res[BoxService.ACCESS_TOKEN], null);
    // set new auth token in headers for request
    request.headers[_AUTHORISATION_STRING] = res[BoxService.ACCESS_TOKEN]!;
  }
  return request;
}
