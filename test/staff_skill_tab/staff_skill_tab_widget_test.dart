import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/staff_skill_tab_controller.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_tab/staff_skill_card.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_tab/staff_skill_tab.dart';
import 'package:ssa_app/app/ui/utils/dates.dart';

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

  group('staff skill tab', () {
    testWidgets('appbar title shows the right title',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;
      final mockSkillRepo = TestMocks.skillStaffRepository;

      when(mockSkillRepo.getSkillsByIds([1, 2]))
          .thenAnswer((_) async => [mockStaffSkillOne, mockStaffSkillTwo]);
      when(mockUserRepo.staff).thenReturn(mockStaffTwoSkills);
      await tester.pumpWidget(TestableWidget(child: StaffSkillTab()));

      expect(find.text('Your Skills'), findsOneWidget);
    });

    testWidgets('loading indicator is shown whilst loading',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;
      final mockSkillRepo = TestMocks.skillStaffRepository;

      when(mockSkillRepo.getSkillsByIds([1, 2]))
          .thenAnswer((_) async => [mockStaffSkillOne, mockStaffSkillTwo]);
      when(mockUserRepo.staff).thenReturn(mockStaffTwoSkills);
      await tester.pumpWidget(TestableWidget(child: StaffSkillTab()));

      expect(find.byType(LoadingIndicator), findsOneWidget);
    });

    testWidgets('shows error if one occurs', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;
      final mockSkillRepo = TestMocks.skillStaffRepository;

      final error = Exception("Some error");

      when(mockSkillRepo.getSkillsByIds([1, 2]))
          .thenAnswer((_) async => throw error);
      when(mockUserRepo.staff).thenReturn(mockStaffTwoSkills);

      await tester.pumpWidget(TestableWidget(child: StaffSkillTab()));
      await tester.pumpAndSettle();

      expect(find.text(error.toString()), findsOneWidget);
    });
  });

  group('staff skill tab grid', () {
    testWidgets(
        'shows more than one skill category name if the user has more than one category in skills',
        (WidgetTester tester) async {
      final mockSkillRepo = TestMocks.skillStaffRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockSkillRepo.getSkillsByIds([1, 2]))
          .thenAnswer((_) async => [mockStaffSkillOne, mockStaffSkillTwo]);
      when(mockUserRepo.staff).thenReturn(mockStaffTwoSkills);

      await tester.pumpWidget(TestableWidget(child: StaffSkillTab()));
      await tester.pumpAndSettle();

      expect(find.text(mockStaffSkillOne.category.name), findsOneWidget);
      expect(find.text(mockStaffSkillTwo.category.name), findsOneWidget);
    });

    testWidgets(
        'shows more than one skill category icon if the user has more than one category in skills',
        (WidgetTester tester) async {
      final mockSkillRepo = TestMocks.skillStaffRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockSkillRepo.getSkillsByIds([1, 2]))
          .thenAnswer((_) async => [mockStaffSkillOne, mockStaffSkillTwo]);
      when(mockUserRepo.staff).thenReturn(mockStaffTwoSkills);

      await tester.pumpWidget(TestableWidget(child: StaffSkillTab()));
      await tester.pumpAndSettle();

      expect(find.byIcon(mockStaffSkillOne.category.icon), findsOneWidget);
      expect(find.byIcon(mockStaffSkillTwo.category.icon), findsOneWidget);
    });

    testWidgets('shows more than one skill if the user has more than one',
        (WidgetTester tester) async {
      final mockSkillRepo = TestMocks.skillStaffRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockSkillRepo.getSkillsByIds([1, 2]))
          .thenAnswer((_) async => [mockStaffSkillOne, mockStaffSkillTwo]);
      when(mockUserRepo.staff).thenReturn(mockStaffTwoSkills);

      await tester.pumpWidget(TestableWidget(child: StaffSkillTab()));
      await tester.pumpAndSettle();

      expect(find.byType(StaffSkillCard), findsNWidgets(2));
    });

    testWidgets('shows no card widgets if the user has no skills',
        (WidgetTester tester) async {
      final mockSkillRepo = TestMocks.skillStaffRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockSkillRepo.getSkillsByIds([]))
          .thenAnswer((_) async => List<StaffSkill>.empty());
      when(mockUserRepo.staff).thenReturn(mockStaffNoSkills);

      await tester.pumpWidget(TestableWidget(child: StaffSkillTab()));
      await tester.pumpAndSettle();

      expect(find.byType(StaffSkillCard), findsNothing);
    });

    testWidgets('shows text informing the user they have no skills if true',
        (WidgetTester tester) async {
      final mockSkillRepo = TestMocks.skillStaffRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockSkillRepo.getSkillsByIds([]))
          .thenAnswer((_) async => List<StaffSkill>.empty());
      when(mockUserRepo.staff).thenReturn(mockStaffNoSkills);

      await tester.pumpWidget(TestableWidget(child: StaffSkillTab()));
      await tester.pumpAndSettle();

      expect(
          find.textContaining("You have no registered skills"), findsOneWidget);
    });
  });

  group('staff skill card', () {
    setUp(() {
      TestMocks.userRepository;
      TestMocks.skillStaffRepository;
    });

    testWidgets('shows the skill name', (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: StaffSkillCard(
          skill: mockStaffSkillOne,
        ),
      ));

      expect(find.text(mockStaffSkillOne.name), findsOneWidget);
    });

    testWidgets('shows the skill rating', (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: StaffSkillCard(
          skill: mockStaffSkillOne,
        ),
      ));

      final lengthOfStars = mockStaffSkillOne.rating.toInt();

      expect(find.byIcon(Icons.star), findsNWidgets(lengthOfStars));
    });

    testWidgets('shows the skill expiry if it has one',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: StaffSkillCard(
          skill: mockStaffSkillOne,
        ),
      ));

      final formattedDate = Dates.formatUI(mockStaffSkillOne.expires!);

      expect(find.text(formattedDate), findsOneWidget);
    });

    testWidgets('shows the no expiry if no skill expiry',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: StaffSkillCard(
          skill: mockStaffSkillNoExpiry,
        ),
      ));

      expect(find.text("No Expiry"), findsOneWidget);
    });
  });
}
