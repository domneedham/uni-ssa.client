import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/home_controller.dart';
import 'package:ssa_app/app/controllers/manager_skill_tab_controller.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_list.dart';

import '../mocks/data.dart';
import '../mocks/mocks.dart';

void main() {
  final managerStaffSkillOne = TestData.mockManagerStaffSkillOne;
  final managerStaffSkillTwo = TestData.mockManagerStaffSkillTwo;
  final managerOne = TestData.mockManagerWithStaff;

  final binding = BindingsBuilder(() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ManagerSkillTabController>(() => ManagerSkillTabController());
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
    final mockSkillRepo = TestMocks.skillManagerRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.skills)
        .thenAnswer((_) async => [managerStaffSkillOne, managerStaffSkillTwo]);

    when(mockUserRepo.manager).thenReturn(managerOne);

    final controller = Get.find<ManagerSkillTabController>();

    final sortedMap = {
      managerStaffSkillOne.category:
          List<ManagerStaffSkill>.filled(1, managerStaffSkillOne),
      managerStaffSkillTwo.category:
          List<ManagerStaffSkill>.filled(1, managerStaffSkillTwo)
    };

    await controller.getSkills();

    final controllerMap = controller.skills;

    expect(controllerMap!.keys.first.name, sortedMap.keys.first.name);
  });

  test('skills are organised into the categories correctly', () async {
    final mockSkillRepo = TestMocks.skillManagerRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.skills)
        .thenAnswer((_) async => [managerStaffSkillOne, managerStaffSkillTwo]);
    when(mockUserRepo.manager).thenReturn(managerOne);

    final controller = Get.find<ManagerSkillTabController>();

    await controller.getSkills();

    final controllerMap = controller.skills;

    // get the map item with the category from mockSkillOne
    final mapItem = controllerMap!.entries
        .where((element) => element.key == managerStaffSkillOne.category)
        .first;

    // expect that the mapItem value (only one item in the list) is mockSkillOne
    expect(mapItem.value[0], managerStaffSkillOne);
  });

  group('view type functionality', () {
    test(
        'change view type assigns the new value to the view type variable - grid',
        () async {
      final mockSkillRepo = TestMocks.skillManagerRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockSkillRepo.skills).thenAnswer(
          (_) async => [managerStaffSkillOne, managerStaffSkillTwo]);
      when(mockUserRepo.manager).thenReturn(managerOne);

      final controller = Get.find<ManagerSkillTabController>();

      // set and ensure it is of list type
      controller.viewType.value = SkillListViewType.LIST;
      expect(controller.viewType.value, SkillListViewType.LIST);

      // update using method
      controller.changeViewType(SkillListViewType.GRID);
      expect(controller.viewType.value, SkillListViewType.GRID);
    });

    test(
        'change view type assigns the new value to the view type variable - list',
        () async {
      final mockSkillRepo = TestMocks.skillManagerRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockSkillRepo.skills).thenAnswer(
          (_) async => [managerStaffSkillOne, managerStaffSkillTwo]);
      when(mockUserRepo.manager).thenReturn(managerOne);

      final controller = Get.find<ManagerSkillTabController>();

      // set and ensure it is of grid type
      controller.viewType.value = SkillListViewType.GRID;
      expect(controller.viewType.value, SkillListViewType.GRID);

      // update using method
      controller.changeViewType(SkillListViewType.LIST);
      expect(controller.viewType.value, SkillListViewType.LIST);
    });
  });
}
