import 'package:get/get.dart';

abstract class PlatformUtils {
  static bool get isApple => GetPlatform.isIOS || GetPlatform.isMacOS;
}
