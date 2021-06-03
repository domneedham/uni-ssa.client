import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/home_controller.dart';
import 'package:ssa_app/app/controllers/home_staff_controller.dart';

import '../../mocks/mocks.dart';
import 'staff_home_test_data.dart';

void main() {
  final binding = BindingsBuilder(() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HomeStaffController>(() => HomeStaffController());
  });

  setUp(() async {
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  test(
      'Getting the list of skills should return them alphabetically by category name',
      () async {
    final mockSkillRepo = TestMocks.skillRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.getStaffSkillById(1)).thenReturn(mockSkillOne);
    when(mockSkillRepo.getStaffSkillById(2)).thenReturn(mockSkillTwo);
    when(mockUserRepo.staff).thenReturn(mockUserTwoSkills);

    // recover your controller
    final controller = Get.find<HomeStaffController>();

    final sortedList = [mockSkillTwo, mockSkillOne];

    final controllerList = controller.skills;

    expect(controllerList[0].id, sortedList[0].id);
    // expect(controller.skills[1].id, mockSkillOne.id);
  });
}
