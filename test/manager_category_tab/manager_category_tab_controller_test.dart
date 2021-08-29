import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/manager_category_tab_controller.dart';
import 'package:ssa_app/app/ui/pages/manager_category_tab/manager_category_tab.dart';

import '../mocks/data.dart';
import '../mocks/mocks.dart';
import '../testable_widget.dart';

void main() {
  final categoryOne = TestData.mockCategoryOne;

  final binding = BindingsBuilder(() {
    Get.lazyPut<ManagerCategoryTabController>(
        () => ManagerCategoryTabController());
  });

  setUp(() async {
    Get.testMode = true;
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  group('get categories method', () {
    test('sets the categories if loaded correctly', () async {
      final mockCategoryService = TestMocks.categoriesService;

      when(mockCategoryService.getAll()).thenAnswer((_) async => [categoryOne]);

      final controller = Get.find<ManagerCategoryTabController>();
      await controller.getCategories();

      expect(controller.categories!.toList(), [categoryOne]);
    });

    test('sets the error if failed to load', () async {
      final mockCategoryService = TestMocks.categoriesService;

      final exception = Exception('Failure');
      when(mockCategoryService.getAll()).thenThrow(exception);

      final controller = Get.find<ManagerCategoryTabController>();
      await controller.getCategories();

      expect(controller.isError.value, true);
      expect(controller.error.value, exception.toString());
    });
  });

  group('delete method', () {
    testWidgets('should call delete', (tester) async {
      final mockCategoryService = TestMocks.categoriesService;

      when(mockCategoryService.getAll()).thenAnswer((_) async => [categoryOne]);

      // need to pump for snackbar
      await tester
          .pumpWidget(const TestableWidget(child: ManagerCategoryTab()));
      await tester.pumpAndSettle();

      final controller = Get.find<ManagerCategoryTabController>();

      await controller.deleteCategory(categoryOne);
      // let the snackbar run
      await tester.pumpAndSettle(const Duration(seconds: 5));

      verify(mockCategoryService.delete(any)).called(1);
    });

    testWidgets('deletes the category from the list if successful',
        (tester) async {
      final mockCategoryService = TestMocks.categoriesService;

      when(mockCategoryService.getAll()).thenAnswer((_) async => [categoryOne]);

      // need to pump for snackbar
      await tester
          .pumpWidget(const TestableWidget(child: ManagerCategoryTab()));
      await tester.pumpAndSettle();

      final controller = Get.find<ManagerCategoryTabController>();
      controller.getCategories();

      expect(controller.categories!.toList(), [categoryOne]);

      await controller.deleteCategory(categoryOne);
      // let the snackbar run
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(controller.categories!.toList(), []);
    });
  });
}
