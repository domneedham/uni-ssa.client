import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/login_controller.dart';
import 'package:ssa_app/app/ui/pages/login/login_page.dart';

import '../mocks/mocks.dart';
import '../testable_widget.dart';

main() {
  final binding = BindingsBuilder(() {
    Get.lazyPut<LoginController>(() => LoginController());
  });

  setUp(() async {
    Get.testMode = true;
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  testWidgets('shows the app title', (tester) async {
    TestMocks.userRepository;

    await tester.pumpWidget(TestableWidget(child: LoginPage()));
    await tester.pumpAndSettle();

    expect(find.text("Staff Skill Auditor"), findsOneWidget);
  });

  group('form', () {
    testWidgets('shows an email box', (tester) async {
      TestMocks.userRepository;

      await tester.pumpWidget(TestableWidget(child: LoginPage()));
      await tester.pumpAndSettle();

      expect(find.text("Email"), findsOneWidget);
    });

    testWidgets('shows a password box', (tester) async {
      TestMocks.userRepository;

      await tester.pumpWidget(TestableWidget(child: LoginPage()));
      await tester.pumpAndSettle();

      expect(find.text("Password"), findsOneWidget);
    });

    testWidgets('shows a login button', (tester) async {
      TestMocks.userRepository;

      await tester.pumpWidget(TestableWidget(child: LoginPage()));
      await tester.pumpAndSettle();

      final finder = find.byWidgetPredicate(
          (widget) => widget is TextButton && widget.child is Text);

      expect(finder, findsOneWidget);
    });
  });
}
