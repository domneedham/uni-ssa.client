import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/manager_staff_tab_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/pages/manager_staff_tab/manager_staff_tab.dart';
import 'package:ssa_app/app/ui/pages/manager_staff_tab/manager_staff_tab_list.dart';
import 'package:ssa_app/app/ui/pages/manager_staff_tab/manager_staff_tab_search.dart';
import 'package:ssa_app/app/ui/pages/manager_staff_tab/manager_tab/manager_staff_tab_manager.dart';
import 'package:ssa_app/app/ui/pages/manager_staff_tab/staff_tab/manager_staff_tab_staff.dart';

import '../mocks/data.dart';
import '../mocks/mocks.dart';
import '../testable_widget.dart';

void main() {
  final managerOne = TestData.mockManagerWithStaff;
  final staffOne = TestData.mockStaffNoSkills;

  final binding = BindingsBuilder(() {
    Get.lazyPut<ManagerStaffTabController>(() => ManagerStaffTabController());
  });

  setUp(() async {
    Get.testMode = true;
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  group('manager staff tab', () {
    testWidgets('the appbar shows the right title',
        (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;

      when(mockUserService.user).thenReturn(managerOne);

      await tester.pumpWidget(const TestableWidget(child: ManagerStaffTab()));
      await tester.pumpAndSettle();

      expect(
          find.byWidgetPredicate((widget) =>
              widget is AppBar &&
              widget.title is Text &&
              (widget.title as Text).data == 'Staff'),
          findsOneWidget);
    });

    testWidgets('the tabbar has two tabs', (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;

      when(mockUserService.user).thenReturn(managerOne);

      await tester.pumpWidget(const TestableWidget(child: ManagerStaffTab()));
      await tester.pumpAndSettle();

      expect(find.byType(TabBar), findsOneWidget);
      expect(
          find.byWidgetPredicate(
              (widget) => widget is Tab && widget.text == 'Staff'),
          findsOneWidget);
      expect(
          find.byWidgetPredicate(
              (widget) => widget is Tab && widget.text == 'Managers'),
          findsOneWidget);
    });

    testWidgets('clicking on the staff tab shows the right widget',
        (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;

      when(mockUserService.user).thenReturn(managerOne);

      await tester.pumpWidget(const TestableWidget(child: ManagerStaffTab()));
      await tester.pumpAndSettle();

      await tester.tap(find.byWidgetPredicate(
          (widget) => widget is Tab && widget.text == 'Staff'));
      await tester.pumpAndSettle();

      expect(find.byType(ManagerStaffTabStaff), findsOneWidget);
    });

    testWidgets('clicking on the staff tab shows the right widget',
        (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;

      when(mockUserService.user).thenReturn(managerOne);

      await tester.pumpWidget(const TestableWidget(child: ManagerStaffTab()));
      await tester.pumpAndSettle();

      await tester.tap(find.byWidgetPredicate(
          (widget) => widget is Tab && widget.text == 'Managers'));
      await tester.pumpAndSettle();

      expect(find.byType(ManagerStaffTabManager), findsOneWidget);
    });
  });

  group('manager staff tab for staff search', () {
    testWidgets(
        'search box shows appropriate messsage to show searching for staff',
        (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;

      when(mockUserService.user).thenReturn(managerOne);

      await tester
          .pumpWidget(const TestableWidget(child: ManagerStaffTabStaff()));
      await tester.pumpAndSettle();

      expect(find.textContaining('Search'), findsOneWidget);
      expect(find.textContaining('staff member'), findsOneWidget);
    });
  });

  group('manager staff tab for manager search', () {
    testWidgets(
        'search box shows appropriate messsage to show searching for manager',
        (WidgetTester tester) async {
      final mockUserService = TestMocks.userService;

      when(mockUserService.user).thenReturn(managerOne);

      await tester
          .pumpWidget(const TestableWidget(child: ManagerStaffTabManager()));
      await tester.pumpAndSettle();

      expect(find.textContaining('Search'), findsOneWidget);
      expect(find.textContaining('manager'), findsOneWidget);
    });
  });

  group('manager staff tab search', () {
    testWidgets('the hint text is shown', (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: ManagerStaffTabSearch(
          hintText: 'Hello',
          textController: TextEditingController(),
        ),
      ));

      expect(find.text('Hello'), findsOneWidget);
    });
    testWidgets('a search icon is shown', (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: ManagerStaffTabSearch(
          hintText: 'Hello',
          textController: TextEditingController(),
        ),
      ));

      expect(find.byIcon(Icons.search), findsOneWidget);
    });
  });

  group('manager staff tab list', () {
    testWidgets(
        'shows a prompt to show the app is waiting for the user if the search box is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: ManagerStaffTabList(
          isLoading: false,
          searchText: '',
          staffList: const [],
          onPressed: (int? _) {},
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Waiting for a search'), findsOneWidget);
    });

    testWidgets('shows happening a loading indicator if searching',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: ManagerStaffTabList(
          isLoading: true,
          searchText: '',
          staffList: const [],
          onPressed: (int? _) {},
        ),
      ));

      expect(find.byType(LoadingIndicator), findsOneWidget);
    });

    testWidgets('if no staff items are found a message is shown to the user',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: ManagerStaffTabList(
          isLoading: false,
          searchText: 'Not empty',
          staffList: const [],
          onPressed: (int? _) {},
        ),
      ));

      expect(find.text('No staff found'), findsOneWidget);
    });

    testWidgets('shows a message to the user if no manager items are found',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: ManagerStaffTabList(
          isLoading: false,
          searchText: 'Not empty',
          managerList: const [],
          onPressed: (int? _) {},
        ),
      ));

      expect(find.text('No managers found'), findsOneWidget);
    });

    testWidgets('shows a list of items if items are found',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: ManagerStaffTabList(
          isLoading: false,
          searchText: 'Not empty',
          staffList: [staffOne],
          onPressed: (int? _) {},
        ),
      ));

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('the list is populated if staff items are found',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: ManagerStaffTabList(
          isLoading: false,
          searchText: 'Not empty',
          staffList: [staffOne],
          onPressed: (int? _) {},
        ),
      ));

      expect(find.text(staffOne.name), findsOneWidget);
    });

    testWidgets('the list is populated if manager items are found',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: ManagerStaffTabList(
          isLoading: false,
          searchText: 'Not empty',
          managerList: [managerOne],
          onPressed: (int? _) {},
        ),
      ));

      expect(find.text(managerOne.name), findsOneWidget);
    });
  });
}
