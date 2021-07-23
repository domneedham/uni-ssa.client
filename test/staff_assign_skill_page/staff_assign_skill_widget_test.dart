import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/staff_assign_skill_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/pages/staff_assign_skill_page/staff_assign_skill_list.dart';
import 'package:ssa_app/app/ui/pages/staff_assign_skill_page/staff_assign_skill_page.dart';
import 'package:ssa_app/app/ui/pages/staff_assign_skill_page/staff_assign_skill_search.dart';

import '../mocks/mocks.dart';
import '../testable_widget.dart';
import 'staff_assign_skill_test_data.dart';

void main() {
  final binding = BindingsBuilder(() {
    Get.lazyPut<StaffAssignSkillController>(() => StaffAssignSkillController());
  });

  setUp(() async {
    Get.testMode = true;
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  group('staff assign skill page', () {
    testWidgets('appbar shows the right title', (WidgetTester tester) async {
      TestMocks.userRepository;
      TestMocks.skillStaffRepository;

      await tester.pumpWidget(TestableWidget(child: StaffAssignSkillPage()));

      expect(find.text('Assign Skill'), findsOneWidget);
    });
  });

  group('staff assign skill search', () {
    testWidgets('the hint text is shown', (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: StaffAssignSkillSearch(
          hintText: "Hello",
          textController: TextEditingController(),
        ),
      ));

      expect(find.text("Hello"), findsOneWidget);
    });

    testWidgets('a search icon is shown', (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: StaffAssignSkillSearch(
          hintText: "Hello",
          textController: TextEditingController(),
        ),
      ));

      expect(find.byIcon(Icons.search), findsOneWidget);
    });
  });

  group('staff assign skill list', () {
    testWidgets(
        'shows a prompt to show the app is waiting for the user if the search box is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: StaffAssignSkillList(
          isLoading: false,
          searchText: "",
          skillList: [],
          onPressed: (int _) {},
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text("Waiting for a search"), findsOneWidget);
    });

    testWidgets('shows a loading indicator if searching',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: StaffAssignSkillList(
          isLoading: true,
          searchText: "",
          skillList: [],
          onPressed: (int _) {},
        ),
      ));

      expect(find.byType(LoadingIndicator), findsOneWidget);
    });

    testWidgets('if no staff items are found a message is shown to the user',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: StaffAssignSkillList(
          isLoading: false,
          searchText: "Not empty",
          skillList: [],
          onPressed: (int _) {},
        ),
      ));

      expect(find.text("No skills found"), findsOneWidget);
    });

    testWidgets('shows an item if items are found',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: StaffAssignSkillList(
          isLoading: false,
          searchText: "Not empty",
          skillList: [mockSkillOne],
          onPressed: (int _) {},
        ),
      ));

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('shows a list of items if items are found',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: StaffAssignSkillList(
          isLoading: false,
          searchText: "Not empty",
          skillList: [mockSkillOne, mockSkillTwo],
          onPressed: (int _) {},
        ),
      ));

      expect(find.byType(ListTile), findsNWidgets(2));
    });
  });

  group('staff assign skill list tile', () {
    testWidgets('shows the name', (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: StaffAssignSkillList(
          isLoading: false,
          searchText: "Not empty",
          skillList: [mockSkillOne],
          onPressed: (int _) {},
        ),
      ));

      expect(find.text(mockSkillOne.name), findsOneWidget);
    });

    testWidgets('shows the category name', (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: StaffAssignSkillList(
          isLoading: false,
          searchText: "Not empty",
          skillList: [mockSkillOne],
          onPressed: (int _) {},
        ),
      ));

      expect(find.text(mockSkillOne.category.name), findsOneWidget);
    });

    testWidgets('shows add icon', (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(
        child: StaffAssignSkillList(
          isLoading: false,
          searchText: "Not empty",
          skillList: [mockSkillOne],
          onPressed: (int _) {},
        ),
      ));

      expect(find.byIcon(Icons.add), findsOneWidget);
    });
  });
}
