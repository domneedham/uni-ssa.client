import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/manager_skill_overview_controller.dart';

import '../mocks/mocks.dart';
import 'manager_skill_overview_test_data.dart';

void main() {
  final binding = BindingsBuilder(() {
    Get.lazyPut<ManagerSkillOverviewController>(
        () => ManagerSkillOverviewController());
  });

  setUp(() async {
    Get.testMode = true;
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  group('get skill', () {
    test('sets the right skill', () async {
      final userRepo = TestMocks.userRepository;
      final skillRepo = TestMocks.skillManagerRepository;

      Get.parameters = {"id": "1"};

      final controller = Get.find<ManagerSkillOverviewController>();

      when(skillRepo.getManagerStaffSkillById(1))
          .thenAnswer((_) async => skillOne);
      when(userRepo.manager).thenReturn(managerOne);

      await controller.getSkill("1");

      final testSkill = skillOne;

      final controllerSkill = controller.skill!.value;

      expect(testSkill, controllerSkill);
    });

    test('sets an error if the id can not be found', () async {
      final userRepo = TestMocks.userRepository;
      final skillRepo = TestMocks.skillManagerRepository;

      Get.parameters = {"id": "1"};

      final controller = Get.find<ManagerSkillOverviewController>();

      final exception = Exception("Some error");

      when(skillRepo.getManagerStaffSkillById(1))
          .thenAnswer((_) async => Future.error(exception));
      when(userRepo.manager).thenReturn(managerOne);

      await controller.getSkill("1");

      expect(controller.isError.value, true);
      expect(controller.error.value, exception.toString());
    });
  });

  group('get staff by id', () {
    test('returns the right staff member', () async {
      final userRepo = TestMocks.userRepository;
      TestMocks.skillManagerRepository;

      final controller = Get.find<ManagerSkillOverviewController>();

      when(userRepo.getStaffById(1)).thenAnswer((_) async => staffOne);
      when(userRepo.manager).thenReturn(managerOne);

      final controllerStaff = await controller.getStaffById(1);

      expect(controllerStaff, staffOne);
    });
  });
}
