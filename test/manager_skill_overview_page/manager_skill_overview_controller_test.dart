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
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  test('Get skill returns the right skill', () async {
    final userRepo = TestMocks.userRepository;
    final skillRepo = TestMocks.skillManagerRepository;

    final controller = Get.find<ManagerSkillOverviewController>();

    when(skillRepo.getManagerStaffSkillById(1))
        .thenAnswer((_) async => skillOne);
    when(userRepo.manager).thenReturn(managerOne);

    final testSkill = skillOne;

    final controllerSkill = await controller.getSkill("1");

    expect(testSkill, controllerSkill);
  });

  test('Get skill returns an error if the id can not be found', () async {
    final userRepo = TestMocks.userRepository;
    final skillRepo = TestMocks.skillManagerRepository;

    final controller = Get.find<ManagerSkillOverviewController>();

    when(skillRepo.getManagerStaffSkillById(1))
        .thenAnswer((_) async => Future.error(Exception("Some error")));
    when(userRepo.manager).thenReturn(managerOne);

    expect(() => controller.getSkill("1"), throwsException);
  });

  test('Get staff by id returns the right staff member', () async {
    final userRepo = TestMocks.userRepository;
    final _ = TestMocks.skillManagerRepository;

    final controller = Get.find<ManagerSkillOverviewController>();

    when(userRepo.getStaffById(1)).thenAnswer((_) async => staffOne);
    when(userRepo.manager).thenReturn(managerOne);

    final controllerStaff = await controller.getStaffById(1);

    expect(controllerStaff, staffOne);
  });
}
