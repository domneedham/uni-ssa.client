import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/home_controller.dart';
import 'package:ssa_app/app/controllers/staff_skill_tab_controller.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';

import '../mocks/mocks.dart';
import 'staff_skill_tab_test_data.dart';

void main() {
  final binding = BindingsBuilder(() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<StaffSkillTabController>(() => StaffSkillTabController());
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
    final mockSkillRepo = TestMocks.skillStaffRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.getSkillsByIds([1, 2]))
        .thenAnswer((_) async => [mockStaffSkillOne, mockStaffSkillTwo]);

    when(mockUserRepo.staff).thenReturn(mockStaffTwoSkills);

    // recover your controller
    final controller = Get.find<StaffSkillTabController>();

    final sortedMap = {
      mockStaffSkillTwo.category: List<StaffSkill>.filled(1, mockStaffSkillTwo),
      mockStaffSkillOne.category: List<StaffSkill>.filled(1, mockStaffSkillOne)
    };

    final controllerMap = await controller.skills;

    expect(controllerMap.keys.first.name, sortedMap.keys.first.name);
  });

  test('Skills are organised into the categories correctly', () async {
    final mockSkillRepo = TestMocks.skillStaffRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.getSkillsByIds([1, 2]))
        .thenAnswer((_) async => [mockStaffSkillOne, mockStaffSkillTwo]);
    when(mockUserRepo.staff).thenReturn(mockStaffTwoSkills);

    // recover your controller
    final controller = Get.find<StaffSkillTabController>();

    final controllerMap = await controller.skills;

    // get the map item with the category from mockSkillOne
    final mapItem = controllerMap.entries
        .where((element) => element.key == mockStaffSkillOne.category)
        .first;

    // expect that the mapItem value (only one item in the list) is mockSkillOne
    expect(mapItem.value[0], mockStaffSkillOne);
  });
}
