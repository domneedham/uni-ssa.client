import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/manager_skill_overview_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_overview_page/manager_skill_overview_page.dart';

import '../mocks/data.dart';
import '../mocks/mocks.dart';
import '../testable_widget.dart';

void main() {
  final managerOne = TestData.mockManagerWithStaff;
  final skillOne = TestData.mockManagerStaffSkillOne;

  final binding = BindingsBuilder(() {
    Get.lazyPut<ManagerSkillOverviewController>(
        () => ManagerSkillOverviewController());
  });

  setUp(() async {
    Get.testMode = true;
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  group('page', () {
    testWidgets('loading indicator is shown whilst the skill is loading',
        (WidgetTester tester) async {
      final mockSkillService = TestMocks.skillManagerService;
      final mockUserService = TestMocks.userService;
      TestMocks.skillService;

      when(mockUserService.user).thenReturn(managerOne);
      when(mockSkillService.getManagerStaffSkillById(1))
          .thenAnswer((_) async => skillOne);

      Get.parameters = {'id': '1'};

      await tester
          .pumpWidget(const TestableWidget(child: ManagerSkillOverviewPage()));

      expect(find.byType(LoadingIndicator), findsOneWidget);
    });

    testWidgets('shows the skill name after loading',
        (WidgetTester tester) async {
      final mockSkillService = TestMocks.skillManagerService;
      final mockUserService = TestMocks.userService;
      TestMocks.skillService;

      when(mockUserService.user).thenReturn(managerOne);
      when(mockSkillService.getManagerStaffSkillById(1))
          .thenAnswer((_) async => skillOne);

      Get.parameters = {'id': '1', 'name': skillOne.name};

      await tester
          .pumpWidget(const TestableWidget(child: ManagerSkillOverviewPage()));
      await tester.pumpAndSettle();

      expect(find.text(skillOne.name), findsOneWidget);
    });

    testWidgets('shows the skill category name after loading',
        (WidgetTester tester) async {
      final mockSkillService = TestMocks.skillManagerService;
      final mockUserService = TestMocks.userService;
      TestMocks.skillService;

      when(mockUserService.user).thenReturn(managerOne);
      when(mockSkillService.getManagerStaffSkillById(1))
          .thenAnswer((_) async => skillOne);

      Get.parameters = {'id': '1'};

      await tester
          .pumpWidget(const TestableWidget(child: ManagerSkillOverviewPage()));
      await tester.pumpAndSettle();

      expect(find.text(skillOne.category.name), findsOneWidget);
    });

    testWidgets('shows the skill category icon after loading',
        (WidgetTester tester) async {
      final mockSkillService = TestMocks.skillManagerService;
      final mockUserService = TestMocks.userService;
      TestMocks.skillService;

      when(mockUserService.user).thenReturn(managerOne);
      when(mockSkillService.getManagerStaffSkillById(1))
          .thenAnswer((_) async => skillOne);

      Get.parameters = {'id': '1'};

      await tester
          .pumpWidget(const TestableWidget(child: ManagerSkillOverviewPage()));
      await tester.pumpAndSettle();

      expect(find.byIcon(skillOne.category.icon), findsOneWidget);
    });

    testWidgets('shows the skill staff list after loading',
        (WidgetTester tester) async {
      final mockSkillService = TestMocks.skillManagerService;
      final mockUserService = TestMocks.userService;
      TestMocks.skillService;

      when(mockUserService.user).thenReturn(managerOne);
      when(mockSkillService.getManagerStaffSkillById(1))
          .thenAnswer((_) async => skillOne);

      Get.parameters = {'id': '1'};

      await tester
          .pumpWidget(const TestableWidget(child: ManagerSkillOverviewPage()));
      await tester.pumpAndSettle();

      expect(find.text(skillOne.staff.first.name), findsOneWidget);
    });
  });

  group('delete', () {
    testWidgets('should popup an alert dialog', (tester) async {
      final skillManagerService = TestMocks.skillManagerService;
      final userService = TestMocks.userService;
      final skillService = TestMocks.skillService;

      Get.parameters = {'id': '1'};

      when(userService.user).thenReturn(managerOne);
      when(skillManagerService.getManagerStaffSkillById(1))
          .thenAnswer((_) async => skillOne);
      // ignore: avoid_returning_null_for_void
      when(skillService.delete(1)).thenAnswer((_) async => null);

      await tester
          .pumpWidget(const TestableWidget(child: ManagerSkillOverviewPage()));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
    });

    group('alert dialog', () {
      testWidgets('should give a yes and no option', (tester) async {
        final skillManagerService = TestMocks.skillManagerService;
        final userService = TestMocks.userService;
        final skillService = TestMocks.skillService;

        Get.parameters = {'id': '1'};

        when(userService.user).thenReturn(managerOne);
        when(skillManagerService.getManagerStaffSkillById(1))
            .thenAnswer((_) async => skillOne);
        // ignore: avoid_returning_null_for_void
        when(skillService.delete(1)).thenAnswer((_) async => null);

        await tester.pumpWidget(
            const TestableWidget(child: ManagerSkillOverviewPage()));
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.delete));
        await tester.pumpAndSettle();

        expect(find.text('Yes'), findsOneWidget);
        expect(find.text('No'), findsOneWidget);
      });
    });

    group('no option', () {
      testWidgets('should dismiss the dialog', (tester) async {
        final skillManagerService = TestMocks.skillManagerService;
        final userService = TestMocks.userService;
        final skillService = TestMocks.skillService;

        Get.parameters = {'id': '1'};

        when(userService.user).thenReturn(managerOne);
        when(skillManagerService.getManagerStaffSkillById(1))
            .thenAnswer((_) async => skillOne);
        // ignore: avoid_returning_null_for_void
        when(skillService.delete(1)).thenAnswer((_) async => null);

        await tester.pumpWidget(
            const TestableWidget(child: ManagerSkillOverviewPage()));
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.delete));
        await tester.pumpAndSettle();

        await tester.tap(find.text('No'));
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsNothing);
      });
    });

    group('yes option', () {
      testWidgets('should dismiss the dialog', (tester) async {
        final skillManagerService = TestMocks.skillManagerService;
        final userService = TestMocks.userService;
        final skillService = TestMocks.skillService;

        Get.parameters = {'id': '1'};

        when(userService.user).thenReturn(managerOne);
        when(skillManagerService.getManagerStaffSkillById(1))
            .thenAnswer((_) async => skillOne);
        // ignore: avoid_returning_null_for_void
        when(skillService.delete(1)).thenAnswer((_) async => null);

        await tester.pumpWidget(
            const TestableWidget(child: ManagerSkillOverviewPage()));
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.delete));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Yes'));
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsNothing);
      });

      testWidgets('should call delete method on the controller',
          (tester) async {
        final skillManagerService = TestMocks.skillManagerService;
        final userService = TestMocks.userService;
        final skillService = TestMocks.skillService;

        Get.parameters = {'id': '1'};

        when(userService.user).thenReturn(managerOne);
        when(skillManagerService.getManagerStaffSkillById(1))
            .thenAnswer((_) async => skillOne);
        // ignore: avoid_returning_null_for_void
        when(skillService.delete(1)).thenAnswer((_) async => null);

        await tester.pumpWidget(
            const TestableWidget(child: ManagerSkillOverviewPage()));
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.delete));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Yes'));
        await tester.pumpAndSettle();

        verify(skillService.delete(1)).called(1);
      });
    });
  });
}
