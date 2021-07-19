import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/manager_skill_tab_controller.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_list.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_tab/manager_skill_card.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_tab/manager_skill_list_tile.dart';
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

  group('manager skill tab', () {
    testWidgets('appbar title shows the right title',
        (WidgetTester tester) async {
      final mockSkillRepo = TestMocks.skillManagerRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockSkillRepo.skills)
          .thenAnswer((_) async => [mockManagerStaffSkillOne]);
      when(mockUserRepo.manager).thenReturn(mockManager);

      await tester.pumpWidget(TestableWidget(child: ManagerSkillTab()));
      await tester.pumpAndSettle();

      expect(find.text("Skills"), findsOneWidget);
    });

    testWidgets('shows an option to create a new skill',
        (WidgetTester tester) async {
      final mockSkillRepo = TestMocks.skillManagerRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockSkillRepo.skills)
          .thenAnswer((_) async => [mockManagerStaffSkillOne]);
      when(mockUserRepo.manager).thenReturn(mockManager);

      await tester.pumpWidget(TestableWidget(child: ManagerSkillTab()));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('shows text informing the user skills failed to load if true',
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
  });

  group('manager skill tab list view type', () {
    testWidgets('appbar has a popup menu button to select the view type',
        (WidgetTester tester) async {
      final mockSkillRepo = TestMocks.skillManagerRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockSkillRepo.skills)
          .thenAnswer((_) async => List<ManagerStaffSkill>.empty());
      when(mockUserRepo.manager).thenReturn(mockManager);

      await tester.pumpWidget(TestableWidget(child: ManagerSkillTab()));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.view_agenda_outlined), findsOneWidget);
    });

    testWidgets('appbar popup menu button shows two options',
        (WidgetTester tester) async {
      final mockSkillRepo = TestMocks.skillManagerRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockSkillRepo.skills)
          .thenAnswer((_) async => List<ManagerStaffSkill>.empty());
      when(mockUserRepo.manager).thenReturn(mockManager);

      await tester.pumpWidget(TestableWidget(child: ManagerSkillTab()));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.view_agenda_outlined));
      await tester.pumpAndSettle();

      expect(find.text("List"), findsOneWidget);
      expect(find.text("Grid"), findsOneWidget);
    });

    testWidgets(
        'appbar popup menu list option calls the controller function with the right enum value if list',
        (WidgetTester tester) async {
      final mockSkillRepo = TestMocks.skillManagerRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockSkillRepo.skills)
          .thenAnswer((_) async => List<ManagerStaffSkill>.empty());
      when(mockUserRepo.manager).thenReturn(mockManager);

      final controller = Get.find<ManagerSkillTabController>();
      // reset type to ensure it changes
      controller.viewType.value = SkillListViewType.GRID;

      await tester.pumpWidget(TestableWidget(child: ManagerSkillTab()));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.view_agenda_outlined));
      await tester.pumpAndSettle();

      await tester.tap(find.text("List"));

      expect(controller.viewType.value, SkillListViewType.LIST);
    });

    testWidgets(
        'appbar popup menu list option calls the controller function with the right enum value if grid',
        (WidgetTester tester) async {
      final mockSkillRepo = TestMocks.skillManagerRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockSkillRepo.skills)
          .thenAnswer((_) async => List<ManagerStaffSkill>.empty());
      when(mockUserRepo.manager).thenReturn(mockManager);

      final controller = Get.find<ManagerSkillTabController>();
      // reset type to ensure it changes
      controller.viewType.value = SkillListViewType.LIST;

      await tester.pumpWidget(TestableWidget(child: ManagerSkillTab()));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.view_agenda_outlined));
      await tester.pumpAndSettle();

      await tester.tap(find.text("Grid"));

      expect(controller.viewType.value, SkillListViewType.GRID);
    });
  });

  group('manager skill tab list tile', () {
    testWidgets('shows the name of the skill', (WidgetTester tester) async {
      TestMocks.skillManagerRepository;

      await tester.pumpWidget(
        TestableWidget(
          child: ManagerSkillListTile(
            skill: mockManagerStaffSkillOne,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(mockManagerStaffSkillOne.name), findsOneWidget);
    });

    testWidgets('shows the number of staff allocated to the skill',
        (WidgetTester tester) async {
      TestMocks.skillManagerRepository;

      await tester.pumpWidget(
        TestableWidget(
          child: ManagerSkillListTile(
            skill: mockManagerStaffSkillOne,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
          find.textContaining(mockManagerStaffSkillOne.staff.length.toString()),
          findsOneWidget);
    });

    testWidgets('shows the right chevron icon', (WidgetTester tester) async {
      TestMocks.skillManagerRepository;

      await tester.pumpWidget(
        TestableWidget(
          child: ManagerSkillListTile(
            skill: mockManagerStaffSkillOne,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });
  });

  group('anager skill tab card', () {
    testWidgets('shows the name of the skill', (WidgetTester tester) async {
      TestMocks.skillManagerRepository;

      await tester.pumpWidget(
        TestableWidget(
          child: ManagerSkillCard(
            skill: mockManagerStaffSkillOne,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(mockManagerStaffSkillOne.name), findsOneWidget);
    });

    testWidgets('shows the number of staff allocated to the skill',
        (WidgetTester tester) async {
      TestMocks.skillManagerRepository;

      await tester.pumpWidget(
        TestableWidget(
          child: ManagerSkillCard(
            skill: mockManagerStaffSkillOne,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
          find.textContaining(mockManagerStaffSkillOne.staff.length.toString()),
          findsOneWidget);
    });
  });

  testWidgets('all needed skill data is shown', (WidgetTester tester) async {
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
}