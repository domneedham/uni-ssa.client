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
      final mockSkillRepo = TestMocks.skillManagerRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.manager).thenReturn(managerOne);
      when(mockSkillRepo.getManagerStaffSkillById(1))
          .thenAnswer((_) async => skillOne);

      Get.parameters = {"id": "1"};

      await tester
          .pumpWidget(TestableWidget(child: ManagerSkillOverviewPage()));

      expect(find.byType(LoadingIndicator), findsOneWidget);
    });

    testWidgets('shows the skill name after loading',
        (WidgetTester tester) async {
      final mockSkillRepo = TestMocks.skillManagerRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.manager).thenReturn(managerOne);
      when(mockSkillRepo.getManagerStaffSkillById(1))
          .thenAnswer((_) async => skillOne);

      Get.parameters = {"id": "1", "name": skillOne.name};

      await tester
          .pumpWidget(TestableWidget(child: ManagerSkillOverviewPage()));
      await tester.pumpAndSettle();

      expect(find.text(skillOne.name), findsOneWidget);
    });

    testWidgets('shows the skill category name after loading',
        (WidgetTester tester) async {
      final mockSkillRepo = TestMocks.skillManagerRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.manager).thenReturn(managerOne);
      when(mockSkillRepo.getManagerStaffSkillById(1))
          .thenAnswer((_) async => skillOne);

      Get.parameters = {"id": "1"};

      await tester
          .pumpWidget(TestableWidget(child: ManagerSkillOverviewPage()));
      await tester.pumpAndSettle();

      expect(find.text(skillOne.category.name), findsOneWidget);
    });

    testWidgets('shows the skill category icon after loading',
        (WidgetTester tester) async {
      final mockSkillRepo = TestMocks.skillManagerRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.manager).thenReturn(managerOne);
      when(mockSkillRepo.getManagerStaffSkillById(1))
          .thenAnswer((_) async => skillOne);

      Get.parameters = {"id": "1"};

      await tester
          .pumpWidget(TestableWidget(child: ManagerSkillOverviewPage()));
      await tester.pumpAndSettle();

      expect(find.byIcon(skillOne.category.icon), findsOneWidget);
    });

    testWidgets('shows the skill staff list after loading',
        (WidgetTester tester) async {
      final mockSkillRepo = TestMocks.skillManagerRepository;
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.manager).thenReturn(managerOne);
      when(mockSkillRepo.getManagerStaffSkillById(1))
          .thenAnswer((_) async => skillOne);

      Get.parameters = {"id": "1"};

      await tester
          .pumpWidget(TestableWidget(child: ManagerSkillOverviewPage()));
      await tester.pumpAndSettle();

      expect(find.text(skillOne.staff.first.name), findsOneWidget);
    });
  });
}
