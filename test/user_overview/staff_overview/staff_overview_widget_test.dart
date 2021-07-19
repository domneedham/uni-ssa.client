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

import '../../testable_widget.dart';
import 'staff_overview_test_data.dart';
import '../../mocks/mocks.dart';

void main() {
  final binding = BindingsBuilder(() {
    Get.lazyPut<StaffOverviewController>(() => StaffOverviewController());
  });

  void setUpSuccess() {
    Get.parameters = {"id": "1"};
  }

  void setUpFailure() {
    Get.parameters = {"id": "-1"};
  }

  setUp(() async {
    Get.testMode = true;
    binding.builder();

    final mockUserRepo = TestMocks.userRepository;
    final _ = TestMocks.skillStaffRepository;

    when(mockUserRepo.getStaffById(1)).thenAnswer((_) async => mockStaffOne);
    when(mockUserRepo.getManagerById(1)).thenAnswer((_) async => mockManager);
    when(mockUserRepo.getStaffById(-1))
        .thenAnswer((_) async => throw mockError);
    when(mockUserRepo.getManagerById(-1))
        .thenAnswer((_) async => throw mockError);
  });

  tearDown(() async {
    Get.reset();
  });

  group('page', () {
    testWidgets('shows a loading indicator whilst loading',
        (WidgetTester tester) async {
      setUpSuccess();
      await tester.pumpWidget(TestableWidget(child: StaffOverviewPage()));

      expect(find.byType(LoadingIndicator), findsOneWidget);
    });

    testWidgets('shows the error text if an error occurs',
        (WidgetTester tester) async {
      setUpFailure();

      await tester.pumpWidget(TestableWidget(child: StaffOverviewPage()));
      await tester.pumpAndSettle();

      expect(find.text(mockError.toString()), findsOneWidget);
    });

    testWidgets('shows the profile header of the staff if successful',
        (WidgetTester tester) async {
      setUpSuccess();
      await tester.pumpWidget(TestableWidget(child: StaffOverviewPage()));
      await tester.pumpAndSettle();

      expect(find.byType(UserProfileHeader), findsOneWidget);
    });
  });

  group('manager section', () {
    testWidgets('shows text to inform the user what the section is about',
        (WidgetTester tester) async {
      setUpSuccess();
      final controller = Get.find<StaffOverviewController>();

      await tester.pumpWidget(
        TestableWidget(
          child: StaffOverviewManagerSection(
            staff: mockStaffOne,
            future: (_) => controller.getManagerById(mockStaffOne.id),
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

        final controller = Get.find<StaffOverviewController>();

        await tester.pumpWidget(
          TestableWidget(
            child: StaffOverviewManagerSection(
              staff: mockStaffOne,
              future: (_) => controller.getManagerById(mockStaffOne.id),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(UserListTile), findsOneWidget);
      });

      testWidgets('shows a loading user list tile whilst loading',
          (WidgetTester tester) async {
        setUpSuccess();
        final controller = Get.find<StaffOverviewController>();

        await tester.pumpWidget(
          TestableWidget(
            child: StaffOverviewManagerSection(
              staff: mockStaffOne,
              future: (_) => controller.getManagerById(mockStaffOne.id),
            ),
          ),
        );

        expect(find.byType(LoadingUserListTile), findsOneWidget);
      });

      testWidgets('shows a loading failed user list tile if an error occurs',
          (WidgetTester tester) async {
        setUpSuccess();

        final controller = Get.find<StaffOverviewController>();

        await tester.pumpWidget(
          TestableWidget(
            child: StaffOverviewManagerSection(
              staff: mockStaffBadManager,
              future: (_) => controller.getManagerById(-1),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(LoadingFailedUserListTile), findsOneWidget);
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
            staff: mockStaffOne,
            future: (ids) => controller.getSkillsByIds(ids),
            subtitleFunction: (_) =>
                controller.expiryTextWidget(mockSkillNoExpiry),
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
              skill: mockSkillNoExpiry,
              subtitle: controller.expiryTextWidget(mockSkillNoExpiry),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text(mockSkillNoExpiry.name), findsOneWidget);
      });

      testWidgets('shows the category icon', (WidgetTester tester) async {
        setUpSuccess();
        final controller = Get.find<StaffOverviewController>();

        await tester.pumpWidget(
          TestableWidget(
            child: StaffOverviewSkillListTile(
              skill: mockSkillNoExpiry,
              subtitle: controller.expiryTextWidget(mockSkillNoExpiry),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byIcon(mockSkillNoExpiry.category.icon), findsOneWidget);
      });

      testWidgets('shows no expiry if the skill has no expiry for the staff',
          (WidgetTester tester) async {
        setUpSuccess();
        final controller = Get.find<StaffOverviewController>();

        await tester.pumpWidget(
          TestableWidget(
            child: StaffOverviewSkillListTile(
              skill: mockSkillNoExpiry,
              subtitle: controller.expiryTextWidget(mockSkillNoExpiry),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text("No Expiry"), findsOneWidget);
      });

      testWidgets(
          'shows expires on date if the skill is not expired for the staff',
          (WidgetTester tester) async {
        setUpSuccess();
        final controller = Get.find<StaffOverviewController>();

        await tester.pumpWidget(
          TestableWidget(
            child: StaffOverviewSkillListTile(
              skill: mockSkillNoExpiry,
              subtitle: controller.expiryTextWidget(mockSkillExpiryInTime),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final text = controller.expiryTextWidget(mockSkillExpiryInTime).data;

        expect(find.text(text!), findsOneWidget);
      });

      testWidgets('shows expired date if the skill is expired for the staff',
          (WidgetTester tester) async {
        setUpSuccess();
        final controller = Get.find<StaffOverviewController>();

        await tester.pumpWidget(
          TestableWidget(
            child: StaffOverviewSkillListTile(
              skill: mockSkillNoExpiry,
              subtitle: controller.expiryTextWidget(mockSkillExpiryExpired),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final text = controller.expiryTextWidget(mockSkillExpiryExpired).data;

        expect(find.text(text!), findsOneWidget);
      });
    });
  });
}
