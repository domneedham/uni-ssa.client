import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/home_controller.dart';
import 'package:ssa_app/app/controllers/staff_skill_overview_controller.dart';
import 'package:ssa_app/app/ui/utils/dates.dart';

import '../mocks/mocks.dart';
import 'staff_skill_overview_test_data.dart';

void main() {
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
    final mockSkillRepo = TestMocks.skillStaffRepository;
    final mockUserRepo = TestMocks.userRepository;

    Get.parameters = {"id": "1", "name": "Test Skill"};

    when(mockSkillRepo.getSkillById(1))
        .thenAnswer((_) async => mockSkillWithExpiry);
    when(mockUserRepo.staff).thenReturn(mockStaff);

    // this inits the controller
    Get.find<StaffSkillOverviewController>();

    verify(mockSkillRepo.getSkillById(1)).called(1);
  });

  group('format date method', () {
    test('should return no expiry if date param is null', () async {
      final mockSkillRepo = TestMocks.skillStaffRepository;
      final mockUserRepo = TestMocks.userRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // this inits the controller
      final controller = Get.find<StaffSkillOverviewController>();

      final value = controller.formatDate(null);

      expect(value, "No Expiry");
    });

    test('should return the formatted date param is valid', () async {
      final mockSkillRepo = TestMocks.skillStaffRepository;
      final mockUserRepo = TestMocks.userRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // this inits the controller
      final controller = Get.find<StaffSkillOverviewController>();

      final value = controller.formatDate(DateTime.now());

      expect(value, Dates.formatUI(DateTime.now()));
    });
  });

  group('increment rating method', () {
    test('should increment the rating value', () async {
      final mockSkillRepo = TestMocks.skillStaffRepository;
      final mockUserRepo = TestMocks.userRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // this inits the controller and sets the skill
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("1");

      controller.rating.value = 3;
      expect(controller.rating.value, 3);

      controller.incrementRating();
      expect(controller.rating.value, 4);
    });

    test('should not increment the rating value higher than 5', () async {
      final mockSkillRepo = TestMocks.skillStaffRepository;
      final mockUserRepo = TestMocks.userRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // this inits the controller and sets the skill
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("1");

      controller.rating.value = 5;
      expect(controller.rating.value, 5);

      controller.incrementRating();
      expect(controller.rating.value, 5);
    });
  });

  group('decrement rating method', () {
    test('should decrement the rating value', () async {
      final mockSkillRepo = TestMocks.skillStaffRepository;
      final mockUserRepo = TestMocks.userRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // this inits the controller and sets the skill
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("1");

      controller.rating.value = 3;
      expect(controller.rating.value, 3);

      controller.decrementRating();
      expect(controller.rating.value, 2);
    });
    test('should not decrement the rating value less than 0', () async {
      final mockSkillRepo = TestMocks.skillStaffRepository;
      final mockUserRepo = TestMocks.userRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // this inits the controller and sets the skill
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("1");

      controller.rating.value = 0;
      expect(controller.rating.value, 0);

      controller.decrementRating();
      expect(controller.rating.value, 0);
    });
  });

  group('set is edited method', () {
    test('does not set edited if no rating or expiry passed', () async {
      final mockSkillRepo = TestMocks.skillStaffRepository;
      final mockUserRepo = TestMocks.userRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // this inits the controller and sets the skill
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("1");

      expect(controller.isEdited.value, false);

      controller.setIsEdited();

      expect(controller.isEdited.value, false);
    });

    test('sets edited to true if the rating has changed', () async {
      final mockSkillRepo = TestMocks.skillStaffRepository;
      final mockUserRepo = TestMocks.userRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // this inits the controller and sets the skill
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("1");
      controller.rating.value = mockSkillWithExpiry.rating;

      expect(controller.isEdited.value, false);
      expect(controller.rating.value, mockSkillWithExpiry.rating);

      controller.setIsEdited(newRating: mockSkillWithExpiry.rating + 1);
      expect(controller.isEdited.value, true);
    });

    test(
        'sets edited to false if the rating has changed back to original value',
        () async {
      final mockSkillRepo = TestMocks.skillStaffRepository;
      final mockUserRepo = TestMocks.userRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // this inits the controller and sets the skill
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("1");
      controller.rating.value = mockSkillWithExpiry.rating;

      expect(controller.isEdited.value, false);
      expect(controller.rating.value, mockSkillWithExpiry.rating);

      controller.setIsEdited(newRating: mockSkillWithExpiry.rating + 1);
      expect(controller.isEdited.value, true);

      controller.setIsEdited(newRating: mockSkillWithExpiry.rating);
      expect(controller.isEdited.value, false);
    });

    test('sets edited to true if the expiry has changed', () async {
      final mockSkillRepo = TestMocks.skillStaffRepository;
      final mockUserRepo = TestMocks.userRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // this inits the controller and sets the skill
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("1");
      final dateNow = mockSkillWithExpiry.expires;
      controller.expires.value = dateNow;

      expect(controller.isEdited.value, false);
      expect(controller.expires.value, dateNow);

      controller.setIsEdited(newExpiry: dateNow!.add(Duration(days: 1)));

      expect(controller.isEdited.value, true);
    });

    test(
        'sets edited to false if the expiry has changed back to original value',
        () async {
      final mockSkillRepo = TestMocks.skillStaffRepository;
      final mockUserRepo = TestMocks.userRepository;

      Get.parameters = {"id": "1", "name": "Test Skill"};

      when(mockSkillRepo.getSkillById(1))
          .thenAnswer((_) async => mockSkillWithExpiry);
      when(mockUserRepo.staff).thenReturn(mockStaff);

      // this inits the controller and sets the skill
      final controller = Get.find<StaffSkillOverviewController>();
      await controller.getSkill("1");
      controller.expires.value = mockSkillWithExpiry.expires;

      expect(controller.isEdited.value, false);
      expect(controller.expires.value, mockSkillWithExpiry.expires);

      controller.setIsEdited(
          newExpiry: mockSkillWithExpiry.expires!.add(Duration(days: 1)));
      expect(controller.isEdited.value, true);

      controller.setIsEdited(newExpiry: mockSkillWithExpiry.expires);
      expect(controller.isEdited.value, false);
    });
  });
}
