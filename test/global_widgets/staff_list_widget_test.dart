import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssa_app/app/ui/global_widgets/staff_list.dart';

import '../mocks/data.dart';
import '../testable_widget.dart';

void main() {
  final staffOne = TestData.mockStaffNoSkills;
  final staffTwo = TestData.mockStaffWithExpirySkills;
  final staffList = [staffOne, staffTwo];

  testWidgets('the name is shown', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestableWidget(
        child: StaffList(
          staffList: staffList,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(staffOne.name), findsOneWidget);
    expect(find.text(staffTwo.name), findsOneWidget);
  });

  testWidgets('the person icon is shown', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestableWidget(
        child: StaffList(
          staffList: staffList,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.person), findsNWidgets(2));
  });
}
