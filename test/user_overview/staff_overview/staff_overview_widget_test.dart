import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/staff_overview_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/global_widgets/user_list_tile.dart';
import 'package:ssa_app/app/ui/global_widgets/user_profile_header.dart';
import 'package:ssa_app/app/ui/pages/user_overview/staff_overview/staff_overview_manager_section.dart';
import 'package:ssa_app/app/ui/pages/user_overview/staff_overview/staff_overview_page.dart';
import 'package:ssa_app/app/ui/pages/user_overview/staff_overview/staff_overview_skill_list.dart';
import 'package:ssa_app/app/ui/pages/user_overview/staff_overview/staff_overview_skill_list_tile.dart';

import '../../mocks/data.dart';
import '../../mocks/mocks.dart';
import '../../testable_widget.dart';

void main() {
  final skillWithNoExpiry = TestData.mockStaffSkillOneWithNoExpiry;
  final skillWithExpiry = TestData.mockStaffSkillOneWithExpiry;
  final skillWithExpiryExpired = TestData.mockStaffSkillOneWithExpiryExpired;
  final managerOne = TestData.mockManagerWithStaff;
  final staffOne = TestData.mockStaffWithExpirySkills;
  final mockError = Exception('Exception');

  final binding = BindingsBuilder(() {
    Get.lazyPut<StaffOverviewController>(() => StaffOverviewController());
  });

  void setUpSuccess() {
    Get.parameters = {'id': '1'};
  }

  void setUpFailure() {
    Get.parameters = {'id': '-1'};
  }

  setUp(() async {
    Get.testMode = true;
    binding.builder();

    final mockUserService = TestMocks.userService;
    final _ = TestMocks.skillStaffService;

    when(mockUserService.getStaffById(1)).thenAnswer((_) async => staffOne);
    when(mockUserService.getManagerById(1)).thenAnswer((_) async => managerOne);
    when(mockUserService.getStaffById(-1))
        .thenAnswer((_) async => throw mockError);
    when(mockUserService.getManagerById(-1))
        .thenAnswer((_) async => throw mockError);
  });

  tearDown(() async {
    Get.reset();
  });

  group('page', () {
    testWidgets('shows a loading indicator whilst loading',
        (WidgetTester tester) async {
      setUpSuccess();
      await tester.pumpWidget(const TestableWidget(child: StaffOverviewPage()));

      expect(find.byType(LoadingIndicator), findsOneWidget);
    });

    testWidgets('shows the error text if an error occurs',
        (WidgetTester tester) async {
      setUpFailure();

      await tester.pumpWidget(const TestableWidget(child: StaffOverviewPage()));
      await tester.pumpAndSettle();

      expect(find.text(mockError.toString()), findsOneWidget);
    });

    testWidgets('shows the profile header of the staff if successful',
        (WidgetTester tester) async {
      setUpSuccess();
      await tester.pumpWidget(const TestableWidget(child: StaffOverviewPage()));
      await tester.pumpAndSettle();

      expect(find.byType(UserProfileHeader), findsOneWidget);
    });
  });

  group('manager section', () {
    testWidgets('shows text to inform the user what the section is about',
        (WidgetTester tester) async {
      setUpSuccess();

      await tester.pumpWidget(
        TestableWidget(
          child: StaffOverviewManagerSection(
            staff: staffOne,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Reports To:'), findsOneWidget);
    });

    group('list tile', () {
      testWidgets('shows a user list tile if successfully loaded',
          (WidgetTester tester) async {
        setUpSuccess();

        await tester.pumpWidget(
          TestableWidget(
            child: StaffOverviewManagerSection(
              staff: staffOne,
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(UserListTile), findsOneWidget);
      });
    });
  });

  group('skill list', () {
    testWidgets('shows text to inform the user what the section is about',
        (WidgetTester tester) async {
      setUpSuccess();

      final controller = Get.find<StaffOverviewController>();

      await tester.pumpWidget(
        TestableWidget(
          child: StaffOverviewSkillList(
            staff: staffOne,
            subtitleFunction: (_) =>
                controller.expiryTextWidget(skillWithNoExpiry),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Skill List:'), findsOneWidget);
    });

    group('list tile', () {
      testWidgets('shows the skill name', (WidgetTester tester) async {
        setUpSuccess();
        final controller = Get.find<StaffOverviewController>();

        await tester.pumpWidget(
          TestableWidget(
            child: StaffOverviewSkillListTile(
              skill: skillWithNoExpiry,
              subtitle: controller.expiryTextWidget(skillWithNoExpiry),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text(skillWithNoExpiry.name), findsOneWidget);
      });

      testWidgets('shows the category icon', (WidgetTester tester) async {
        setUpSuccess();
        final controller = Get.find<StaffOverviewController>();

        await tester.pumpWidget(
          TestableWidget(
            child: StaffOverviewSkillListTile(
              skill: skillWithNoExpiry,
              subtitle: controller.expiryTextWidget(skillWithNoExpiry),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byIcon(skillWithNoExpiry.category.icon), findsOneWidget);
      });

      testWidgets('shows no expiry if the skill has no expiry for the staff',
          (WidgetTester tester) async {
        setUpSuccess();
        final controller = Get.find<StaffOverviewController>();

        await tester.pumpWidget(
          TestableWidget(
            child: StaffOverviewSkillListTile(
              skill: skillWithNoExpiry,
              subtitle: controller.expiryTextWidget(skillWithNoExpiry),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('No Expiry'), findsOneWidget);
      });

      testWidgets(
          'shows expires on date if the skill is not expired for the staff',
          (WidgetTester tester) async {
        setUpSuccess();
        final controller = Get.find<StaffOverviewController>();

        await tester.pumpWidget(
          TestableWidget(
            child: StaffOverviewSkillListTile(
              skill: skillWithExpiry,
              subtitle: controller.expiryTextWidget(skillWithExpiry),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final text = controller.expiryTextWidget(skillWithExpiry).data;

        expect(find.text(text!), findsOneWidget);
      });

      testWidgets('shows expired date if the skill is expired for the staff',
          (WidgetTester tester) async {
        setUpSuccess();
        final controller = Get.find<StaffOverviewController>();

        await tester.pumpWidget(
          TestableWidget(
            child: StaffOverviewSkillListTile(
              skill: skillWithExpiryExpired,
              subtitle: controller.expiryTextWidget(skillWithExpiryExpired),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final text = controller.expiryTextWidget(skillWithExpiryExpired).data;

        expect(find.text(text!), findsOneWidget);
      });
    });
  });
}
