import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ssa_app/app/data/providers/auth_provider.dart';

const String _AUTHORISATION_STRING = 'Authorization';

String get accessToken => GetStorage().read('access_token');
String get refreshToken => GetStorage().read('refresh_token');

String get accessBearerToken => 'Bearer $accessToken';
String get refreshBearerToken => 'Bearer $refreshToken';

Map<String, String> get bearerHeaders {
  return {_AUTHORISATION_STRING: accessBearerToken};
}

Map<String, String> get refreshHeaders {
  return {_AUTHORISATION_STRING: refreshBearerToken};
}

String get baseUrl => 'http://localhost:8080/api';

Request<dynamic> addRequestModifier(Request<dynamic> request) {
  print('Adding headers');
  request.headers[_AUTHORISATION_STRING] = accessBearerToken;
  return request;
}

Future<Request<dynamic>> addAuthenticator(Request<dynamic> request) async {
  print('Refreshing token');
  final res = await AuthProvider.to.refreshToken();
  if (res['access_token'] != null) {
    request.headers[_AUTHORISATION_STRING] = res['access_token']!;
  }
  return request;
}
