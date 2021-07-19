import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/manager_skill_form_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_form_page/manager_skill_form.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_form_page/manager_skill_form_page.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_form_page/utils/manager_skill_form_constants.dart';

import '../mocks/mocks.dart';
import '../testable_widget.dart';
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

  group('page', () {
    testWidgets('shows a loading indicator whilst the page is loading',
        (WidgetTester tester) async {
      final mockCatRepo = TestMocks.categoriesRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.manager).thenReturn(managerOne);
      when(mockCatRepo.categories).thenAnswer((_) async => [categoryOne]);

      Get.parameters = ManagerSkillFormConstants.ADD_MODE_PARAMETERS;

      await tester.pumpWidget(TestableWidget(child: ManagerSkillFormPage()));

      expect(find.byType(LoadingIndicator), findsOneWidget);
    });

    testWidgets('If no categories are loaded, a prompt is rendered',
        (WidgetTester tester) async {
      final mockCatRepo = TestMocks.categoriesRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.manager).thenReturn(managerOne);
      when(mockCatRepo.categories).thenAnswer((_) async => []);

      Get.parameters = ManagerSkillFormConstants.ADD_MODE_PARAMETERS;

      await tester.pumpWidget(TestableWidget(child: ManagerSkillFormPage()));
      await tester.pumpAndSettle();

      expect(find.text("You must create a category first"), findsOneWidget);
    });

    testWidgets('shows the form if categories are loaded',
        (WidgetTester tester) async {
      final mockCatRepo = TestMocks.categoriesRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.manager).thenReturn(managerOne);
      when(mockCatRepo.categories).thenAnswer((_) async => [categoryOne]);

      Get.parameters = ManagerSkillFormConstants.ADD_MODE_PARAMETERS;

      await tester.pumpWidget(TestableWidget(child: ManagerSkillFormPage()));
      await tester.pumpAndSettle();

      expect(find.byType(ManagerSkillForm), findsOneWidget);
    });

    testWidgets('shows error text if an error occurs',
        (WidgetTester tester) async {
      final mockCatRepo = TestMocks.categoriesRepository;
      final mockUserRepo = TestMocks.userRepository;

      final exception = Exception("Issue");

      when(mockUserRepo.manager).thenReturn(managerOne);
      when(mockCatRepo.categories).thenAnswer((_) async => throw exception);

      Get.parameters = ManagerSkillFormConstants.ADD_MODE_PARAMETERS;

      await tester.pumpWidget(TestableWidget(child: ManagerSkillFormPage()));
      await tester.pumpAndSettle();

      expect(find.text(exception.toString()), findsOneWidget);
    });
  });

  group('add form', () {
    testWidgets('page title shows add', (WidgetTester tester) async {
      final mockCatRepo = TestMocks.categoriesRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.manager).thenReturn(managerOne);
      when(mockCatRepo.categories).thenAnswer((_) async => [categoryOne]);

      Get.parameters = ManagerSkillFormConstants.ADD_MODE_PARAMETERS;

      await tester.pumpWidget(TestableWidget(child: ManagerSkillFormPage()));

      expect(find.text("Add Skill"), findsOneWidget);
    });
  });

  group('edit form', () {
    testWidgets('Page title shows edit', (WidgetTester tester) async {
      final mockCatRepo = TestMocks.categoriesRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.manager).thenReturn(managerOne);
      when(mockCatRepo.categories).thenAnswer((_) async => [categoryOne]);

      Get.parameters = ManagerSkillFormConstants.EDIT_MODE_PARAMETERS;

      await tester.pumpWidget(TestableWidget(child: ManagerSkillFormPage()));

      expect(find.text("Edit Skill"), findsOneWidget);
    });
  });
}
