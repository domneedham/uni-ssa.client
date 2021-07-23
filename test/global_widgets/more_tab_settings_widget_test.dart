import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssa_app/app/ui/global_widgets/more_tab_settings.dart';

import '../testable_widget.dart';

void main() {
  testWidgets('shows a switch to toggle dark mode',
      (WidgetTester tester) async {
    await tester.pumpWidget(TestableWidget(child: MoreTabSettings()));
    await tester.pumpAndSettle();

    expect(find.byType(SwitchListTile), findsOneWidget);
    expect(find.text("Dark Mode"), findsOneWidget);
  });

  testWidgets('shows an option to logout', (WidgetTester tester) async {
    await tester.pumpWidget(TestableWidget(child: MoreTabSettings()));
    await tester.pumpAndSettle();

    expect(find.text("Logout"), findsOneWidget);
    expect(find.byIcon(Icons.logout), findsOneWidget);
  });
}
