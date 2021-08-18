import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/home_controller.dart';
import 'package:ssa_app/app/controllers/staff_skill_tab_controller.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';

import '../mocks/data.dart';
import '../mocks/mocks.dart';

void main() {
  final staffSkillOne = TestData.mockStaffSkillOneWithExpiry;
  final staffSkillTwo = TestData.mockStaffSkillTwoWithExpiry;
  final staffWithSkills = TestData.mockStaffWithExpirySkills;

  final binding = BindingsBuilder(() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<StaffSkillTabController>(() => StaffSkillTabController());
  });

  setUp(() async {
    Get.testMode = true;
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  test(
      'getting the map of skills should return them alphabetically by category name',
      () async {
    final mockSkillRepo = TestMocks.skillStaffRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.getSkillsForUser(staffWithSkills.id))
        .thenAnswer((_) async => [staffSkillOne, staffSkillTwo]);
    when(mockUserRepo.user).thenReturn(staffWithSkills);

    // recover your controller
    final controller = Get.find<StaffSkillTabController>();

    final sortedMap = {
      staffSkillOne.category: List<StaffSkill>.filled(1, staffSkillOne),
      staffSkillTwo.category: List<StaffSkill>.filled(1, staffSkillTwo)
    };

    await controller.getSkills();

    final controllerMap = controller.skills!;

    expect(controllerMap.keys.first.name, sortedMap.keys.first.name);
  });

  test('skills are organised into the categories correctly', () async {
    final mockSkillRepo = TestMocks.skillStaffRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.getSkillsForUser(staffWithSkills.id))
        .thenAnswer((_) async => [staffSkillOne]);
    when(mockUserRepo.user).thenReturn(staffWithSkills);

    // recover your controller
    final controller = Get.find<StaffSkillTabController>();

    await controller.getSkills();

    final controllerMap = controller.skills!;

    // get the map item with the category from skillOne
    final mapItem = controllerMap.entries
        .where((element) => element.key == staffSkillOne.category)
        .first;

    // expect that the mapItem value (only one item in the list) is mockSkillOne
    expect(mapItem.value[0], staffSkillOne);
  });
}
