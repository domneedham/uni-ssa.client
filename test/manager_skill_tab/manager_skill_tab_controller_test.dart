import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/home_controller.dart';
import 'package:ssa_app/app/controllers/manager_skill_tab_controller.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_list.dart';

import '../mocks/mocks.dart';
import 'manager_skill_tab_test_data.dart';

void main() {
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
      'Getting the map of skills should return them alphabetically by category name',
      () async {
    final mockSkillRepo = TestMocks.skillManagerRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.skills).thenAnswer(
        (_) async => [mockManagerStaffSkillOne, mockManagerStaffSkillTwo]);

    when(mockUserRepo.manager).thenReturn(mockManager);

    final controller = Get.find<ManagerSkillTabController>();

    final sortedMap = {
      mockManagerStaffSkillTwo.category:
          List<ManagerStaffSkill>.filled(1, mockManagerStaffSkillTwo),
      mockManagerStaffSkillOne.category:
          List<ManagerStaffSkill>.filled(1, mockManagerStaffSkillOne)
    };

    await controller.getSkills();

    final controllerMap = controller.skills;

    expect(controllerMap!.keys.first.name, sortedMap.keys.first.name);
  });

  test('Skills are organised into the categories correctly', () async {
    final mockSkillRepo = TestMocks.skillManagerRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockSkillRepo.skills).thenAnswer(
        (_) async => [mockManagerStaffSkillOne, mockManagerStaffSkillTwo]);
    when(mockUserRepo.manager).thenReturn(mockManager);

    final controller = Get.find<ManagerSkillTabController>();

    await controller.getSkills();

    final controllerMap = controller.skills;

    // get the map item with the category from mockSkillOne
    final mapItem = controllerMap!.entries
        .where((element) => element.key == mockManagerStaffSkillOne.category)
        .first;

    // expect that the mapItem value (only one item in the list) is mockSkillOne
    expect(mapItem.value[0], mockManagerStaffSkillOne);
  });

  group('viewType functionality', () {
    test('changeViewType assigns the new value to the viewType variable - grid',
        () async {
      final mockSkillRepo = TestMocks.skillManagerRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockSkillRepo.skills).thenAnswer(
          (_) async => [mockManagerStaffSkillOne, mockManagerStaffSkillTwo]);
      when(mockUserRepo.manager).thenReturn(mockManager);

      final controller = Get.find<ManagerSkillTabController>();

      // set and ensure it is of list type
      controller.viewType.value = SkillListViewType.LIST;
      expect(controller.viewType.value, SkillListViewType.LIST);

      // update using method
      controller.changeViewType(SkillListViewType.GRID);
      expect(controller.viewType.value, SkillListViewType.GRID);
    });

    test('changeViewType assigns the new value to the viewType variable - list',
        () async {
      final mockSkillRepo = TestMocks.skillManagerRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockSkillRepo.skills).thenAnswer(
          (_) async => [mockManagerStaffSkillOne, mockManagerStaffSkillTwo]);
      when(mockUserRepo.manager).thenReturn(mockManager);

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
