import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/home_controller.dart';
import 'package:ssa_app/app/controllers/manager_skill_tab_controller.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';

import '../../mocks/mocks.dart';
import 'manager_home_test_data.dart';

void main() {
  final binding = BindingsBuilder(() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ManagerSkillTabController>(() => ManagerSkillTabController());
  });

  setUp(() async {
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  test(
      'Getting the map of skills should return them alphabetically by category name',
      () async {
    final mockSkillRepo = TestMocks.skillManagerRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.skills).thenAnswer(
        (_) async => [mockManagerStaffSkillOne, mockManagerStaffSkillTwo]);

    when(mockUserRepo.manager).thenReturn(mockManager);

    // recover your controller
    final controller = Get.find<ManagerSkillTabController>();

    final sortedMap = {
      mockManagerStaffSkillTwo.category:
          List<ManagerStaffSkill>.filled(1, mockManagerStaffSkillTwo),
      mockManagerStaffSkillOne.category:
          List<ManagerStaffSkill>.filled(1, mockManagerStaffSkillOne)
    };

    final controllerMap = await controller.skills;

    expect(controllerMap!.keys.first.name, sortedMap.keys.first.name);
  });

  test('Skills are organised into the categories correctly', () async {
    final mockSkillRepo = TestMocks.skillManagerRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.skills).thenAnswer(
        (_) async => [mockManagerStaffSkillOne, mockManagerStaffSkillTwo]);
    when(mockUserRepo.manager).thenReturn(mockManager);

    // recover your controller
    final controller = Get.find<ManagerSkillTabController>();

    final controllerMap = await controller.skills;

    // get the map item with the category from mockSkillOne
    final mapItem = controllerMap!.entries
        .where((element) => element.key == mockManagerStaffSkillOne.category)
        .first;

    // expect that the mapItem value (only one item in the list) is mockSkillOne
    expect(mapItem.value[0], mockManagerStaffSkillOne);
  });
}
