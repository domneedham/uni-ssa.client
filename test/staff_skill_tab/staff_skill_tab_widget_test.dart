import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/staff_skill_tab_controller.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_tab/staff_skill_card.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_tab/staff_skill_tab.dart';

import '../mocks/mocks.dart';
import '../testable_widget.dart';
import 'staff_skill_tab_test_data.dart';

void main() {
  final binding = BindingsBuilder(() {
    Get.lazyPut<StaffSkillTabController>(() => StaffSkillTabController());
  });

  setUp(() async {
    Get.testMode = true;
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  testWidgets('All needed skill data is shown', (WidgetTester tester) async {
    final mockSkillRepo = TestMocks.skillStaffRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.getSkillsByIds([1]))
        .thenAnswer((_) async => [mockStaffSkillOne]);
    when(mockUserRepo.staff).thenReturn(mockStaffOneSkill);

    // Build our app and trigger a frame.
    await tester.pumpWidget(TestableWidget(child: StaffSkillTab()));

    await tester.pumpAndSettle();

    expect(find.byIcon(mockStaffSkillOne.category.icon), findsOneWidget);
    expect(find.text(mockStaffSkillOne.name), findsOneWidget);
    expect(find.byIcon(Icons.star), findsWidgets);
  });

  testWidgets('More than one skill is shown if the user has more than one',
      (WidgetTester tester) async {
    final mockSkillRepo = TestMocks.skillStaffRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.getSkillsByIds([1, 2]))
        .thenAnswer((_) async => [mockStaffSkillOne, mockStaffSkillTwo]);

    when(mockUserRepo.staff).thenReturn(mockStaffTwoSkills);

    // Build our app and trigger a frame.
    await tester.pumpWidget(TestableWidget(child: StaffSkillTab()));

    await tester.pumpAndSettle();

    expect(find.byType(StaffSkillCard), findsNWidgets(2));
  });

  testWidgets('No StaffSkillCard widgets are shown if the user has no skills',
      (WidgetTester tester) async {
    final mockSkillRepo = TestMocks.skillStaffRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.getSkillsByIds([]))
        .thenAnswer((_) async => List<StaffSkill>.empty());
    when(mockUserRepo.staff).thenReturn(mockStaffNoSkills);

    // Build our app and trigger a frame.
    await tester.pumpWidget(TestableWidget(child: StaffSkillTab()));

    await tester.pumpAndSettle();

    expect(find.byType(StaffSkillCard), findsNothing);
  });

  testWidgets('Text is shown informing the user they have no skills if true',
      (WidgetTester tester) async {
    final mockSkillRepo = TestMocks.skillStaffRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.getSkillsByIds([]))
        .thenAnswer((_) async => List<StaffSkill>.empty());
    when(mockUserRepo.staff).thenReturn(mockStaffNoSkills);

    // Build our app and trigger a frame.
    await tester.pumpWidget(TestableWidget(child: StaffSkillTab()));

    await tester.pumpAndSettle();

    expect(
        find.textContaining("You have no registered skills"), findsOneWidget);
  });
}
