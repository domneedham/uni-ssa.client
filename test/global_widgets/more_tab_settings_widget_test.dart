import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssa_app/app/ui/global_widgets/more_tab_settings.dart';

import '../testable_widget.dart';

void main() {
  testWidgets('shows a switch to toggle dark mode',
      (WidgetTester tester) async {
    await tester.pumpWidget(TestableWidget(
      child: MoreTabSettings(
        logout: () {},
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.byType(SwitchListTile), findsOneWidget);
    expect(find.text("Dark Mode"), findsOneWidget);
  });

  testWidgets('shows an option to logout', (WidgetTester tester) async {
    await tester.pumpWidget(TestableWidget(
      child: MoreTabSettings(
        logout: () {},
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.text("Logout"), findsOneWidget);
    expect(find.byIcon(Icons.logout), findsOneWidget);
  });

  group('logout list tile', () {
    testWidgets('on click renders an alert dialog', (tester) async {
      await tester.pumpWidget(TestableWidget(
        child: MoreTabSettings(
          logout: () {},
        ),
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.text("Logout"));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
    });
    group('alert dialog', () {
      Future<void> showAlertDialog(WidgetTester tester) async {
        await tester.pumpWidget(TestableWidget(
          child: MoreTabSettings(
            logout: () {},
          ),
        ));
        await tester.pumpAndSettle();

        await tester.tap(find.text("Logout"));
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsOneWidget);
      }

      testWidgets('shows yes and no option', (tester) async {
        await showAlertDialog(tester);

        expect(find.text("Yes"), findsOneWidget);
        expect(find.text("No"), findsOneWidget);
      });

      testWidgets('yes action closes the dialog', (tester) async {
        await showAlertDialog(tester);

        await tester.tap(find.text("Yes"));
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsNothing);
      });

      testWidgets('no action closes the dialog', (tester) async {
        await showAlertDialog(tester);

        await tester.tap(find.text("No"));
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsNothing);
      });
    });
  });
}
