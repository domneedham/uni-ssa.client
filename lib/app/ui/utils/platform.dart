import 'package:get/get.dart';

// ignore: avoid_classes_with_only_static_members
abstract class PlatformUtils {
  static bool _isIOS = false;
  static bool _isMacOS = false;
  static bool _isAndroid = false;
  static bool _isWindows = false;
  static bool _isFuchsia = false;
  static bool _isWeb = false;

  /// Whether the client is an apple device.
  static bool get isApple =>
      (Get.testMode && (_isIOS || _isMacOS)) ||
      (!Get.testMode && (GetPlatform.isIOS || GetPlatform.isMacOS));

  /// Whether the client is using iOS. This includes iPadOS.
  static bool get isIOS =>
      (Get.testMode && _isIOS) || (!Get.testMode && GetPlatform.isIOS);

  /// Use when wanting to run tests as if the client is using iOS.
  static set isIOS(bool value) {
    if (Get.testMode) {
      _isIOS = value;
    }
  }

  /// Whether the client is using macOS.
  static bool get isMacOS =>
      (Get.testMode && _isMacOS) || (!Get.testMode && GetPlatform.isMacOS);

  /// Use when wanting to run tests as if the client is using macOS.
  static set isMacOS(bool value) {
    if (Get.testMode) {
      _isMacOS = value;
    }
  }

  /// Whether the client is using Android.
  static bool get isAndroid =>
      (Get.testMode && _isAndroid) || (!Get.testMode && GetPlatform.isAndroid);

  /// Use when wanting to run tests as if the client is using Android.
  static set isAndroid(bool value) {
    if (Get.testMode) {
      _isAndroid = value;
    }
  }

  /// Whether the client is using Windows.
  static bool get isWindows =>
      (Get.testMode && _isWindows) || (!Get.testMode && GetPlatform.isWindows);

  /// Use when wanting to run tests as if the client is using Windows.
  static set isWindows(bool value) {
    if (Get.testMode) {
      _isWindows = value;
    }
  }

  /// Whether the client is using Fuchsia.
  static bool get isFuchsia =>
      (Get.testMode && _isFuchsia) || (!Get.testMode && GetPlatform.isFuchsia);

  /// Use when wanting to run tests as if the client is using Fuchsia.
  static set isFuchsia(bool value) {
    if (Get.testMode) {
      _isFuchsia = value;
    }
  }

  /// Whether the client is using a web browser.
  static bool get isWeb =>
      (Get.testMode && _isWeb) || (!Get.testMode && GetPlatform.isWeb);

  /// Use when wanting to run tests as if the client is using a web browser.
  static set isWeb(bool value) {
    if (Get.testMode) {
      _isWeb = value;
    }
  }

  /// Reset all client fakes for use in testing.
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
