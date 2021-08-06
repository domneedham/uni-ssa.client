import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/manager_category_tab_controller.dart';
import 'package:ssa_app/app/ui/pages/manager_category_tab/manager_category_list.dart';
import 'package:ssa_app/app/ui/pages/manager_category_tab/manager_category_tab.dart';
import 'package:ssa_app/app/ui/pages/manager_category_tab/manager_category_list_tile.dart';

import '../mocks/data.dart';
import '../mocks/mocks.dart';
import '../testable_widget.dart';

void main() {
  final categoryOne = TestData.mockCategoryOne;
  final categoryTwo = TestData.mockCategoryTwo;

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
    testWidgets(
        'widgets in the list are of ManagerCategoryListTile type if the list is populated',
        (WidgetTester tester) async {
      final mockRepo = TestMocks.categoriesRepository;

      when(mockRepo.categories)
          .thenAnswer((_) async => [categoryOne, categoryTwo]);

      final controller = Get.find<ManagerCategoryTabController>();
      await controller.getCategories();

      await tester.pumpWidget(TestableWidget(child: ManagerCategoryList()));
      await tester.pumpAndSettle();
      expect(find.byType(ManagerCategoryListTile), findsNWidgets(2));
    });

    testWidgets('shows no categories loaded if true',
        (WidgetTester tester) async {
      final mockRepo = TestMocks.categoriesRepository;

      when(mockRepo.categories).thenAnswer((_) async => []);

      final controller = Get.find<ManagerCategoryTabController>();
      await controller.getCategories();

      await tester.pumpWidget(TestableWidget(child: ManagerCategoryList()));
      await tester.pumpAndSettle();

      expect(find.text("No categories loaded."), findsNothing);
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
            item: categoryOne,
            edit: () => controller.editCategory(categoryOne),
            delete: () => controller.deleteCategory(categoryOne),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text(categoryOne.name), findsOneWidget);
    });

    testWidgets('shows the icon of the category', (WidgetTester tester) async {
      TestMocks.categoriesRepository;

      final controller = Get.find<ManagerCategoryTabController>();
      await controller.getCategories();

      await tester.pumpWidget(
        TestableWidget(
          child: ManagerCategoryListTile(
            item: categoryOne,
            edit: () => controller.editCategory(categoryOne),
            delete: () => controller.deleteCategory(categoryOne),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byIcon(categoryOne.icon), findsOneWidget);
    });

    testWidgets('shows the edit icon', (WidgetTester tester) async {
      TestMocks.categoriesRepository;

      final controller = Get.find<ManagerCategoryTabController>();
      await controller.getCategories();

      await tester.pumpWidget(
        TestableWidget(
          child: ManagerCategoryListTile(
            item: categoryOne,
            edit: () => controller.editCategory(categoryOne),
            delete: () => controller.deleteCategory(categoryOne),
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
            item: categoryOne,
            edit: () => controller.editCategory(categoryOne),
            delete: () => controller.deleteCategory(categoryOne),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.delete), findsOneWidget);
    });
  });

  group('delete category button press', () {
    testWidgets('shows an alert dialog', (WidgetTester tester) async {
      final mockCatRepo = TestMocks.categoriesRepository;

      when(mockCatRepo.categories).thenAnswer((_) async => [categoryOne]);

      final controller = Get.find<ManagerCategoryTabController>();
      await controller.getCategories();

      await tester.pumpWidget(
        TestableWidget(
          child: ManagerCategoryList(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
    });

    group('alert dialog no button', () {
      testWidgets('dismisses the alert dialog', (WidgetTester tester) async {
        final mockCatRepo = TestMocks.categoriesRepository;

        when(mockCatRepo.categories).thenAnswer((_) async => [categoryOne]);

        final controller = Get.find<ManagerCategoryTabController>();
        await controller.getCategories();

        await tester.pumpWidget(
          TestableWidget(
            child: ManagerCategoryList(),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.delete));
        await tester.pumpAndSettle();

        await tester.tap(find.text("No"));
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsNothing);
      });
    });

    group('alert dialog yes button', () {
      testWidgets('dismisses the alert dialog', (WidgetTester tester) async {
        final mockCatRepo = TestMocks.categoriesRepository;

        when(mockCatRepo.categories).thenAnswer((_) async => [categoryOne]);
        when(mockCatRepo.deleteCategory(any)).thenAnswer((_) async => null);

        final controller = Get.find<ManagerCategoryTabController>();
        await controller.getCategories();

        await tester.pumpWidget(
          TestableWidget(
            child: ManagerCategoryList(),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.delete));
        await tester.pumpAndSettle();

        await tester.tap(find.text("Yes"));
        await tester.pumpAndSettle();

        // let a snackbar run
        await tester.pump(Duration(seconds: 5));

        expect(find.byType(AlertDialog), findsNothing);
      });

      testWidgets('calls delete', (WidgetTester tester) async {
        final mockCatRepo = TestMocks.categoriesRepository;

        when(mockCatRepo.categories).thenAnswer((_) async => [categoryOne]);
        when(mockCatRepo.deleteCategory(any)).thenAnswer((_) async => null);

        final controller = Get.find<ManagerCategoryTabController>();
        await controller.getCategories();

        await tester.pumpWidget(
          TestableWidget(
            child: ManagerCategoryList(),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.delete));
        await tester.pumpAndSettle();

        await tester.tap(find.text("Yes"));
        await tester.pumpAndSettle();
        // let a snackbar run
        await tester.pump(Duration(seconds: 5));

        verify(mockCatRepo.deleteCategory(any)).called(1);
      });
    });
  });
}
