import 'package:get/get.dart';
import 'package:ssa_app/app/exceptions/failed_to_login.dart';
import 'package:ssa_app/app/exceptions/no_data_found.dart';
import 'package:ssa_app/app/ui/utils/http.dart';

abstract class IAuthProvider {
  Future<Map<String, String>> login(String email, String password);
  Future<dynamic> refreshToken();
}

class AuthProvider extends GetConnect implements IAuthProvider {
  static IAuthProvider get to => Get.find();

  @override
  void onInit() {
    httpClient.baseUrl = '$baseUrl/auth';
  }

  Map<String, String> _decodeLogin(dynamic val) {
    if (val == null) {
      throw NoDataReturned('Login failed');
    }

    if (val['access_token'] != null &&
        val['refresh_token'] != null &&
        val['role'] != null) {
      return {
        'access_token': val['access_token'],
        'refresh_token': val['refresh_token'],
        'role': val['role'],
      };
    } else {
      throw FailedToLoginException('Not all required data returned');
    }
  }

  @override
  Future<Map<String, String>> login(String email, String password) async {
    final encodedValue = 'username=$email&password=$password';

    final res = await post(
      '/login',
      encodedValue,
      contentType: 'application/x-www-form-urlencoded',
      headers: {'Accept': 'application/json'},
    );

    if (res.hasError || res.body == null) {
      throw NoDataReturned('Unable to login');
    }

    return _decodeLogin(res.body);
  }

  @override
  Future<dynamic> refreshToken() async {
    final res = await get('/token/refresh', headers: refreshHeaders);
    return res.body;
  }
}
