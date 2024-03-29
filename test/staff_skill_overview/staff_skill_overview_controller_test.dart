import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/home_controller.dart';
import 'package:ssa_app/app/controllers/staff_skill_overview_controller.dart';
import 'package:ssa_app/app/routes/app_route_parameters.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_overview_page/staff_skill_overview_page.dart';
import 'package:ssa_app/app/ui/utils/dates.dart';

import '../mocks/data.dart';
import '../mocks/mocks.dart';
import '../testable_widget.dart';

void main() {
  final staffOne = TestData.mockStaffWithNonExpirySkills;
  final basicSkill = TestData.mockSkillOne;
  final skillWithExpiry = TestData.mockStaffSkillOneWithExpiry;

  final binding = BindingsBuilder(() {
    Get.lazyPut<HomeController>(() => HomeController());
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

  test('controller init should call get skill', () async {
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

    // this inits the controller
    Get.find<StaffSkillOverviewController>();

    verify(mockStaffSkillService.getById(1)).called(1);
  });

  group('format date method', () {
    test('should return no expiry if date param is null', () async {
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

      // this inits the controller
      final controller = Get.find<StaffSkillOverviewController>();

      final value = controller.formatDate(null);

      expect(value, 'No Expiry');
    });

    test('should return the formatted date param is valid', () async {
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

      // this inits the controller
      final controller = Get.find<StaffSkillOverviewController>();

      final value = controller.formatDate(DateTime.now());

      expect(value, Dates.formatUI(DateTime.now()));
    });
  });

  group('increment rating method', () {
    test('should increment the rating value', () async {
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

      // this inits the controller and sets the skill
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill('1');

      controller.rating.value = 3;
      expect(controller.rating.value, 3);

      controller.incrementRating();
      expect(controller.rating.value, 4);
    });

    test('should not increment the rating value higher than 5', () async {
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

      // this inits the controller and sets the skill
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill('1');

      controller.rating.value = 5;
      expect(controller.rating.value, 5);

      controller.incrementRating();
      expect(controller.rating.value, 5);
    });
  });

  group('decrement rating method', () {
    test('should decrement the rating value', () async {
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

      // this inits the controller and sets the skill
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill('1');

      controller.rating.value = 3;
      expect(controller.rating.value, 3);

      controller.decrementRating();
      expect(controller.rating.value, 2);
    });
    test('should not decrement the rating value less than 0', () async {
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

      // this inits the controller and sets the skill
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill('1');

      controller.rating.value = 0;
      expect(controller.rating.value, 0);

      controller.decrementRating();
      expect(controller.rating.value, 0);
    });
  });

  group('set is edited method', () {
    test('does not set edited if no rating or expiry passed', () async {
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

      // this inits the controller and sets the skill
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill('1');

      expect(controller.isEdited.value, false);

      controller.setIsEdited();

      expect(controller.isEdited.value, false);
    });

    test('sets edited to true if the rating has changed', () async {
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

      // this inits the controller and sets the skill
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill('1');
      controller.rating.value = skillWithExpiry.rating;

      expect(controller.isEdited.value, false);
      expect(controller.rating.value, skillWithExpiry.rating);

      controller.setIsEdited(newRating: skillWithExpiry.rating + 1);
      expect(controller.isEdited.value, true);
    });

    test(
        'sets edited to false if the rating has changed back to original value',
        () async {
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

      // this inits the controller and sets the skill
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill('1');
      controller.rating.value = skillWithExpiry.rating;

      expect(controller.isEdited.value, false);
      expect(controller.rating.value, skillWithExpiry.rating);

      controller.setIsEdited(newRating: skillWithExpiry.rating + 1);
      expect(controller.isEdited.value, true);

      controller.setIsEdited(newRating: skillWithExpiry.rating);
      expect(controller.isEdited.value, false);
    });

    test('sets edited to true if the expiry has changed', () async {
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

      // this inits the controller and sets the skill
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill('1');
      final dateNow = skillWithExpiry.expires;
      controller.expires.value = dateNow;

      expect(controller.isEdited.value, false);
      expect(controller.expires.value, dateNow);

      controller.setIsEdited(newExpiry: dateNow!.add(const Duration(days: 1)));

      expect(controller.isEdited.value, true);
    });

    test(
        'sets edited to false if the expiry has changed back to original value',
        () async {
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

      // this inits the controller and sets the skill
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill('1');
      controller.expires.value = skillWithExpiry.expires;

      expect(controller.isEdited.value, false);
      expect(controller.expires.value, skillWithExpiry.expires);

      controller.setIsEdited(
          newExpiry: skillWithExpiry.expires!.add(const Duration(days: 1)));
      expect(controller.isEdited.value, true);

      controller.setIsEdited(newExpiry: skillWithExpiry.expires);
      expect(controller.isEdited.value, false);
    });
  });

  group('save method', () {
    testWidgets('does nothing if not edited skill', (tester) async {
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

      // need to pump for snackbar
      await tester
          .pumpWidget(const TestableWidget(child: StaffSkillOverviewPage()));
      await tester.pumpAndSettle();

      // this inits the controller and sets the skill
      final controller = Get.find<StaffSkillOverviewController>();

      await controller.saveEditedSkill();
      // let the snackbar run
      await tester.pump(const Duration(seconds: 5));

      verifyNever(mockStaffSkillService.update(any));
      verifyNever(mockStaffSkillService.create(any));
    });

    testWidgets('calls save edited if edit parameter is true', (tester) async {
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

      when(mockStaffSkillService.update(any))
          .thenAnswer((_) async => skillWithExpiry);

      // need to pump for snackbar
      await tester
          .pumpWidget(const TestableWidget(child: StaffSkillOverviewPage()));
      await tester.pumpAndSettle();

      // this inits the controller and sets the skill
      final controller = Get.find<StaffSkillOverviewController>();
      controller.skill = skillWithExpiry.obs;
      controller.rating.value = 3;
      controller.expires.value = null;
      controller.isEdited.value = true;

      await controller.saveEditedSkill();
      // let the snackbar run
      await tester.pump(const Duration(seconds: 5));

      verify(mockStaffSkillService.update(any)).called(1);
      verifyNever(mockStaffSkillService.create(any));
    });

    testWidgets('calls save new if assign parameter is true', (tester) async {
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

      when(mockStaffSkillService.create(any))
          .thenAnswer((_) async => skillWithExpiry);

      // need to pump for snackbar
      await tester
          .pumpWidget(const TestableWidget(child: StaffSkillOverviewPage()));
      await tester.pumpAndSettle();

      // this inits the controller and sets the skill
      final controller = Get.find<StaffSkillOverviewController>();
      controller.skill = skillWithExpiry.obs;
      controller.rating.value = 3;
      controller.expires.value = null;
      controller.isEdited.value = true;

      await controller.saveEditedSkill();
      // let the snackbar run
      await tester.pump(const Duration(seconds: 5));

      verifyNever(mockStaffSkillService.update(any));
      verify(mockStaffSkillService.create(any)).called(1);
    });
  });
}
