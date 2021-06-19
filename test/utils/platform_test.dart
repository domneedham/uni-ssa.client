import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/ui/utils/platform.dart';

void main() {
  setUp(() {
    Get.testMode = true;
  });

  tearDown(() {
    PlatformUtils.reset();
  });

  group('isApple tests', () {
    test('isApple is true if platform is iOS', () {
      PlatformUtils.isIOS = true;
      expect(PlatformUtils.isApple, true);
    });

    test('isApple is true if platform is macOS', () {
      PlatformUtils.isMacOS = true;
      expect(PlatformUtils.isApple, true);
    });

    test('isApple is false if platform is not iOS or macOS', () {
      PlatformUtils.isIOS = false;
      PlatformUtils.isMacOS = false;

      expect(PlatformUtils.isApple, false);
    });
  });

  group('isIOS tests', () {
    test('isIOS is true if platform is iOS', () {
      PlatformUtils.isIOS = true;
      expect(PlatformUtils.isIOS, true);
    });
    test('isIOS is false if platform is not iOS', () {
      PlatformUtils.isIOS = false;
      expect(PlatformUtils.isIOS, false);
    });
  });

  group('isMacOS tests', () {
    test('isMacOS is true if platform is macOS', () {
      PlatformUtils.isMacOS = true;
      expect(PlatformUtils.isMacOS, true);
    });
    test('isMacOS is false if platform is not macOS', () {
      PlatformUtils.isMacOS = false;
      expect(PlatformUtils.isMacOS, false);
    });
  });

  group('isAndroid tests', () {
    test('isAndroid is true if platform is Android', () {
      PlatformUtils.isAndroid = true;
      expect(PlatformUtils.isAndroid, true);
    });
    test('isAndroid is false if platform is not Android', () {
      PlatformUtils.isAndroid = false;
      expect(PlatformUtils.isAndroid, false);
    });
  });

  group('isWindows tests', () {
    test('isWindows is true if platform is Windows', () {
      PlatformUtils.isWindows = true;
      expect(PlatformUtils.isWindows, true);
    });
    test('isWindows is false if platform is not Windows', () {
      PlatformUtils.isWindows = false;
      expect(PlatformUtils.isWindows, false);
    });
  });

  group('isFuchsia tests', () {
    test('isFuchsia is true if platform is Fuchsia', () {
      PlatformUtils.isFuchsia = true;
      expect(PlatformUtils.isFuchsia, true);
    });
    test('isFuchsia is false if platform is not Fuchsia', () {
      PlatformUtils.isFuchsia = false;
      expect(PlatformUtils.isFuchsia, false);
    });
  });

  group('isWeb tests', () {
    test('isWeb is true if platform is Web', () {
      PlatformUtils.isWeb = true;
      expect(PlatformUtils.isWeb, true);
    });
    test('isWeb is false if platform is not Web', () {
      PlatformUtils.isWeb = false;
      expect(PlatformUtils.isWeb, false);
    });
  });
}
