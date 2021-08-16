import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ssa_app/app/data/models/enums/user_role.dart';
import 'package:ssa_app/app/exceptions/no_data_found.dart';
import 'package:ssa_app/app/ui/utils/http.dart';

abstract class IAuthProvider {
  Future<Response<UserRole>> login(String email, String password);
  Future<dynamic> refreshToken();
}

class AuthProvider extends GetConnect implements IAuthProvider {
  static IAuthProvider get to => Get.find();

  final box = GetStorage();

  @override
  void onInit() {
    httpClient.baseUrl = "${SsaHttp.baseUrl}/auth";
  }

  void _writeTokens(String? accessToken, String? refreshToken) {
    if (accessToken != null) {
      box.remove("access_token");
      box.write("access_token", accessToken);
    }

    if (refreshToken != null) {
      box.remove("refresh_token");
      box.write("refresh_token", refreshToken);
    }
  }

  UserRole _decodeLogin(dynamic val) {
    if (val == null) {
      throw NoDataReturned("Login failed");
    }

    if (val["access_token"] != null && val["refresh_token"] != null) {
      _writeTokens(val["access_token"], val["refresh_token"]);
    }

    if (val["role"] == "STAFF")
      return UserRole.STAFF;
    else if (val["role"] == "MANAGER")
      return UserRole.MANAGER;
    else
      throw NoDataReturned("Unable to login successfully");
  }

  @override
  Future<Response<UserRole>> login(String email, String password) async {
    final encodedValue = "username=$email&password=$password";

    return post(
      '/login',
      encodedValue,
      contentType: "application/x-www-form-urlencoded",
      headers: {"Accept": "application/json"},
      decoder: (val) => _decodeLogin(val),
    );
  }

  @override
  Future<dynamic> refreshToken() async {
    final res = await get('/token/refresh', headers: SsaHttp.refreshHeaders);
    _writeTokens(res.body["access_token"], res.body["refresh_token"]);
    return res.body;
  }
}
