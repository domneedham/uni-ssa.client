import 'package:get/get.dart';

abstract class PlatformUtils {
  static bool _isIOS = false;
  static bool _isMacOS = false;
  static bool _isAndroid = false;
  static bool _isWindows = false;
  static bool _isFuchsia = false;
  static bool _isWeb = false;

  static bool get isApple =>
      (Get.testMode && (_isIOS || _isMacOS)) ||
      (!Get.testMode && (GetPlatform.isIOS || GetPlatform.isMacOS));

  static bool get isIOS =>
      (Get.testMode && _isIOS) || (!Get.testMode && GetPlatform.isIOS);
  static set isIOS(bool value) {
    if (Get.testMode) _isIOS = value;
  }

  static bool get isMacOS =>
      (Get.testMode && _isMacOS) || (!Get.testMode && GetPlatform.isMacOS);
  static set isMacOS(bool value) {
    if (Get.testMode) _isMacOS = value;
  }

  static bool get isAndroid =>
      (Get.testMode && _isAndroid) || (!Get.testMode && GetPlatform.isAndroid);
  static set isAndroid(bool value) {
    if (Get.testMode) _isAndroid = value;
  }

  static bool get isWindows =>
      (Get.testMode && _isWindows) || (!Get.testMode && GetPlatform.isWindows);
  static set isWindows(bool value) {
    if (Get.testMode) _isWindows = value;
  }

  static bool get isFuchsia =>
      (Get.testMode && _isFuchsia) || (!Get.testMode && GetPlatform.isFuchsia);
  static set isFuchsia(bool value) {
    if (Get.testMode) _isFuchsia = value;
  }

  static bool get isWeb =>
      (Get.testMode && _isWeb) || (!Get.testMode && GetPlatform.isWeb);
  static set isWeb(bool value) {
    if (Get.testMode) _isWeb = value;
  }

  static void reset() {
    if (Get.testMode) {
      _isIOS = false;
      _isMacOS = false;
      _isAndroid = false;
      _isWindows = false;
      _isFuchsia = false;
      _isWeb = false;
    }
  }
}
