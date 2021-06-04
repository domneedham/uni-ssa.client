import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/home_controller.dart';
import 'package:ssa_app/app/controllers/home_staff_controller.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';

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

  // test(
  //     'Getting the map of skills should return them alphabetically by category name',
  //     () async {
  //   final mockSkillRepo = TestMocks.skillRepository;
  //   final mockUserRepo = TestMocks.userRepository;

  //   when(mockSkillRepo.getStaffSkillById(1)).thenReturn(mockSkillOne);
  //   when(mockSkillRepo.getStaffSkillById(2)).thenReturn(mockSkillTwo);
  //   when(mockUserRepo.staff).thenReturn(mockUserTwoSkills);

  //   // recover your controller
  //   final controller = Get.find<HomeStaffController>();

  //   final sortedMap = {
  //     mockSkillTwo.category: List<StaffSkill>.filled(1, mockSkillTwo),
  //     mockSkillOne.category: List<StaffSkill>.filled(1, mockSkillOne)
  //   };

  //   final controllerMap = controller.skills;

  //   expect(controllerMap.keys.first.name, sortedMap.keys.first.name);
  // });

  // test('Skills are organised into the categories correctly', () async {
  //   final mockSkillRepo = TestMocks.skillRepository;
  //   final mockUserRepo = TestMocks.userRepository;

  //   when(mockSkillRepo.getStaffSkillById(1)).thenReturn(mockSkillOne);
  //   when(mockSkillRepo.getStaffSkillById(2)).thenReturn(mockSkillTwo);
  //   when(mockUserRepo.staff).thenReturn(mockUserTwoSkills);

  //   // recover your controller
  //   final controller = Get.find<HomeStaffController>();

  //   final controllerMap = controller.skills;

  //   // get the map item with the category from mockSkillOne
  //   final mapItem = controllerMap.entries
  //       .where((element) => element.key == mockSkillOne.category)
  //       .first;

  //   // expect that the mapItem value (only one item in the list) is mockSkillOne
  //   expect(mapItem.value[0], mockSkillOne);
  // });
}
