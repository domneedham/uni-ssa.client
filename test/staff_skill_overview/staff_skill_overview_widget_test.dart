import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/staff_skill_overview_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_category_title.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_overview_page/staff_skill_overview_body.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_overview_page/staff_skill_overview_expiry.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_overview_page/staff_skill_overview_page.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_overview_page/staff_skill_overview_rating.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_overview_page/staff_skill_overview_save_button.dart';

import '../mocks/mocks.dart';
import '../testable_widget.dart';
import 'staff_skill_overview_test_data.dart';

void main() {
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
      final mockUserRepo = TestMocks.userRepository;
      final mockSkillRepo = TestMocks.skillStaffRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      await tester.pumpWidget(TestableWidget(child: StaffSkillOverviewPage()));

      expect(find.text("Test Skill"), findsOneWidget);
    });

    testWidgets('appbar title shows the right title if no parameters set',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;
      final mockSkillRepo = TestMocks.skillStaffRepository;

      Get.parameters = {"id": "1"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      await tester.pumpWidget(TestableWidget(child: StaffSkillOverviewPage()));

      expect(find.text("Skill Overview"), findsOneWidget);
    });

    testWidgets('loading indicator is shown whilst loading',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;
      final mockSkillRepo = TestMocks.skillStaffRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      await tester.pumpWidget(TestableWidget(child: StaffSkillOverviewPage()));

      expect(find.byType(LoadingIndicator), findsOneWidget);
    });

    testWidgets('shows error if one occurs', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;
      final mockSkillRepo = TestMocks.skillStaffRepository;

      Get.parameters = {"id": "1"};
      final error = Exception("Some error");

      when(mockSkillRepo.getSkillById(1)).thenAnswer((_) async => throw error);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      await tester.pumpWidget(TestableWidget(child: StaffSkillOverviewPage()));
      await tester.pumpAndSettle();

      expect(find.text(error.toString()), findsOneWidget);
    });
  });

  group('staff skill overview body', () {
    testWidgets('shows the skill category title', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;
      final mockSkillRepo = TestMocks.skillStaffRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // make sure controller fetches skill before rendering
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("1");

      await tester.pumpWidget(TestableWidget(child: StaffSkillOverviewBody()));

      expect(find.byType(SkillCategoryTitle), findsOneWidget);
    });

    testWidgets('shows the skill rating', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;
      final mockSkillRepo = TestMocks.skillStaffRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // make sure controller fetches skill before rendering
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("1");

      await tester.pumpWidget(TestableWidget(child: StaffSkillOverviewBody()));

      expect(find.byType(StaffSkillOverviewRating), findsOneWidget);
    });

    testWidgets('shows the skill expiry', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;
      final mockSkillRepo = TestMocks.skillStaffRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // make sure controller fetches skill before rendering
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("1");

      await tester.pumpWidget(TestableWidget(child: StaffSkillOverviewBody()));

      expect(find.byType(StaffSkillOverviewExpiry), findsOneWidget);
    });

    testWidgets('shows the save button', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;
      final mockSkillRepo = TestMocks.skillStaffRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // make sure controller fetches skill before rendering
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("1");

      await tester.pumpWidget(TestableWidget(child: StaffSkillOverviewBody()));

      expect(find.byType(StaffSkillOverviewSaveButton), findsOneWidget);
    });
  });

  group('staff skill overview rating', () {
    testWidgets('shows a decrement button', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;
      final mockSkillRepo = TestMocks.skillStaffRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // make sure controller fetches skill before rendering
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("1");

      await tester
          .pumpWidget(TestableWidget(child: StaffSkillOverviewRating()));

      expect(find.byIcon(Icons.remove), findsOneWidget);
    });

    testWidgets('shows a increment button', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;
      final mockSkillRepo = TestMocks.skillStaffRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // make sure controller fetches skill before rendering
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("1");

      await tester
          .pumpWidget(TestableWidget(child: StaffSkillOverviewRating()));

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('shows filled in stars for the rating',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;
      final mockSkillRepo = TestMocks.skillStaffRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // make sure controller fetches skill before rendering
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("1");
      controller.rating.value = 3;

      await tester
          .pumpWidget(TestableWidget(child: StaffSkillOverviewRating()));

      expect(find.byIcon(Icons.star), findsNWidgets(3));
    });

    testWidgets('shows border stars for the rest of the rating up to 5',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;
      final mockSkillRepo = TestMocks.skillStaffRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // make sure controller fetches skill before rendering
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("1");
      controller.rating.value = 3;

      await tester
          .pumpWidget(TestableWidget(child: StaffSkillOverviewRating()));

      expect(find.byIcon(Icons.star_border), findsNWidgets(2));
    });

    testWidgets('refreshes the filled in icons on rating change',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;
      final mockSkillRepo = TestMocks.skillStaffRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // make sure controller fetches skill before rendering
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("1");
      controller.rating.value = 3;

      await tester
          .pumpWidget(TestableWidget(child: StaffSkillOverviewRating()));

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
      final mockUserRepo = TestMocks.userRepository;
      final mockSkillRepo = TestMocks.skillStaffRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // make sure controller fetches skill before rendering
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("1");

      await tester
          .pumpWidget(TestableWidget(child: StaffSkillOverviewExpiry()));

      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
    });

    testWidgets('shows a the current expiry', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;
      final mockSkillRepo = TestMocks.skillStaffRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // make sure controller fetches skill before rendering
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("1");

      await tester
          .pumpWidget(TestableWidget(child: StaffSkillOverviewExpiry()));

      expect(find.text(controller.formatDate(mockSkillWithExpiry.expires)),
          findsOneWidget);
    });

    testWidgets('shows the datepicker on button click',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;
      final mockSkillRepo = TestMocks.skillStaffRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // make sure controller fetches skill before rendering
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("1");

      await tester
          .pumpWidget(TestableWidget(child: StaffSkillOverviewExpiry()));

      await tester.tap(find.byIcon(Icons.calendar_today));
      await tester.pumpAndSettle();

      expect(find.byType(DatePickerDialog), findsOneWidget);
    });

    testWidgets('updates the date shown on date change',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;
      final mockSkillRepo = TestMocks.skillStaffRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillNoExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // make sure controller fetches skill before rendering
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("2");

      await tester
          .pumpWidget(TestableWidget(child: StaffSkillOverviewExpiry()));

      // should find skill with no expiry - showing 'No Expiry'
      expect(find.text(controller.formatDate(mockSkillNoExpiry.expires)),
          findsOneWidget);

      // change expires in controller to tomorrow
      final newDate = DateTime.now().add(Duration(days: 1));
      controller.expires.value = newDate;

      await tester.pumpAndSettle();

      // text should now display new date
      expect(find.text(controller.formatDate(newDate)), findsOneWidget);
    });
  });

  group('staff skill overview save button', () {
    testWidgets('shows save text', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;
      final mockSkillRepo = TestMocks.skillStaffRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // make sure controller fetches skill before rendering
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("1");

      await tester
          .pumpWidget(TestableWidget(child: StaffSkillOverviewSaveButton()));

      expect(find.text('Save'), findsOneWidget);
    });
  });
}
