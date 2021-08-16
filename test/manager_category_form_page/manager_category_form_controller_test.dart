import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/manager_category_form_controller.dart';
import 'package:ssa_app/app/ui/pages/manager_category_form_page/manager_category_form_page.dart';
import 'package:ssa_app/app/ui/pages/manager_category_form_page/utils/manager_category_form_constants.dart';

import '../mocks/data.dart';
import '../mocks/mocks.dart';
import '../testable_widget.dart';

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
      when(userRepo.user).thenReturn(managerOne);

      expect(controller.formMode, ManagerCategoryFormMode.ADD);
    });

    test('is set to edit if the parameters are for edit', () async {
      final userRepo = TestMocks.userRepository;
      final mockCatRepo = TestMocks.categoriesRepository;

      Get.parameters = ManagerCategoryFormConstants.EDIT_MODE_PARAMETERS;

      final controller = Get.find<ManagerCategoryFormController>();

      when(mockCatRepo.categories)
          .thenAnswer((_) async => [categoryOne, categoryTwo]);
      when(userRepo.user).thenReturn(managerOne);

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
        when(userRepo.user).thenReturn(managerOne);

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
        when(userRepo.user).thenReturn(managerOne);

        final response = controller.validateName(null);
        expect(response, isNotNull);
      });
    });
  });

  group('save', () {
    testWidgets('should call save if form is valid', (tester) async {
      final categoryRepo = TestMocks.categoriesRepository;

      Get.parameters = ManagerCategoryFormConstants.ADD_MODE_PARAMETERS;

      when(categoryRepo.getCategoryById(1))
          .thenAnswer((_) async => categoryOne);
      when(categoryRepo.createCategory(any))
          .thenAnswer((_) async => categoryOne);

      // need to pump for snackbar
      await tester.pumpWidget(TestableWidget(child: ManagerCategoryFormPage()));
      await tester.pumpAndSettle();

      final controller = Get.find<ManagerCategoryFormController>();
      controller.nameController.text = "Hello";

      await controller.save();
      // let the snackbar run
      await tester.pump(Duration(seconds: 5));

      verify(categoryRepo.createCategory(any)).called(1);
    });

    testWidgets('should not call save if name is not valid', (tester) async {
      final categoryRepo = TestMocks.categoriesRepository;

      Get.parameters = ManagerCategoryFormConstants.ADD_MODE_PARAMETERS;

      when(categoryRepo.getCategoryById(1))
          .thenAnswer((_) async => categoryOne);
      when(categoryRepo.createCategory(any))
          .thenAnswer((_) async => categoryOne);

      // need to pump for snackbar
      await tester.pumpWidget(TestableWidget(child: ManagerCategoryFormPage()));
      await tester.pumpAndSettle();

      final controller = Get.find<ManagerCategoryFormController>();
      controller.nameController.text = "";

      await controller.save();
      // let the snackbar run
      await tester.pump(Duration(seconds: 5));

      verifyNever(categoryRepo.createCategory(any));
    });
  });
}
