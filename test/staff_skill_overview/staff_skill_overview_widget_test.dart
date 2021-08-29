import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/staff_skill_overview_controller.dart';
import 'package:ssa_app/app/routes/app_route_parameters.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_category_title.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_overview_page/staff_skill_overview_body.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_overview_page/staff_skill_overview_expiry.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_overview_page/staff_skill_overview_page.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_overview_page/staff_skill_overview_rating.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_overview_page/staff_skill_overview_save_button.dart';

import '../mocks/data.dart';
import '../mocks/mocks.dart';
import '../testable_widget.dart';

void main() {
  final staffOne = TestData.mockStaffWithNonExpirySkills;
  final basicSkill = TestData.mockSkillOne;
  final skillWithExpiry = TestData.mockStaffSkillOneWithExpiry;
  final skillWithNoExpiry = TestData.mockStaffSkillOneWithNoExpiry;

  final binding = BindingsBuilder(() {
    Get.lazyPut<StaffSkillOverviewController>(
        () => StaffSkillOverviewController());
  });

  setUp(() async {
    Get.testMode = true;
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  group('staff skill overview page', () {
    testWidgets('appbar title shows the right title if parameters set',
        (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;
      final mockStaffSkillService = TestMocks.skillStaffService;
      final _ = TestMocks.skillService;

      Get.parameters = const StaffSkillOverviewParameters(
        id: '1',
        name: 'Test Skill',
        edit: AppRouteParameterValues.TRUE,
      ).toMap;

      when(mockStaffSkillService.getById(1))
          .thenAnswer((_) async => skillWithExpiry);
      when(mockUserService.user).thenReturn(staffOne);

      await tester
          .pumpWidget(const TestableWidget(child: StaffSkillOverviewPage()));

      expect(find.text('Test Skill'), findsOneWidget);
    });

    testWidgets('loading indicator is shown whilst loading',
        (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;
      final mockStaffSkillService = TestMocks.skillStaffService;
      final _ = TestMocks.skillService;

      Get.parameters = const StaffSkillOverviewParameters(
        id: '1',
        name: 'Test Skill',
        edit: AppRouteParameterValues.TRUE,
      ).toMap;

      when(mockStaffSkillService.getById(1))
          .thenAnswer((_) async => skillWithExpiry);
      when(mockUserService.user).thenReturn(staffOne);

      await tester
          .pumpWidget(const TestableWidget(child: StaffSkillOverviewPage()));

      expect(find.byType(LoadingIndicator), findsOneWidget);
    });

    testWidgets('shows error if one occurs', (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;
      final mockStaffSkillService = TestMocks.skillStaffService;
      final _ = TestMocks.skillService;

      Get.parameters = const StaffSkillOverviewParameters(
        id: '1',
        name: 'Test Skill',
        edit: AppRouteParameterValues.TRUE,
      ).toMap;
      final error = Exception('Some error');

      when(mockStaffSkillService.getById(1))
          .thenAnswer((_) async => throw error);
      when(mockUserService.user).thenReturn(staffOne);

      await tester
          .pumpWidget(const TestableWidget(child: StaffSkillOverviewPage()));
      await tester.pumpAndSettle();

      expect(find.text(error.toString()), findsOneWidget);
    });
  });

  group('staff skill overview body', () {
    testWidgets('shows the skill category title', (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;
      final mockStaffSkillService = TestMocks.skillStaffService;
      final _ = TestMocks.skillService;

      Get.parameters = const StaffSkillOverviewParameters(
        id: '1',
        name: 'Test Skill',
        edit: AppRouteParameterValues.TRUE,
      ).toMap;

      when(mockStaffSkillService.getById(1))
          .thenAnswer((_) async => skillWithExpiry);
      when(mockUserService.user).thenReturn(staffOne);

      // make sure controller fetches skill before rendering
      Get.find<StaffSkillOverviewController>();

      await tester
          .pumpWidget(const TestableWidget(child: StaffSkillOverviewBody()));

      expect(find.byType(SkillCategoryTitle), findsOneWidget);
    });

    testWidgets('shows the skill rating', (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;
      final mockStaffSkillService = TestMocks.skillStaffService;
      final _ = TestMocks.skillService;

      Get.parameters = const StaffSkillOverviewParameters(
        id: '1',
        name: 'Test Skill',
        edit: AppRouteParameterValues.TRUE,
      ).toMap;

      when(mockStaffSkillService.getById(1))
          .thenAnswer((_) async => skillWithExpiry);
      when(mockUserService.user).thenReturn(staffOne);

      // make sure controller fetches skill before rendering
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill('1');

      await tester
          .pumpWidget(const TestableWidget(child: StaffSkillOverviewBody()));

      expect(find.byType(StaffSkillOverviewRating), findsOneWidget);
    });

    testWidgets('shows the skill expiry', (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;
      final mockStaffSkillService = TestMocks.skillStaffService;
      final _ = TestMocks.skillService;

      Get.parameters = const StaffSkillOverviewParameters(
        id: '1',
        name: 'Test Skill',
        edit: AppRouteParameterValues.TRUE,
      ).toMap;

      when(mockStaffSkillService.getById(1))
          .thenAnswer((_) async => skillWithExpiry);
      when(mockUserService.user).thenReturn(staffOne);

      // make sure controller fetches skill before rendering
      Get.find<StaffSkillOverviewController>();

      await tester
          .pumpWidget(const TestableWidget(child: StaffSkillOverviewBody()));

      expect(find.byType(StaffSkillOverviewExpiry), findsOneWidget);
    });

    testWidgets('shows the save button', (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;
      final mockStaffSkillService = TestMocks.skillStaffService;
      final _ = TestMocks.skillService;

      Get.parameters = const StaffSkillOverviewParameters(
        id: '1',
        name: 'Test Skill',
        edit: AppRouteParameterValues.TRUE,
      ).toMap;

      when(mockStaffSkillService.getById(1))
          .thenAnswer((_) async => skillWithExpiry);
      when(mockUserService.user).thenReturn(staffOne);

      // make sure controller fetches skill before rendering
      Get.find<StaffSkillOverviewController>();

      await tester
          .pumpWidget(const TestableWidget(child: StaffSkillOverviewBody()));

      expect(find.byType(StaffSkillOverviewSaveButton), findsOneWidget);
    });
  });

  group('staff skill overview rating', () {
    testWidgets('shows a decrement button', (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;
      final mockStaffSkillService = TestMocks.skillStaffService;
      final _ = TestMocks.skillService;

      Get.parameters = const StaffSkillOverviewParameters(
        id: '1',
        name: 'Test Skill',
        edit: AppRouteParameterValues.TRUE,
      ).toMap;

      when(mockStaffSkillService.getById(1))
          .thenAnswer((_) async => skillWithExpiry);
      when(mockUserService.user).thenReturn(staffOne);

      // make sure controller fetches skill before rendering
      Get.find<StaffSkillOverviewController>();

      await tester
          .pumpWidget(const TestableWidget(child: StaffSkillOverviewRating()));

      expect(find.byIcon(Icons.remove), findsOneWidget);
    });

    testWidgets('shows a increment button', (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;
      final mockStaffSkillService = TestMocks.skillStaffService;
      final _ = TestMocks.skillService;

      Get.parameters = const StaffSkillOverviewParameters(
        id: '1',
        name: 'Test Skill',
        edit: AppRouteParameterValues.TRUE,
      ).toMap;

      when(mockStaffSkillService.getById(1))
          .thenAnswer((_) async => skillWithExpiry);
      when(mockUserService.user).thenReturn(staffOne);

      // make sure controller fetches skill before rendering
      Get.find<StaffSkillOverviewController>();

      await tester
          .pumpWidget(const TestableWidget(child: StaffSkillOverviewRating()));

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('shows filled in stars for the rating if skill has one',
        (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;
      final mockStaffSkillService = TestMocks.skillStaffService;
      final _ = TestMocks.skillService;

      Get.parameters = const StaffSkillOverviewParameters(
        id: '1',
        name: 'Test Skill',
        edit: AppRouteParameterValues.TRUE,
      ).toMap;

      when(mockStaffSkillService.getById(1))
          .thenAnswer((_) async => skillWithExpiry);
      when(mockUserService.user).thenReturn(staffOne);

      // make sure controller fetches skill before rendering
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill('1');
      controller.rating.value = 3;

      await tester
          .pumpWidget(const TestableWidget(child: StaffSkillOverviewRating()));

      expect(find.byIcon(Icons.star), findsNWidgets(3));
    });

    testWidgets('shows no filled in stars for the rating if assigning',
        (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;
      final mockStaffSkillService = TestMocks.skillStaffService;
      final mockSkillService = TestMocks.skillService;

      Get.parameters = const StaffSkillOverviewParameters(
        id: '1',
        name: 'Test Skill',
        assign: AppRouteParameterValues.TRUE,
      ).toMap;

      when(mockStaffSkillService.getById(1))
          .thenAnswer((_) async => skillWithExpiry);
      when(mockSkillService.getById(1)).thenAnswer((_) async => basicSkill);
      when(mockUserService.user).thenReturn(staffOne);

      // make sure controller fetches skill before rendering
      Get.find<StaffSkillOverviewController>();

      await tester
          .pumpWidget(const TestableWidget(child: StaffSkillOverviewRating()));

      expect(find.byIcon(Icons.star), findsNothing);
    });

    testWidgets('shows border stars for the rest of the rating up to 5',
        (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;
      final mockStaffSkillService = TestMocks.skillStaffService;
      final _ = TestMocks.skillService;

      Get.parameters = const StaffSkillOverviewParameters(
        id: '1',
        name: 'Test Skill',
        edit: AppRouteParameterValues.TRUE,
      ).toMap;

      when(mockStaffSkillService.getById(1))
          .thenAnswer((_) async => skillWithExpiry);
      when(mockUserService.user).thenReturn(staffOne);

      // make sure controller fetches skill before rendering
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill('1');
      controller.rating.value = 3;

      await tester
          .pumpWidget(const TestableWidget(child: StaffSkillOverviewRating()));

      expect(find.byIcon(Icons.star_border), findsNWidgets(2));
    });

    testWidgets('refreshes the filled in icons on rating change',
        (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;
      final mockStaffSkillService = TestMocks.skillStaffService;
      final _ = TestMocks.skillService;

      Get.parameters = const StaffSkillOverviewParameters(
        id: '1',
        name: 'Test Skill',
        edit: AppRouteParameterValues.TRUE,
      ).toMap;

      when(mockStaffSkillService.getById(1))
          .thenAnswer((_) async => skillWithExpiry);
      when(mockUserService.user).thenReturn(staffOne);

      // make sure controller fetches skill before rendering
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill('1');
      controller.rating.value = 3;

      await tester
          .pumpWidget(const TestableWidget(child: StaffSkillOverviewRating()));

      expect(find.byIcon(Icons.star), findsNWidgets(3));

      // set new value for rating
      controller.rating.value = 5;
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.star), findsNWidgets(5));
    });
  });

  group('staff skill overview expiry', () {
    testWidgets('shows a calendar icon as an icon button',
        (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;
      final mockStaffSkillService = TestMocks.skillStaffService;
      final _ = TestMocks.skillService;

      Get.parameters = const StaffSkillOverviewParameters(
        id: '1',
        name: 'Test Skill',
        edit: AppRouteParameterValues.TRUE,
      ).toMap;

      when(mockStaffSkillService.getById(1))
          .thenAnswer((_) async => skillWithExpiry);
      when(mockUserService.user).thenReturn(staffOne);

      // make sure controller fetches skill before rendering
      Get.find<StaffSkillOverviewController>();

      await tester
          .pumpWidget(const TestableWidget(child: StaffSkillOverviewExpiry()));

      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
    });

    testWidgets('shows the current expiry', (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;
      final mockStaffSkillService = TestMocks.skillStaffService;
      final _ = TestMocks.skillService;

      Get.parameters = const StaffSkillOverviewParameters(
        id: '1',
        name: 'Test Skill',
        edit: AppRouteParameterValues.TRUE,
      ).toMap;

      when(mockStaffSkillService.getById(1))
          .thenAnswer((_) async => skillWithExpiry);
      when(mockUserService.user).thenReturn(staffOne);

      // make sure controller fetches skill before rendering
      final controller = Get.find<StaffSkillOverviewController>();

      await tester
          .pumpWidget(const TestableWidget(child: StaffSkillOverviewExpiry()));

      expect(find.text(controller.formatDate(skillWithExpiry.expires)),
          findsOneWidget);
    });

    testWidgets('shows no expiry if assigning', (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;
      final mockStaffSkillService = TestMocks.skillStaffService;
      final mockSkillService = TestMocks.skillService;

      Get.parameters = const StaffSkillOverviewParameters(
        id: '1',
        name: 'Test Skill',
        assign: AppRouteParameterValues.TRUE,
      ).toMap;

      when(mockStaffSkillService.getById(1))
          .thenAnswer((_) async => skillWithExpiry);
      when(mockSkillService.getById(1)).thenAnswer((_) async => basicSkill);
      when(mockUserService.user).thenReturn(staffOne);

      // make sure controller fetches skill before rendering
      final controller = Get.find<StaffSkillOverviewController>();

      await tester
          .pumpWidget(const TestableWidget(child: StaffSkillOverviewExpiry()));

      expect(find.text(controller.formatDate(null)), findsOneWidget);
    });

    testWidgets('shows the datepicker on button click',
        (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;
      final mockStaffSkillService = TestMocks.skillStaffService;
      final _ = TestMocks.skillService;

      Get.parameters = const StaffSkillOverviewParameters(
        id: '1',
        name: 'Test Skill',
        edit: AppRouteParameterValues.TRUE,
      ).toMap;

      when(mockStaffSkillService.getById(1))
          .thenAnswer((_) async => skillWithExpiry);
      when(mockUserService.user).thenReturn(staffOne);

      // make sure controller fetches skill before rendering
      Get.find<StaffSkillOverviewController>();

      await tester
          .pumpWidget(const TestableWidget(child: StaffSkillOverviewExpiry()));

      await tester.tap(find.byIcon(Icons.calendar_today));
      await tester.pumpAndSettle();

      expect(find.byType(DatePickerDialog), findsOneWidget);
    });

    testWidgets('updates the date shown on date change',
        (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;
      final mockStaffSkillService = TestMocks.skillStaffService;
      final _ = TestMocks.skillService;

      Get.parameters = const StaffSkillOverviewParameters(
        id: '1',
        name: 'Test Skill',
        edit: AppRouteParameterValues.TRUE,
      ).toMap;

      when(mockStaffSkillService.getById(1))
          .thenAnswer((_) async => skillWithNoExpiry);
      when(mockUserService.user).thenReturn(staffOne);

      // make sure controller fetches skill before rendering
      final controller = Get.find<StaffSkillOverviewController>();

      await tester
          .pumpWidget(const TestableWidget(child: StaffSkillOverviewExpiry()));

      // should find skill with no expiry - showing 'No Expiry'
      expect(find.text(controller.formatDate(skillWithNoExpiry.expires)),
          findsOneWidget);

      // change expires in controller to tomorrow
      final newDate = DateTime.now().add(const Duration(days: 1));
      controller.expires.value = newDate;

      await tester.pumpAndSettle();

      // text should now display new date
      expect(find.text(controller.formatDate(newDate)), findsOneWidget);
    });
  });

  group('staff skill overview save button', () {
    testWidgets('shows save text', (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;
      final mockStaffSkillService = TestMocks.skillStaffService;
      final _ = TestMocks.skillService;

      Get.parameters = const StaffSkillOverviewParameters(
        id: '1',
        name: 'Test Skill',
        edit: AppRouteParameterValues.TRUE,
      ).toMap;

      when(mockStaffSkillService.getById(1))
          .thenAnswer((_) async => skillWithExpiry);
      when(mockUserService.user).thenReturn(staffOne);

      // make sure controller fetches skill before rendering
      Get.find<StaffSkillOverviewController>();

      await tester.pumpWidget(
          const TestableWidget(child: StaffSkillOverviewSaveButton()));

      expect(find.text('Save'), findsOneWidget);
    });
  });
}
