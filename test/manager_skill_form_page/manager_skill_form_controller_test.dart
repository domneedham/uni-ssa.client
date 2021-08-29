import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/manager_skill_form_controller.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_form_page/manager_skill_form_page.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_form_page/utils/manager_skill_form_constants.dart';

import '../mocks/data.dart';
import '../mocks/mocks.dart';
import '../testable_widget.dart';

void main() {
  final categoryOne = TestData.mockCategoryOne;
  final categoryTwo = TestData.mockCategoryTwo;
  final skillOne = TestData.mockSkillOne;

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
      final mockCatService = TestMocks.categoriesService;
      TestMocks.skillService;

      final controller = Get.find<ManagerSkillFormController>();

      when(mockCatService.getAll())
          .thenAnswer((_) async => [categoryOne, categoryTwo]);

      await controller.fetchCategories();

      expect(controller.categories.length, 2);
    });

    test('sets the error if one occurs', () async {
      final mockCatService = TestMocks.categoriesService;
      TestMocks.skillService;

      Get.parameters = ManagerSkillFormConstants.ADD_MODE_PARAMETERS;

      final controller = Get.find<ManagerSkillFormController>();

      final exception = Exception('Error');

      when(mockCatService.getAll()).thenAnswer((_) async => throw exception);

      await controller.fetchCategories();

      expect(controller.isError.value, true);
      expect(controller.error.value, exception.toString());
    });

    test('sets loading to false when the method finishes', () async {
      final mockCatService = TestMocks.categoriesService;
      TestMocks.skillService;

      Get.parameters = ManagerSkillFormConstants.ADD_MODE_PARAMETERS;

      final controller = Get.find<ManagerSkillFormController>();

      when(mockCatService.getAll()).thenAnswer((_) async => []);

      await controller.fetchCategories();

      expect(controller.isLoading.value, false);
    });
  });

  group('form mode', () {
    test('is set to add if the parameters are for add', () async {
      final mockCatService = TestMocks.categoriesService;
      TestMocks.skillService;

      Get.parameters = ManagerSkillFormConstants.ADD_MODE_PARAMETERS;

      final controller = Get.find<ManagerSkillFormController>();

      when(mockCatService.getAll())
          .thenAnswer((_) async => [categoryOne, categoryTwo]);

      expect(controller.formMode, ManagerSkillFormMode.ADD);
    });

    test('is set to edit if the parameters are for edit', () async {
      final mockCatService = TestMocks.categoriesService;
      TestMocks.skillService;

      Get.parameters = ManagerSkillFormConstants.EDIT_MODE_PARAMETERS;

      final controller = Get.find<ManagerSkillFormController>();

      when(mockCatService.getAll())
          .thenAnswer((_) async => [categoryOne, categoryTwo]);

      expect(controller.formMode, ManagerSkillFormMode.EDIT);
    });
  });

  group('validate', () {
    group('name', () {
      test('should return null if the name is not null', () async {
        final mockCatService = TestMocks.categoriesService;
        TestMocks.skillService;

        Get.parameters = ManagerSkillFormConstants.ADD_MODE_PARAMETERS;

        final controller = Get.find<ManagerSkillFormController>();

        when(mockCatService.getAll())
            .thenAnswer((_) async => [categoryOne, categoryTwo]);

        final response = controller.validateName('Name');
        expect(response, null);
      });

      test('should return a string if the name is not null', () async {
        final mockCatService = TestMocks.categoriesService;
        TestMocks.skillService;

        Get.parameters = ManagerSkillFormConstants.ADD_MODE_PARAMETERS;

        final controller = Get.find<ManagerSkillFormController>();

        when(mockCatService.getAll())
            .thenAnswer((_) async => [categoryOne, categoryTwo]);

        final response = controller.validateName(null);
        expect(response, isNotNull);
      });
    });

    group('category', () {
      test('should return null if the category is not null', () async {
        final mockCatService = TestMocks.categoriesService;
        TestMocks.skillService;

        Get.parameters = ManagerSkillFormConstants.ADD_MODE_PARAMETERS;

        final controller = Get.find<ManagerSkillFormController>();

        when(mockCatService.getAll())
            .thenAnswer((_) async => [categoryOne, categoryTwo]);

        final response = controller.validateCategory(categoryOne.id);
        expect(response, null);
      });

      test('should return a string if the name is not null', () async {
        final mockCatService = TestMocks.categoriesService;
        TestMocks.skillService;

        Get.parameters = ManagerSkillFormConstants.ADD_MODE_PARAMETERS;

        final controller = Get.find<ManagerSkillFormController>();

        when(mockCatService.getAll())
            .thenAnswer((_) async => [categoryOne, categoryTwo]);

        final response = controller.validateCategory(null);
        expect(response, isNotNull);
      });
    });
  });

  group('save method', () {
    group('add mode', () {
      testWidgets('should call save if form is valid', (tester) async {
        final mockCatService = TestMocks.categoriesService;
        final mockSkillService = TestMocks.skillService;

        Get.parameters = ManagerSkillFormConstants.ADD_MODE_PARAMETERS;

        when(mockCatService.getAll())
            .thenAnswer((_) async => [categoryOne, categoryTwo]);
        when(mockSkillService.create(any)).thenAnswer((_) async => skillOne);

        // need to pump for snackbar
        await tester
            .pumpWidget(const TestableWidget(child: ManagerSkillFormPage()));
        await tester.pumpAndSettle();

        final controller = Get.find<ManagerSkillFormController>();
        controller.nameController.text = 'Hello';
        controller.selectedCategoryId = categoryOne.id;

        await controller.save();
        // let the snackbar run
        await tester.pump(const Duration(seconds: 5));

        verify(mockSkillService.create(any)).called(1);
      });

      testWidgets('should not call save if form is not valid', (tester) async {
        final mockCatService = TestMocks.categoriesService;
        final mockSkillService = TestMocks.skillService;

        Get.parameters = ManagerSkillFormConstants.ADD_MODE_PARAMETERS;

        when(mockCatService.getAll())
            .thenAnswer((_) async => [categoryOne, categoryTwo]);
        when(mockSkillService.create(any)).thenAnswer((_) async => skillOne);

        // need to pump for snackbar
        await tester
            .pumpWidget(const TestableWidget(child: ManagerSkillFormPage()));
        await tester.pumpAndSettle();

        final controller = Get.find<ManagerSkillFormController>();
        controller.nameController.text = '';
        controller.selectedCategoryId = categoryOne.id;

        await controller.save();
        // let the snackbar run
        await tester.pump(const Duration(seconds: 5));

        verifyNever(mockSkillService.create(any));
      });
    });

    group('edit mode', () {
      testWidgets('should call save if form is valid', (tester) async {
        final mockCatService = TestMocks.categoriesService;
        final mockSkillService = TestMocks.skillService;

        Get.parameters = ManagerSkillFormConstants.EDIT_MODE_PARAMETERS;

        when(mockCatService.getAll())
            .thenAnswer((_) async => [categoryOne, categoryTwo]);
        when(mockSkillService.update(any)).thenAnswer((_) async => skillOne);

        // need to pump for snackbar
        await tester
            .pumpWidget(const TestableWidget(child: ManagerSkillFormPage()));
        await tester.pumpAndSettle();

        final controller = Get.find<ManagerSkillFormController>();
        controller.editSkill = skillOne;
        controller.nameController.text = 'Hello';
        controller.selectedCategoryId = categoryOne.id;

        await controller.save();
        // let the snackbar run
        await tester.pump(const Duration(seconds: 5));

        verify(mockSkillService.update(any)).called(1);
      });

      testWidgets('should not call save if form is not valid', (tester) async {
        final mockCatService = TestMocks.categoriesService;
        final mockSkillService = TestMocks.skillService;

        Get.parameters = ManagerSkillFormConstants.EDIT_MODE_PARAMETERS;

        when(mockCatService.getAll())
            .thenAnswer((_) async => [categoryOne, categoryTwo]);
        when(mockSkillService.update(any)).thenAnswer((_) async => skillOne);

        // need to pump for snackbar
        await tester
            .pumpWidget(const TestableWidget(child: ManagerSkillFormPage()));
        await tester.pumpAndSettle();

        final controller = Get.find<ManagerSkillFormController>();
        controller.nameController.text = '';
        controller.selectedCategoryId = categoryOne.id;

        await controller.save();
        // let the snackbar run
        await tester.pump(const Duration(seconds: 5));

        verifyNever(mockSkillService.update(any));
      });
    });
  });
}
