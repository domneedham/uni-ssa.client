import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/home_staff_controller.dart';
import 'package:ssa_app/app/ui/pages/home_page/staff/staff_home.dart';
import 'package:ssa_app/app/ui/pages/home_page/staff/staff_skill_card.dart';

import '../../mocks/mocks.dart';
import '../../testable_widget.dart';
import 'staff_home_test_data.dart';

void main() {
  final binding = BindingsBuilder(() {
    Get.lazyPut<HomeStaffController>(() => HomeStaffController());
  });

  setUp(() async {
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  testWidgets('User debug information is shown', (WidgetTester tester) async {
    final mockSkillRepo = TestMocks.skillRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.getStaffSkillById(any)).thenReturn(mockSkillOne);
    when(mockUserRepo.staff).thenReturn(mockUserOneSkill);

    // Build our app and trigger a frame.
    await tester.pumpWidget(TestableWidget(child: StaffHomePage()));

    expect(find.text(mockUserOneSkill.userDebugInfo), findsOneWidget);
  });

  testWidgets('All needed skill data is shown', (WidgetTester tester) async {
    final mockSkillRepo = TestMocks.skillRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.getStaffSkillById(any)).thenReturn(mockSkillOne);
    when(mockUserRepo.staff).thenReturn(mockUserOneSkill);

    // Build our app and trigger a frame.
    await tester.pumpWidget(TestableWidget(child: StaffHomePage()));

    expect(find.byIcon(mockSkillOne.category.icon), findsOneWidget);
    expect(find.text(mockSkillOne.name), findsOneWidget);
    expect(find.byIcon(Icons.star), findsWidgets);
  });

  testWidgets('More than one skill is shown if the user has more than one',
      (WidgetTester tester) async {
    final mockSkillRepo = TestMocks.skillRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.getStaffSkillById(1)).thenReturn(mockSkillOne);
    when(mockSkillRepo.getStaffSkillById(2)).thenReturn(mockSkillTwo);
    when(mockUserRepo.staff).thenReturn(mockUserTwoSkills);

    // Build our app and trigger a frame.
    await tester.pumpWidget(TestableWidget(child: StaffHomePage()));

    expect(find.byType(StaffSkillCard), findsNWidgets(2));
  });

  testWidgets('No StaffSkillCard widgets are shown if the user has no skills',
      (WidgetTester tester) async {
    final mockSkillRepo = TestMocks.skillRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.getStaffSkillById(any)).thenReturn(null);
    when(mockUserRepo.staff).thenReturn(mockUserNoSkills);

    // Build our app and trigger a frame.
    await tester.pumpWidget(TestableWidget(child: StaffHomePage()));

    expect(find.byType(StaffSkillCard), findsNothing);
  });

  testWidgets('Text is shown informing the user they have no skills if true',
      (WidgetTester tester) async {
    final mockSkillRepo = TestMocks.skillRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.getStaffSkillById(any)).thenReturn(null);
    when(mockUserRepo.staff).thenReturn(mockUserNoSkills);

    // Build our app and trigger a frame.
    await tester.pumpWidget(TestableWidget(child: StaffHomePage()));

    expect(find.textContaining("You have no registered skills"), findsWidgets);
  });
}
