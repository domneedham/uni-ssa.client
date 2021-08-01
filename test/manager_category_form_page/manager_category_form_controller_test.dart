import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/manager_category_form_controller.dart';
import 'package:ssa_app/app/ui/pages/manager_category_form_page/utils/manager_category_form_constants.dart';

import '../mocks/data.dart';
import '../mocks/mocks.dart';

void main() {
  final managerOne = TestData.mockManagerNoStaff;
  final categoryOne = TestData.mockCategoryOne;
  final categoryTwo = TestData.mockCategoryTwo;

  final binding = BindingsBuilder(() {
    Get.lazyPut<ManagerCategoryFormController>(
        () => ManagerCategoryFormController());
  });

  setUp(() async {
    Get.testMode = true;
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  group('form mode', () {
    test('is set to add if the parameters are for add', () async {
      final userRepo = TestMocks.userRepository;
      final mockCatRepo = TestMocks.categoriesRepository;

      Get.parameters = ManagerCategoryFormConstants.ADD_MODE_PARAMETERS;

      final controller = Get.find<ManagerCategoryFormController>();

      when(mockCatRepo.categories)
          .thenAnswer((_) async => [categoryOne, categoryTwo]);
      when(userRepo.manager).thenReturn(managerOne);

      expect(controller.formMode, ManagerCategoryFormMode.ADD);
    });

    test('is set to edit if the parameters are for edit', () async {
      final userRepo = TestMocks.userRepository;
      final mockCatRepo = TestMocks.categoriesRepository;

      Get.parameters = ManagerCategoryFormConstants.EDIT_MODE_PARAMETERS;

      final controller = Get.find<ManagerCategoryFormController>();

      when(mockCatRepo.categories)
          .thenAnswer((_) async => [categoryOne, categoryTwo]);
      when(userRepo.manager).thenReturn(managerOne);

      expect(controller.formMode, ManagerCategoryFormMode.EDIT);
    });
  });

  group('validate', () {
    group('name', () {
      test('should return null if the name is not null', () async {
        final userRepo = TestMocks.userRepository;
        final mockCatRepo = TestMocks.categoriesRepository;

        Get.parameters = ManagerCategoryFormConstants.ADD_MODE_PARAMETERS;

        final controller = Get.find<ManagerCategoryFormController>();

        when(mockCatRepo.categories)
            .thenAnswer((_) async => [categoryOne, categoryTwo]);
        when(userRepo.manager).thenReturn(managerOne);

        final response = controller.validateName("Name");
        expect(response, null);
      });

      test('should return a string if the name is not null', () async {
        final userRepo = TestMocks.userRepository;
        final mockCatRepo = TestMocks.categoriesRepository;

        Get.parameters = ManagerCategoryFormConstants.ADD_MODE_PARAMETERS;

        final controller = Get.find<ManagerCategoryFormController>();

        when(mockCatRepo.categories)
            .thenAnswer((_) async => [categoryOne, categoryTwo]);
        when(userRepo.manager).thenReturn(managerOne);

        final response = controller.validateName(null);
        expect(response, isNotNull);
      });
    });
  });
}
