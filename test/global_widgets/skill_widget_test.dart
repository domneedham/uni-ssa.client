import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_category_grid.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_category_list.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_category_title.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_list.dart';

import '../testable_widget.dart';

void main() {
  final mockCategoryOne =
      Category(id: 1, name: "Test Category", icon: Icons.code);
  final mockCategoryTwo = Category(id: 2, name: "Other", icon: Icons.code_off);

  final mockSkillOne =
      Skill(id: 1, name: "Skill One", category: mockCategoryOne);
  final mockSkillTwo =
      Skill(id: 2, name: "Skill Two", category: mockCategoryTwo);

  setUp(() {
    Get.testMode = true;
  });

  group('skill list', () {
    testWidgets('shows each category title', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestableWidget(
          child: SkillList(
            viewType: SkillListViewType.LIST,
            cardBuilder: (skill) => Text(skill.name),
            skills: {
              mockSkillOne.category: [mockSkillOne],
              mockSkillTwo.category: [mockSkillTwo]
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(mockCategoryOne.name), findsOneWidget);
      expect(find.text(mockCategoryTwo.name), findsOneWidget);
    });

    testWidgets('shows list view if view type is list',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestableWidget(
          child: SkillList(
            viewType: SkillListViewType.LIST,
            cardBuilder: (skill) => Text(skill.name),
            skills: {
              mockSkillOne.category: [mockSkillOne],
              mockSkillTwo.category: [mockSkillTwo]
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SkillCategoryList), findsWidgets);
      expect(find.byType(SkillCategoryGrid), findsNothing);
    });

    testWidgets('shows grid view if view type is grid',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestableWidget(
          child: SkillList(
            viewType: SkillListViewType.GRID,
            cardBuilder: (skill) => Text(skill.name),
            skills: {
              mockSkillOne.category: [mockSkillOne],
              mockSkillTwo.category: [mockSkillTwo]
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SkillCategoryList), findsNothing);
      expect(find.byType(SkillCategoryGrid), findsWidgets);
    });

    testWidgets('shows no widgets if no skills are loaded',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestableWidget(
          child: SkillList(
            viewType: SkillListViewType.LIST,
            cardBuilder: (skill) => ListTile(title: Text(skill.name)),
            skills: {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsNothing);
    });

    testWidgets(
        'shows more than one widget if the more than one skill is loaded',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestableWidget(
          child: SkillList(
            viewType: SkillListViewType.LIST,
            cardBuilder: (skill) => ListTile(title: Text(skill.name)),
            skills: {
              mockSkillOne.category: [mockSkillOne],
              mockSkillTwo.category: [mockSkillTwo]
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsNWidgets(2));
    });
  });

  group('skill category title', () {
    testWidgets('shows icon', (WidgetTester tester) async {
      await tester.pumpWidget(
          TestableWidget(child: SkillCategoryTitle(category: mockCategoryOne)));
      await tester.pumpAndSettle();

      expect(find.byIcon(mockCategoryOne.icon), findsOneWidget);
    });

    testWidgets('shows name', (WidgetTester tester) async {
      await tester.pumpWidget(
          TestableWidget(child: SkillCategoryTitle(category: mockCategoryOne)));
      await tester.pumpAndSettle();

      expect(find.text(mockCategoryOne.name), findsOneWidget);
    });
  });
}
