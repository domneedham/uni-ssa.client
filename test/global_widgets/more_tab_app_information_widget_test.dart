import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssa_app/app/ui/global_widgets/more_tab_app_information.dart';

import '../testable_widget.dart';

void main() {
  testWidgets('shows an about list tile', (WidgetTester tester) async {
    await tester.pumpWidget(TestableWidget(child: MoreTabAppInformation()));
    await tester.pumpAndSettle();

    expect(find.byType(AboutListTile), findsOneWidget);
    expect(find.text("About"), findsOneWidget);
  });

  testWidgets('about popup shows information about the developer',
      (WidgetTester tester) async {
    await tester.pumpWidget(TestableWidget(child: MoreTabAppInformation()));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(AboutListTile));
    await tester.pumpAndSettle();

    expect(find.textContaining("Dominic Needham"), findsOneWidget);
  });
}
