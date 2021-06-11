import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/manager_skill_overview_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_overview_page/manager_skill_overview_page.dart';

import '../mocks/mocks.dart';
import '../testable_widget.dart';
import './manager_skill_overview_test_data.dart';

void main() {
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

  testWidgets('Loading indicator is shown whilst the skill is loading',
      (WidgetTester tester) async {
    final mockSkillRepo = TestMocks.skillManagerRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockUserRepo.manager).thenReturn(managerOne);
    when(mockSkillRepo.getManagerStaffSkillById(1))
        .thenAnswer((_) async => skillOne);

    Get.parameters = {"id": "1"};

    // Build our app and trigger a frame.
    await tester.pumpWidget(TestableWidget(child: ManagerSkillOverviewPage()));

    expect(find.byType(LoadingIndicator), findsOneWidget);
  });

  testWidgets('Skill name text is shown after loading',
      (WidgetTester tester) async {
    final mockSkillRepo = TestMocks.skillManagerRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockUserRepo.manager).thenReturn(managerOne);
    when(mockSkillRepo.getManagerStaffSkillById(1))
        .thenAnswer((_) async => skillOne);

    Get.parameters = {"id": "1"};

    // Build our app and trigger a frame.
    await tester.pumpWidget(TestableWidget(child: ManagerSkillOverviewPage()));

    await tester.pumpAndSettle();

    expect(find.text(skillOne.name), findsOneWidget);
  });

  testWidgets('Skill category name is shown after loading',
      (WidgetTester tester) async {
    final mockSkillRepo = TestMocks.skillManagerRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockUserRepo.manager).thenReturn(managerOne);
    when(mockSkillRepo.getManagerStaffSkillById(1))
        .thenAnswer((_) async => skillOne);

    Get.parameters = {"id": "1"};

    // Build our app and trigger a frame.
    await tester.pumpWidget(TestableWidget(child: ManagerSkillOverviewPage()));

    await tester.pumpAndSettle();

    expect(find.text(skillOne.category.name), findsOneWidget);
  });

  testWidgets('Skill category icon is shown after loading',
      (WidgetTester tester) async {
    final mockSkillRepo = TestMocks.skillManagerRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockUserRepo.manager).thenReturn(managerOne);
    when(mockSkillRepo.getManagerStaffSkillById(1))
        .thenAnswer((_) async => skillOne);

    Get.parameters = {"id": "1"};

    // Build our app and trigger a frame.
    await tester.pumpWidget(TestableWidget(child: ManagerSkillOverviewPage()));

    await tester.pumpAndSettle();

    expect(find.byIcon(skillOne.category.icon), findsOneWidget);
  });

  testWidgets('Skill staff list is shown after loading',
      (WidgetTester tester) async {
    final mockSkillRepo = TestMocks.skillManagerRepository;
    final mockUserRepo = TestMocks.userRepository;

    when(mockUserRepo.manager).thenReturn(managerOne);
    when(mockUserRepo.getStaffById(1)).thenAnswer((_) async => staffOne);
    when(mockSkillRepo.getManagerStaffSkillById(1))
        .thenAnswer((_) async => skillOne);

    Get.parameters = {"id": "1"};

    // Build our app and trigger a frame.
    await tester.pumpWidget(TestableWidget(child: ManagerSkillOverviewPage()));

    await tester.pumpAndSettle();

    expect(find.text(staffOne.name), findsOneWidget);
  });
}
