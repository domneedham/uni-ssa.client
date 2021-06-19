import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/manager_more_tab_controller.dart';
import 'package:ssa_app/app/ui/pages/manager_more_tab/manager_more_tab.dart';
import 'package:ssa_app/app/ui/pages/manager_more_tab/manager_more_tab_app_information.dart';
import 'package:ssa_app/app/ui/pages/manager_more_tab/manager_more_tab_profile_header.dart';
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

  group('Manager more tab', () {
    testWidgets('There should be dividers between major sections',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.manager).thenReturn(mockManager);

      await tester.pumpWidget(TestableWidget(child: ManagerMoreTab()));
      await tester.pumpAndSettle();

      expect(find.byType(Divider), findsNWidgets(2));
    });

    testWidgets('Profile header should be rendered',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.manager).thenReturn(mockManager);

      await tester.pumpWidget(TestableWidget(child: ManagerMoreTab()));
      await tester.pumpAndSettle();

      expect(find.byType(ManagerMoreTabProfileHeader), findsOneWidget);
    });

    testWidgets('Settings list should be rendered',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.manager).thenReturn(mockManager);

      await tester.pumpWidget(TestableWidget(child: ManagerMoreTab()));
      await tester.pumpAndSettle();

      expect(find.byType(ManagerMoreTabSettings), findsOneWidget);
    });

    testWidgets('App information should be rendered',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.manager).thenReturn(mockManager);

      await tester.pumpWidget(TestableWidget(child: ManagerMoreTab()));
      await tester.pumpAndSettle();

      expect(find.byType(ManagerMoreTabAppInformation), findsOneWidget);
    });
  });

  group('Profile header', () {
    testWidgets('The name is shown in the profile',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.manager).thenReturn(mockManager);

      await tester
          .pumpWidget(TestableWidget(child: ManagerMoreTabProfileHeader()));
      await tester.pumpAndSettle();

      expect(find.text(mockManager.name), findsOneWidget);
    });

    testWidgets('The avatar is shown with the user initials',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.manager).thenReturn(mockManager);

      await tester
          .pumpWidget(TestableWidget(child: ManagerMoreTabProfileHeader()));
      await tester.pumpAndSettle();

      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.text(mockManager.name[0]), findsOneWidget);
    });
  });

  group('Settings list', () {
    testWidgets('An switch to toggle dark mode is rendered',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(child: ManagerMoreTabSettings()));
      await tester.pumpAndSettle();

      expect(find.byType(SwitchListTile), findsOneWidget);
      expect(find.text("Dark Mode"), findsOneWidget);
    });

    testWidgets('An option to logout is rendered', (WidgetTester tester) async {
      await tester.pumpWidget(TestableWidget(child: ManagerMoreTabSettings()));
      await tester.pumpAndSettle();

      expect(find.text("Logout"), findsOneWidget);
      expect(find.byIcon(Icons.logout), findsOneWidget);
    });
  });

  group('App information', () {
    testWidgets('An about list tile is rendered', (WidgetTester tester) async {
      await tester
          .pumpWidget(TestableWidget(child: ManagerMoreTabAppInformation()));
      await tester.pumpAndSettle();

      expect(find.byType(AboutListTile), findsOneWidget);
      expect(find.text("About"), findsOneWidget);
    });

    testWidgets('The about popup shows information about the developer',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(TestableWidget(child: ManagerMoreTabAppInformation()));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(AboutListTile));
      await tester.pumpAndSettle();

      expect(find.textContaining("Dominic Needham"), findsOneWidget);
    });
  });
}
