import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/staff_more_tab_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/more_tab_app_information.dart';
import 'package:ssa_app/app/ui/global_widgets/more_tab_settings.dart';
import 'package:ssa_app/app/ui/global_widgets/user_list_tile.dart';
import 'package:ssa_app/app/ui/global_widgets/user_profile_header.dart';
import 'package:ssa_app/app/ui/pages/staff_more_tab/staff_more_tab.dart';
import 'package:ssa_app/app/ui/pages/staff_more_tab/staff_more_tab_user_details.dart';

import '../mocks/data.dart';
import '../mocks/mocks.dart';
import '../testable_widget.dart';

void main() {
  final staffOne = TestData.mockStaffWithExpirySkills;

  final binding = BindingsBuilder(() {
    Get.lazyPut<StaffMoreTabController>(() => StaffMoreTabController());
  });

  setUp(() async {
    Get.testMode = true;
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  group('staff more tab', () {
    testWidgets('shows dividers between major sections',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.user).thenReturn(staffOne);

      await tester.pumpWidget(const TestableWidget(child: StaffMoreTab()));
      await tester.pumpAndSettle();

      expect(find.byType(Divider), findsNWidgets(3));
    });

    testWidgets('shows the user details section', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.user).thenReturn(staffOne);

      await tester.pumpWidget(const TestableWidget(child: StaffMoreTab()));
      await tester.pumpAndSettle();

      expect(find.byType(StaffMoreTabUserDetails), findsOneWidget);
    });

    testWidgets('shows the profile header', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.user).thenReturn(staffOne);

      await tester.pumpWidget(const TestableWidget(child: StaffMoreTab()));
      await tester.pumpAndSettle();

      expect(find.byType(UserProfileHeader), findsOneWidget);
    });

    testWidgets('shows the settings list', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.user).thenReturn(staffOne);

      await tester.pumpWidget(const TestableWidget(child: StaffMoreTab()));
      await tester.pumpAndSettle();

      expect(find.byType(MoreTabSettings), findsOneWidget);
    });

    testWidgets('shows the app information', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.user).thenReturn(staffOne);

      await tester.pumpWidget(const TestableWidget(child: StaffMoreTab()));
      await tester.pumpAndSettle();

      expect(find.byType(MoreTabAppInformation), findsOneWidget);
    });
  });

  group('staff more tab user details', () {
    group('edit details', () {
      testWidgets('shows edit your details text', (WidgetTester tester) async {
        final mockUserRepo = TestMocks.userRepository;

        when(mockUserRepo.user).thenReturn(staffOne);

        await tester
            .pumpWidget(const TestableWidget(child: StaffMoreTabUserDetails()));
        await tester.pumpAndSettle();

        expect(find.text('Edit Your Details'), findsOneWidget);
      });

      testWidgets('shows an edit button', (WidgetTester tester) async {
        final mockUserRepo = TestMocks.userRepository;

        when(mockUserRepo.user).thenReturn(staffOne);

        await tester
            .pumpWidget(const TestableWidget(child: StaffMoreTabUserDetails()));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.edit), findsOneWidget);
      });
    });

    group('manager list tile', () {
      testWidgets('shows a user list tile if successfully loaded',
          (WidgetTester tester) async {
        final mockUserRepo = TestMocks.userRepository;

        when(mockUserRepo.user).thenReturn(staffOne);

        await tester.pumpWidget(
          const TestableWidget(child: StaffMoreTabUserDetails()),
        );
        await tester.pumpAndSettle();

        expect(find.byType(UserListTile), findsOneWidget);
      });
    });
  });
}
