import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/home_controller.dart';
import 'package:ssa_app/app/ui/pages/home_page/home_page.dart';

import '../testable_widget.dart';

void main() {
  final binding = BindingsBuilder(() {
    Get.lazyPut<HomeController>(() => HomeController());
  });

  setUp(() async {
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  testWidgets('Counter is displayed on screen and updated',
      (WidgetTester tester) async {
    final controller = Get.find<HomeController>();

    expect(controller.counter.value, 0);

    // Build our app and trigger a frame.
    await tester.pumpWidget(TestableWidget(child: HomePage()));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    controller.increment();
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Add icon increments the counter', (WidgetTester tester) async {
    final controller = Get.find<HomeController>();

    await tester.pumpWidget(TestableWidget(child: HomePage()));

    expect(controller.counter.value, 0);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(controller.counter.value, 1);
  });

  testWidgets('Subtract icon decreases the counter',
      (WidgetTester tester) async {
    final controller = Get.find<HomeController>();

    await tester.pumpWidget(TestableWidget(child: HomePage()));

    expect(controller.counter.value, 0);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();

    expect(controller.counter.value, -1);
  });
}
