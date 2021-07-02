import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/manager_skill_form_controller.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_form_page/utils/manager_skill_form_constants.dart';

import '../mocks/mocks.dart';
import 'manager_skill_form_test_data.dart';

void main() {
  final binding = BindingsBuilder(() {
    Get.lazyPut<ManagerSkillFormController>(() => ManagerSkillFormController());
  });

  setUp(() async {
    Get.testMode = true;
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  group('fetch categories method', () {
    test('fetches all the categories', () async {
      final userRepo = TestMocks.userRepository;
      final mockCatRepo = TestMocks.categoriesRepository;

      final controller = Get.find<ManagerSkillFormController>();

      when(mockCatRepo.categories)
          .thenAnswer((_) async => [categoryOne, categoryTwo]);
      when(userRepo.manager).thenReturn(managerOne);

      await controller.fetchCategories();

      expect(controller.categories.length, 2);
    });

    test('sets the error if one occurs', () async {
      final userRepo = TestMocks.userRepository;
      final mockCatRepo = TestMocks.categoriesRepository;

      Get.parameters = ManagerSkillFormConstants.ADD_MODE_PARAMETERS;

      final controller = Get.find<ManagerSkillFormController>();

      final exception = Exception("Error");

      when(mockCatRepo.categories).thenAnswer((_) async => throw exception);
      when(userRepo.manager).thenReturn(managerOne);

      await controller.fetchCategories();

      expect(controller.isError.value, true);
      expect(controller.error.value, exception.toString());
    });

    test('sets loading to false when the method finishes', () async {
      final userRepo = TestMocks.userRepository;
      final mockCatRepo = TestMocks.categoriesRepository;

      Get.parameters = ManagerSkillFormConstants.ADD_MODE_PARAMETERS;

      final controller = Get.find<ManagerSkillFormController>();

      when(mockCatRepo.categories).thenAnswer((_) async => []);
      when(userRepo.manager).thenReturn(managerOne);

      await controller.fetchCategories();

      expect(controller.isLoading.value, false);
    });
  });

  group('form mode', () {
    test('is set to add if the parameters are for add', () async {
      final userRepo = TestMocks.userRepository;
      final mockCatRepo = TestMocks.categoriesRepository;

      Get.parameters = ManagerSkillFormConstants.ADD_MODE_PARAMETERS;

      final controller = Get.find<ManagerSkillFormController>();

      when(mockCatRepo.categories)
          .thenAnswer((_) async => [categoryOne, categoryTwo]);
      when(userRepo.manager).thenReturn(managerOne);

      expect(controller.formMode, ManagerSkillFormMode.ADD);
    });

    test('is set to edit if the parameters are for edit', () async {
      final userRepo = TestMocks.userRepository;
      final mockCatRepo = TestMocks.categoriesRepository;

      Get.parameters = ManagerSkillFormConstants.EDIT_MODE_PARAMETERS;

      final controller = Get.find<ManagerSkillFormController>();

      when(mockCatRepo.categories)
          .thenAnswer((_) async => [categoryOne, categoryTwo]);
      when(userRepo.manager).thenReturn(managerOne);

      expect(controller.formMode, ManagerSkillFormMode.EDIT);
    });
  });

  group('validate', () {
    group('name', () {
      test('should return null if the name is not null', () async {
        final userRepo = TestMocks.userRepository;
        final mockCatRepo = TestMocks.categoriesRepository;

        Get.parameters = ManagerSkillFormConstants.ADD_MODE_PARAMETERS;

        final controller = Get.find<ManagerSkillFormController>();

        when(mockCatRepo.categories)
            .thenAnswer((_) async => [categoryOne, categoryTwo]);
        when(userRepo.manager).thenReturn(managerOne);

        final response = controller.validateName("Name");
        expect(response, null);
      });

      test('should return a string if the name is not null', () async {
        final userRepo = TestMocks.userRepository;
        final mockCatRepo = TestMocks.categoriesRepository;

        Get.parameters = ManagerSkillFormConstants.ADD_MODE_PARAMETERS;

        final controller = Get.find<ManagerSkillFormController>();

        when(mockCatRepo.categories)
            .thenAnswer((_) async => [categoryOne, categoryTwo]);
        when(userRepo.manager).thenReturn(managerOne);

        final response = controller.validateName(null);
        expect(response, isNotNull);
      });
    });

    group('category', () {
      test('should return null if the category is not null', () async {
        final userRepo = TestMocks.userRepository;
        final mockCatRepo = TestMocks.categoriesRepository;

        Get.parameters = ManagerSkillFormConstants.ADD_MODE_PARAMETERS;

        final controller = Get.find<ManagerSkillFormController>();

        when(mockCatRepo.categories)
            .thenAnswer((_) async => [categoryOne, categoryTwo]);
        when(userRepo.manager).thenReturn(managerOne);

        final response = controller.validateCategory(categoryOne.id);
        expect(response, null);
      });

      test('should return a string if the name is not null', () async {
        final userRepo = TestMocks.userRepository;
        final mockCatRepo = TestMocks.categoriesRepository;

        Get.parameters = ManagerSkillFormConstants.ADD_MODE_PARAMETERS;

        final controller = Get.find<ManagerSkillFormController>();

        when(mockCatRepo.categories)
            .thenAnswer((_) async => [categoryOne, categoryTwo]);
        when(userRepo.manager).thenReturn(managerOne);

        final response = controller.validateCategory(null);
        expect(response, isNotNull);
      });
    });
  });
}
