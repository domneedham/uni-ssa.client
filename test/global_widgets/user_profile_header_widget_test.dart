import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssa_app/app/ui/global_widgets/user_profile_header.dart';

import '../manager_staff_tab/manager_staff_tab_test_data.dart';
import '../testable_widget.dart';

void main() {
  group('profile header', () {
    testWidgets('shows the name', (WidgetTester tester) async {
      await tester.pumpWidget(
          TestableWidget(child: UserProfileHeader(user: mockManager)));

      expect(find.text(mockManager.name), findsOneWidget);
    });

    testWidgets('shows the avatar with the user initials',
        (WidgetTester tester) async {
      await tester.pumpWidget(
          TestableWidget(child: UserProfileHeader(user: mockManager)));

      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.text("${mockManager.firstname[0]}${mockManager.surname[0]}"),
          findsOneWidget);
    });
  });
}
