import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/manager_more_tab_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/more_tab_app_information.dart';
import 'package:ssa_app/app/ui/global_widgets/user_profile_header.dart';
import 'package:ssa_app/app/ui/pages/manager_more_tab/manager_more_tab.dart';
import 'package:ssa_app/app/ui/pages/manager_more_tab/manager_more_tab_settings.dart';

import '../mocks/mocks.dart';
import '../testable_widget.dart';
import 'manager_more_tab_test_data.dart';

void main() {
  final binding = BindingsBuilder(() {
    Get.lazyPut<ManagerMoreTabController>(() => ManagerMoreTabController());
  });

  setUp(() async {
    Get.testMode = true;
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  group('manager more tab', () {
    testWidgets('shows dividers between major sections',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.manager).thenReturn(mockManager);

      await tester.pumpWidget(TestableWidget(child: ManagerMoreTab()));
      await tester.pumpAndSettle();

      expect(find.byType(Divider), findsNWidgets(2));
    });

    testWidgets('shows the profile header', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.manager).thenReturn(mockManager);

      await tester.pumpWidget(TestableWidget(child: ManagerMoreTab()));
      await tester.pumpAndSettle();

      expect(find.byType(UserProfileHeader), findsOneWidget);
    });

    testWidgets('shows the settings list', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.manager).thenReturn(mockManager);

      await tester.pumpWidget(TestableWidget(child: ManagerMoreTab()));
      await tester.pumpAndSettle();

      expect(find.byType(ManagerMoreTabSettings), findsOneWidget);
    });

    testWidgets('shows the app information', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.manager).thenReturn(mockManager);

      await tester.pumpWidget(TestableWidget(child: ManagerMoreTab()));
      await tester.pumpAndSettle();

      expect(find.byType(MoreTabAppInformation), findsOneWidget);
    });
  });

  group('settings list', () {
    testWidgets('shows a switch to toggle dark mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(child: ManagerMoreTabSettings()));
      await tester.pumpAndSettle();

      expect(find.byType(SwitchListTile), findsOneWidget);
      expect(find.text("Dark Mode"), findsOneWidget);
    });

    testWidgets('shows an option to logout', (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(child: ManagerMoreTabSettings()));
      await tester.pumpAndSettle();

      expect(find.text("Logout"), findsOneWidget);
      expect(find.byIcon(Icons.logout), findsOneWidget);
    });
  });
}
