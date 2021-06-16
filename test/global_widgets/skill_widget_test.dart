import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_category_title.dart';

import '../testable_widget.dart';

void main() {
  final mockCategory = Category(id: 1, name: "Test Category", icon: Icons.code);

  setUp(() {
    Get.testMode = true;
  });

  group('Skill category title', () {
    testWidgets('Title shows icon', (WidgetTester tester) async {
      await tester.pumpWidget(
          TestableWidget(child: SkillCategoryTitle(category: mockCategory)));
      await tester.pumpAndSettle();

      expect(find.byIcon(mockCategory.icon), findsOneWidget);
    });

    testWidgets('Title shows name', (WidgetTester tester) async {
      await tester.pumpWidget(
          TestableWidget(child: SkillCategoryTitle(category: mockCategory)));
      await tester.pumpAndSettle();

      expect(find.text(mockCategory.name), findsOneWidget);
    });
  });
}
