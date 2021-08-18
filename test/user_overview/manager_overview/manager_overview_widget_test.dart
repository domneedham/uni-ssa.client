import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/manager_overview_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/global_widgets/staff_list.dart';
import 'package:ssa_app/app/ui/global_widgets/user_profile_header.dart';
import 'package:ssa_app/app/ui/pages/user_overview/manager_overview/manager_overview_page.dart';

import '../../mocks/data.dart';
import '../../mocks/mocks.dart';
import '../../testable_widget.dart';

void main() {
  final managerOne = TestData.mockManagerWithStaff;

  final binding = BindingsBuilder(() {
    Get.lazyPut<ManagerOverviewController>(() => ManagerOverviewController());
  });

  setUp(() async {
    Get.testMode = true;
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  group('page', () {
    testWidgets('shows a loading indicator whilst loading',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.getManagerById(1)).thenAnswer((_) async => managerOne);

      Get.parameters = {'id': '1'};

      await tester
          .pumpWidget(const TestableWidget(child: ManagerOverviewPage()));

      expect(find.byType(LoadingIndicator), findsOneWidget);
    });

    testWidgets('shows the error text if an error occurs',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      final error = Exception('Some error');

      when(mockUserRepo.getManagerById(1)).thenAnswer((_) async => throw error);

      Get.parameters = {'id': '1'};

      await tester
          .pumpWidget(const TestableWidget(child: ManagerOverviewPage()));
      await tester.pumpAndSettle();

      expect(find.text(error.toString()), findsOneWidget);
    });

    testWidgets('shows the profile header of the manager if successful',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.getManagerById(1)).thenAnswer((_) async => managerOne);

      Get.parameters = {'id': '1'};

      await tester
          .pumpWidget(const TestableWidget(child: ManagerOverviewPage()));
      await tester.pumpAndSettle();

      expect(find.byType(UserProfileHeader), findsOneWidget);
    });

    testWidgets('shows the staff list of the manager if successful',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.getManagerById(1)).thenAnswer((_) async => managerOne);

      Get.parameters = {'id': '1'};

      await tester
          .pumpWidget(const TestableWidget(child: ManagerOverviewPage()));
      await tester.pumpAndSettle();

      expect(find.byType(StaffList), findsOneWidget);
    });
  });
}
