import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// Service for interacting with [GetStorage].
class BoxService extends GetxService {
  static BoxService get to => Get.find();

  final box = GetStorage();

  // define range of constants for use out of the service
  static const ACCESS_TOKEN = 'access_token';
  static const REFRESH_TOKEN = 'refresh_token';
  static const USER_ROLE = 'role';
  static const USER_EMAIL = 'email';

  /// Save or overwrite authentication tokens to local storage.
  ///
  /// [accessToken] and [refreshToken] can be null, meaning nothing will happen
  /// with that parameter.
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

  /// Clear both access and refresh tokens from local storage.
  void clearAuthTokens() {
    box.remove(ACCESS_TOKEN);
    box.remove(REFRESH_TOKEN);
  }

  /// Save or overwrite basic user information to local storage. This is used
  /// for providing user details upon relaunch after a success login.isBlank
  ///
  /// [role] and [email] can be null, meaning nothing will happen with
  /// that parameter.
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

  /// Clear user details from local storage.
  void clearUserDetails() {
    box.remove(USER_ROLE);
    box.remove(USER_EMAIL);
  }

  /// Clear everything from local storage.
  void clearAll() {
    clearAuthTokens();
    clearUserDetails();
  }
}
