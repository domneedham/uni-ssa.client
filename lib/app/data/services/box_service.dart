import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BoxService extends GetxService {
  static BoxService get to => Get.find();

  final box = GetStorage();

  static const ACCESS_TOKEN = 'access_token';
  static const REFRESH_TOKEN = 'refresh_token';
  static const USER_ROLE = 'role';
  static const USER_EMAIL = 'email';

  void writeAuthTokens(String? accessToken, String? refreshToken) {
    if (accessToken != null) {
      box.remove(ACCESS_TOKEN);
      box.write(ACCESS_TOKEN, accessToken);
    }

    if (refreshToken != null) {
      box.remove(REFRESH_TOKEN);
      box.write(REFRESH_TOKEN, refreshToken);
    }
  }

  void clearAuthTokens() {
    box.remove(ACCESS_TOKEN);
    box.remove(REFRESH_TOKEN);
  }

  void writeUserDetails(String? role, String? email) {
    if (role != null) {
      box.remove(USER_ROLE);
      box.write(USER_ROLE, role);
    }

    if (email != null) {
      box.remove(USER_EMAIL);
      box.write(USER_EMAIL, email);
    }
  }

  void clearUserDetails() {
    box.remove(USER_ROLE);
    box.remove(USER_EMAIL);
  }

  void clearAll() {
    clearAuthTokens();
    clearUserDetails();
  }
}
