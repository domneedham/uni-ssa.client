import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ssa_app/app/data/models/enums/user_role.dart';
import 'package:ssa_app/app/exceptions/no_data_found.dart';

abstract class IAuthProvider {
  Future<Response<UserRole>> login(String email, String password);
}

class AuthProvider extends GetConnect implements IAuthProvider {
  final box = GetStorage();

  @override
  void onInit() {
    httpClient.baseUrl = "http://localhost:8080/api/auth";
  }

  UserRole _decodeLogin(dynamic val) {
    if (val == null) {
      throw NoDataReturned("Login failed");
    }

    if (val["access_token"] != null && val["refresh_token"] != null) {
      box.remove("access_token");
      box.remove("refresh_token");

      box.write("access_token", val["access_token"]);
      box.write("refresh_token", val["refresh_token"]);
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
}
