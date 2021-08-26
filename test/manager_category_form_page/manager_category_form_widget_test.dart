import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/manager_category_form_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/pages/manager_category_form_page/manager_category_form.dart';
import 'package:ssa_app/app/ui/pages/manager_category_form_page/manager_category_form_page.dart';
import 'package:ssa_app/app/ui/pages/manager_category_form_page/utils/manager_category_form_constants.dart';

import '../mocks/data.dart';
import '../mocks/mocks.dart';
import '../testable_widget.dart';

void main() {
  final managerOne = TestData.mockManagerNoStaff;
  final categoryOne = TestData.mockCategoryOne;

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

  group('page', () {
    testWidgets('loading indicator is shown whilst the page is loading',
        (WidgetTester tester) async {
      final _ = TestMocks.categoriesService;
      final mockUserService = TestMocks.userService;

      when(mockUserService.user).thenReturn(managerOne);

      Get.parameters = ManagerCategoryFormConstants.ADD_MODE_PARAMETERS;

      final controller = Get.find<ManagerCategoryFormController>();

      controller.isLoading.value = true;

      await tester
          .pumpWidget(const TestableWidget(child: ManagerCategoryFormPage()));

      expect(find.byType(LoadingIndicator), findsOneWidget);
    });

    testWidgets('error text is rendered if an error occurs',
        (WidgetTester tester) async {
      final _ = TestMocks.categoriesService;
      final mockUserService = TestMocks.userService;

      when(mockUserService.user).thenReturn(managerOne);

      final controller = Get.find<ManagerCategoryFormController>();
      controller.isError.value = true;
      controller.error.value = 'Issue';

      Get.parameters = ManagerCategoryFormConstants.ADD_MODE_PARAMETERS;

      // Build our app and trigger a frame.
      await tester
          .pumpWidget(const TestableWidget(child: ManagerCategoryFormPage()));
      await tester.pumpAndSettle();

      expect(find.text('Issue'), findsOneWidget);
    });

    testWidgets('category form is rendered if no error or not loading',
        (WidgetTester tester) async {
      final _ = TestMocks.categoriesService;
      final mockUserService = TestMocks.userService;

      when(mockUserService.user).thenReturn(managerOne);

      Get.parameters = ManagerCategoryFormConstants.ADD_MODE_PARAMETERS;

      await tester
          .pumpWidget(const TestableWidget(child: ManagerCategoryFormPage()));
      await tester.pumpAndSettle();

      expect(find.byType(ManagerCategoryForm), findsOneWidget);
    });
  });

  group('add form', () {
    testWidgets('page title shows add', (WidgetTester tester) async {
      final mockCatService = TestMocks.categoriesService;
      final mockUserService = TestMocks.userService;

      when(mockUserService.user).thenReturn(managerOne);
      when(mockCatService.categories).thenAnswer((_) async => [categoryOne]);

      Get.parameters = ManagerCategoryFormConstants.ADD_MODE_PARAMETERS;

      await tester
          .pumpWidget(const TestableWidget(child: ManagerCategoryFormPage()));

      expect(find.text('Add Category'), findsOneWidget);
    });
  });

  group('edit form', () {
    testWidgets('page title shows edit', (WidgetTester tester) async {
      final mockCatService = TestMocks.categoriesService;
      final mockUserService = TestMocks.userService;

      when(mockUserService.user).thenReturn(managerOne);
      when(mockCatService.categories).thenAnswer((_) async => [categoryOne]);

      Get.parameters = ManagerCategoryFormConstants.EDIT_MODE_PARAMETERS;

      await tester
          .pumpWidget(const TestableWidget(child: ManagerCategoryFormPage()));

      expect(find.text('Edit Category'), findsOneWidget);
    });
  });

  group('icon picker', () {
    testWidgets('is shown on button click', (WidgetTester tester) async {
      final mockCatService = TestMocks.categoriesService;
      final mockUserService = TestMocks.userService;

      when(mockUserService.user).thenReturn(managerOne);
      when(mockCatService.categories).thenAnswer((_) async => [categoryOne]);

      Get.parameters = ManagerCategoryFormConstants.EDIT_MODE_PARAMETERS;

      await tester
          .pumpWidget(const TestableWidget(child: ManagerCategoryFormPage()));

      await tester.tap(find.text('Pick Icon'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
    });

    testWidgets('selected icon displays is rendered on the screen',
        (WidgetTester tester) async {
      final mockCatService = TestMocks.categoriesService;
      final mockUserService = TestMocks.userService;

      when(mockUserService.user).thenReturn(managerOne);
      when(mockCatService.categories).thenAnswer((_) async => [categoryOne]);

      Get.parameters = ManagerCategoryFormConstants.EDIT_MODE_PARAMETERS;

      await tester
          .pumpWidget(const TestableWidget(child: ManagerCategoryFormPage()));

      await tester.tap(find.text('Pick Icon'));
      await tester.pumpAndSettle();
      // this should be found as it is the first icon displayed
      await tester.tap(find.byIcon(Icons.ac_unit));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing);
      expect(find.byIcon(categoryOne.icon), findsOneWidget);
    });
  });
}
