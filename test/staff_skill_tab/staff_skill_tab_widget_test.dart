import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/staff_skill_tab_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_tab/staff_skill_card.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_tab/staff_skill_tab.dart';
import 'package:ssa_app/app/ui/utils/dates.dart';

import '../mocks/data.dart';
import '../mocks/mocks.dart';
import '../testable_widget.dart';

void main() {
  final staffSkillNoExpiry = TestData.mockStaffSkillOneWithNoExpiry;
  final staffSkillOne = TestData.mockStaffSkillOneWithExpiry;
  final staffSkillTwo = TestData.mockStaffSkillTwoWithExpiry;
  final staffWithSkills = TestData.mockStaffWithExpirySkills;
  final staffWithNoSkills = TestData.mockStaffNoSkills;

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
      final mockUserService = TestMocks.userService;
      final mockSkillService = TestMocks.skillStaffService;

      when(mockSkillService.getSkillsForUser(staffWithSkills.id))
          .thenAnswer((_) async => [staffSkillOne, staffSkillTwo]);
      when(mockUserService.user).thenReturn(staffWithSkills);

      await tester.pumpWidget(const TestableWidget(child: StaffSkillTab()));

      expect(find.text('Your Skills'), findsOneWidget);
    });

    testWidgets('loading indicator is shown whilst loading',
        (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;
      final mockSkillService = TestMocks.skillStaffService;

      when(mockSkillService.getSkillsForUser(staffWithSkills.id))
          .thenAnswer((_) async => [staffSkillOne, staffSkillTwo]);
      when(mockUserService.user).thenReturn(staffWithSkills);
      await tester.pumpWidget(const TestableWidget(child: StaffSkillTab()));

      expect(find.byType(LoadingIndicator), findsOneWidget);
    });

    testWidgets('shows error if one occurs', (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;
      final mockSkillService = TestMocks.skillStaffService;

      final error = Exception('Some error');

      when(mockSkillService.getSkillsForUser(staffWithSkills.id))
          .thenAnswer((_) async => throw error);
      when(mockUserService.user).thenReturn(staffWithSkills);

      await tester.pumpWidget(const TestableWidget(child: StaffSkillTab()));
      await tester.pumpAndSettle();

      expect(find.text(error.toString()), findsOneWidget);
    });
  });

  group('staff skill tab grid', () {
    testWidgets(
        'shows more than one skill category name if the user has more than one category in skills',
        (WidgetTester tester) async {
      final mockSkillService = TestMocks.skillStaffService;
      final mockUserService = TestMocks.userService;

      when(mockSkillService.getSkillsForUser(staffWithSkills.id))
          .thenAnswer((_) async => [staffSkillOne, staffSkillTwo]);
      when(mockUserService.user).thenReturn(staffWithSkills);

      await tester.pumpWidget(const TestableWidget(child: StaffSkillTab()));
      await tester.pumpAndSettle();

      expect(find.text(staffSkillOne.category.name), findsOneWidget);
      expect(find.text(staffSkillTwo.category.name), findsOneWidget);
    });

    testWidgets(
        'shows more than one skill category icon if the user has more than one category in skills',
        (WidgetTester tester) async {
      final mockSkillService = TestMocks.skillStaffService;
      final mockUserService = TestMocks.userService;

      when(mockSkillService.getSkillsForUser(staffWithSkills.id))
          .thenAnswer((_) async => [staffSkillOne, staffSkillTwo]);
      when(mockUserService.user).thenReturn(staffWithSkills);

      await tester.pumpWidget(const TestableWidget(child: StaffSkillTab()));
      await tester.pumpAndSettle();

      expect(find.byIcon(staffSkillOne.category.icon), findsOneWidget);
      expect(find.byIcon(staffSkillTwo.category.icon), findsOneWidget);
    });

    testWidgets('shows more than one skill if the user has more than one',
        (WidgetTester tester) async {
      final mockSkillService = TestMocks.skillStaffService;
      final mockUserService = TestMocks.userService;

      when(mockSkillService.getSkillsForUser(staffWithSkills.id))
          .thenAnswer((_) async => [staffSkillOne, staffSkillTwo]);
      when(mockUserService.user).thenReturn(staffWithSkills);

      await tester.pumpWidget(const TestableWidget(child: StaffSkillTab()));
      await tester.pumpAndSettle();

      expect(find.byType(StaffSkillCard), findsNWidgets(2));
    });

    testWidgets('shows no card widgets if the user has no skills',
        (WidgetTester tester) async {
      final mockSkillService = TestMocks.skillStaffService;
      final mockUserService = TestMocks.userService;

      when(mockSkillService.getSkillsForUser(staffWithNoSkills.id))
          .thenAnswer((_) async => []);
      when(mockUserService.user).thenReturn(staffWithNoSkills);

      await tester.pumpWidget(const TestableWidget(child: StaffSkillTab()));
      await tester.pumpAndSettle();

      expect(find.byType(StaffSkillCard), findsNothing);
    });

    testWidgets('shows text informing the user they have no skills if true',
        (WidgetTester tester) async {
      final mockSkillService = TestMocks.skillStaffService;
      final mockUserService = TestMocks.userService;

      when(mockSkillService.getSkillsForUser(staffWithNoSkills.id))
          .thenAnswer((_) async => []);
      when(mockUserService.user).thenReturn(staffWithNoSkills);

      await tester.pumpWidget(const TestableWidget(child: StaffSkillTab()));
      await tester.pumpAndSettle();

      expect(
          find.textContaining('You have no registered skills'), findsOneWidget);
    });
  });

  group('staff skill card', () {
    setUp(() {
      TestMocks.userService;
      TestMocks.skillStaffService;
    });

    testWidgets('shows the skill name', (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: StaffSkillCard(
          skill: staffSkillOne,
        ),
      ));

      expect(find.text(staffSkillOne.name), findsOneWidget);
    });

    testWidgets('shows the skill rating', (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: StaffSkillCard(
          skill: staffSkillOne,
        ),
      ));

      final lengthOfStars = staffSkillOne.rating.toInt();

      expect(find.byIcon(Icons.star), findsNWidgets(lengthOfStars));
    });

    testWidgets('shows the skill expiry if it has one',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: StaffSkillCard(
          skill: staffSkillOne,
        ),
      ));

      final formattedDate = Dates.formatUI(staffSkillOne.expires!);

      expect(find.text(formattedDate), findsOneWidget);
    });

    testWidgets('shows the no expiry if no skill expiry',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: StaffSkillCard(
          skill: staffSkillNoExpiry,
        ),
      ));

      expect(find.text('No Expiry'), findsOneWidget);
    });
  });
}
