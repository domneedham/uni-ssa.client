import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/manager_skill_tab_controller.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_tab/manager_skill_card.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_tab/manager_skill_tab.dart';

import '../mocks/mocks.dart';
import '../testable_widget.dart';
import 'manager_skill_tab_test_data.dart';

void main() {
  final binding = BindingsBuilder(() {
    Get.lazyPut<ManagerSkillTabController>(() => ManagerSkillTabController());
  });

  setUp(() async {
    Get.testMode = true;
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  testWidgets('All needed skill data is shown', (WidgetTester tester) async {
    final mockSkillRepo = TestMocks.skillManagerRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.skills)
        .thenAnswer((_) async => [mockManagerStaffSkillOne]);
    when(mockUserRepo.manager).thenReturn(mockManager);

    await tester.pumpWidget(TestableWidget(child: ManagerSkillTab()));
    await tester.pumpAndSettle();

    expect(find.byIcon(mockManagerStaffSkillOne.category.icon), findsOneWidget);
    expect(find.text(mockManagerStaffSkillOne.name), findsOneWidget);
  });

  testWidgets('More than one skill is shown if more than one exists',
      (WidgetTester tester) async {
    final mockSkillRepo = TestMocks.skillManagerRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.skills).thenAnswer(
        (_) async => [mockManagerStaffSkillOne, mockManagerStaffSkillTwo]);

    when(mockUserRepo.manager).thenReturn(mockManager);

    await tester.pumpWidget(TestableWidget(child: ManagerSkillTab()));
    await tester.pumpAndSettle();

    expect(find.byType(ManagerSkillCard), findsNWidgets(2));
  });

  testWidgets(
      'No ManagerSkillCard widgets are shown if the no skills are loaded',
      (WidgetTester tester) async {
    final mockSkillRepo = TestMocks.skillManagerRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.skills)
        .thenAnswer((_) async => List<ManagerStaffSkill>.empty());
    when(mockUserRepo.manager).thenReturn(mockManager);

    await tester.pumpWidget(TestableWidget(child: ManagerSkillTab()));
    await tester.pumpAndSettle();

    expect(find.byType(ManagerSkillCard), findsNothing);
  });

  testWidgets('Text is shown informing the user skills failed to load if true',
      (WidgetTester tester) async {
    final mockSkillRepo = TestMocks.skillManagerRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.skills)
        .thenAnswer((_) async => List<ManagerStaffSkill>.empty());
    when(mockUserRepo.manager).thenReturn(mockManager);

    await tester.pumpWidget(TestableWidget(child: ManagerSkillTab()));
    await tester.pumpAndSettle();

    expect(find.textContaining("No skills loaded."), findsWidgets);
  });
}
