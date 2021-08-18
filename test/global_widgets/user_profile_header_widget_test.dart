import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssa_app/app/ui/global_widgets/user_profile_header.dart';

import '../mocks/data.dart';
import '../testable_widget.dart';

void main() {
  final managerOne = TestData.mockManagerNoStaff;

  group('profile header', () {
    testWidgets('shows the name', (WidgetTester tester) async {
      await tester.pumpWidget(
          TestableWidget(child: UserProfileHeader(user: managerOne)));

      expect(find.text(managerOne.name), findsOneWidget);
    });

    testWidgets('shows the avatar with the user initials',
        (WidgetTester tester) async {
      await tester.pumpWidget(
          TestableWidget(child: UserProfileHeader(user: managerOne)));

      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.text('${managerOne.firstname[0]}${managerOne.surname[0]}'),
          findsOneWidget);
    });
  });
}
