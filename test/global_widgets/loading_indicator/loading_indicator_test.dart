import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/utils/platform.dart';

void main() {
  setUp(() {
    Get.testMode = true;
  });

  tearDown(() {
    PlatformUtils.reset();
  });

  testWidgets('Loading indicator shows a cupertino loader if from iOS',
      (WidgetTester tester) async {
    PlatformUtils.isIOS = true;
    await tester.pumpWidget(LoadingIndicator());

    expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
  });

  testWidgets('Loading indicator shows a cupertino loader if from macOS',
      (WidgetTester tester) async {
    PlatformUtils.isMacOS = true;
    await tester.pumpWidget(LoadingIndicator());

    expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
  });

  testWidgets('Loading indicator shows a material loader if from Android',
      (WidgetTester tester) async {
    PlatformUtils.isAndroid = true;

    await tester.pumpWidget(LoadingIndicator());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Loading indicator shows a material loader if from Windows',
      (WidgetTester tester) async {
    PlatformUtils.isWindows = true;
    await tester.pumpWidget(LoadingIndicator());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Loading indicator shows a material loader if from Fuchsia',
      (WidgetTester tester) async {
    PlatformUtils.isFuchsia = true;
    await tester.pumpWidget(LoadingIndicator());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Loading indicator shows a material loader if from Web',
      (WidgetTester tester) async {
    PlatformUtils.isWeb = true;
    await tester.pumpWidget(LoadingIndicator());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
