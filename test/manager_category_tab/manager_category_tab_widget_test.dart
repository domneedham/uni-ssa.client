import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/manager_category_tab_controller.dart';
import 'package:ssa_app/app/ui/pages/manager_category_tab/manager_category_list.dart';
import 'package:ssa_app/app/ui/pages/manager_category_tab/manager_category_tab.dart';
import 'package:ssa_app/app/ui/pages/manager_category_tab/manager_category_list_tile.dart';

import '../mocks/mocks.dart';
import '../testable_widget.dart';
import 'manager_category_tab_test_data.dart';

void main() {
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

  group('tab', () {
    testWidgets('appbar title shows the right title',
        (WidgetTester tester) async {
      TestMocks.categoriesRepository;
      await tester.pumpWidget(TestableWidget(child: ManagerCategoryTab()));
      await tester.pumpAndSettle();
      expect(find.text("Categories"), findsOneWidget);
    });

    testWidgets('create a new category icon is present',
        (WidgetTester tester) async {
      TestMocks.categoriesRepository;
      await tester.pumpWidget(TestableWidget(child: ManagerCategoryTab()));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.add), findsOneWidget);
    });
  });

  group('category tab list', () {
    testWidgets('widgets in the list are of ManagerCategoryListTile type',
        (WidgetTester tester) async {
      final mockRepo = TestMocks.categoriesRepository;

      when(mockRepo.categories)
          .thenAnswer((_) async => [mockCategoryOne, mockCategoryTwo]);

      final controller = Get.find<ManagerCategoryTabController>();
      await controller.getCategories();

      await tester.pumpWidget(TestableWidget(child: ManagerCategoryList()));
      await tester.pumpAndSettle();
      expect(find.byType(ManagerCategoryListTile), findsNWidgets(2));
    });
  });

  group('category tab listtile', () {
    testWidgets('shows the name of the category', (WidgetTester tester) async {
      TestMocks.categoriesRepository;

      final controller = Get.find<ManagerCategoryTabController>();
      await controller.getCategories();

      await tester.pumpWidget(
        TestableWidget(
          child: ManagerCategoryListTile(
            item: mockCategoryOne,
            edit: () => controller.editCategory(mockCategoryOne),
            delete: () => controller.deleteCategory(mockCategoryOne),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text(mockCategoryOne.name), findsOneWidget);
    });

    testWidgets('shows the icon of the category', (WidgetTester tester) async {
      TestMocks.categoriesRepository;

      final controller = Get.find<ManagerCategoryTabController>();
      await controller.getCategories();

      await tester.pumpWidget(
        TestableWidget(
          child: ManagerCategoryListTile(
            item: mockCategoryOne,
            edit: () => controller.editCategory(mockCategoryOne),
            delete: () => controller.deleteCategory(mockCategoryOne),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byIcon(mockCategoryOne.icon), findsOneWidget);
    });

    testWidgets('shows the edit icon', (WidgetTester tester) async {
      TestMocks.categoriesRepository;

      final controller = Get.find<ManagerCategoryTabController>();
      await controller.getCategories();

      await tester.pumpWidget(
        TestableWidget(
          child: ManagerCategoryListTile(
            item: mockCategoryOne,
            edit: () => controller.editCategory(mockCategoryOne),
            delete: () => controller.deleteCategory(mockCategoryOne),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.edit), findsOneWidget);
    });

    testWidgets('shows the delete icon', (WidgetTester tester) async {
      TestMocks.categoriesRepository;

      final controller = Get.find<ManagerCategoryTabController>();
      await controller.getCategories();

      await tester.pumpWidget(
        TestableWidget(
          child: ManagerCategoryListTile(
            item: mockCategoryOne,
            edit: () => controller.editCategory(mockCategoryOne),
            delete: () => controller.deleteCategory(mockCategoryOne),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.delete), findsOneWidget);
    });
  });
}
