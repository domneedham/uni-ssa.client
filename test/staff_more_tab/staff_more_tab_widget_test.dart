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

import '../mocks/mocks.dart';
import '../testable_widget.dart';
import 'staff_more_tab_test_data.dart';

void main() {
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

      when(mockUserRepo.staff).thenReturn(mockStaff);

      await tester.pumpWidget(TestableWidget(child: StaffMoreTab()));
      await tester.pumpAndSettle();

      expect(find.byType(Divider), findsNWidgets(3));
    });

    testWidgets('shows the user details section', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.staff).thenReturn(mockStaff);

      await tester.pumpWidget(TestableWidget(child: StaffMoreTab()));
      await tester.pumpAndSettle();

      expect(find.byType(StaffMoreTabUserDetails), findsOneWidget);
    });

    testWidgets('shows the profile header', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.staff).thenReturn(mockStaff);

      await tester.pumpWidget(TestableWidget(child: StaffMoreTab()));
      await tester.pumpAndSettle();

      expect(find.byType(UserProfileHeader), findsOneWidget);
    });

    testWidgets('shows the settings list', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.staff).thenReturn(mockStaff);

      await tester.pumpWidget(TestableWidget(child: StaffMoreTab()));
      await tester.pumpAndSettle();

      expect(find.byType(MoreTabSettings), findsOneWidget);
    });

    testWidgets('shows the app information', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.staff).thenReturn(mockStaff);

      await tester.pumpWidget(TestableWidget(child: StaffMoreTab()));
      await tester.pumpAndSettle();

      expect(find.byType(MoreTabAppInformation), findsOneWidget);
    });
  });

  group('staff more tab user details', () {
    group('edit details', () {
      testWidgets('shows edit your details text', (WidgetTester tester) async {
        final mockUserRepo = TestMocks.userRepository;

        when(mockUserRepo.staff).thenReturn(mockStaff);
        when(mockUserRepo.getManagerById(mockStaff.managerId))
            .thenAnswer((_) async => mockManager);

        await tester
            .pumpWidget(TestableWidget(child: StaffMoreTabUserDetails()));
        await tester.pumpAndSettle();

        expect(find.text('Edit Your Details'), findsOneWidget);
      });

      testWidgets('shows an edit button', (WidgetTester tester) async {
        final mockUserRepo = TestMocks.userRepository;

        when(mockUserRepo.staff).thenReturn(mockStaff);
        when(mockUserRepo.getManagerById(mockStaff.managerId))
            .thenAnswer((_) async => mockManager);

        await tester
            .pumpWidget(TestableWidget(child: StaffMoreTabUserDetails()));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.edit), findsOneWidget);
      });
    });

    group('manager list tile', () {
      testWidgets('shows a user list tile if successfully loaded',
          (WidgetTester tester) async {
        final mockUserRepo = TestMocks.userRepository;

        when(mockUserRepo.staff).thenReturn(mockStaff);
        when(mockUserRepo.getManagerById(mockStaff.managerId))
            .thenAnswer((_) async => mockManager);

        await tester.pumpWidget(
          TestableWidget(child: StaffMoreTabUserDetails()),
        );
        await tester.pumpAndSettle();

        expect(find.byType(UserListTile), findsOneWidget);
      });

      testWidgets('shows a loading user list tile whilst loading',
          (WidgetTester tester) async {
        final mockUserRepo = TestMocks.userRepository;

        when(mockUserRepo.staff).thenReturn(mockStaff);
        when(mockUserRepo.getManagerById(mockStaff.managerId))
            .thenAnswer((_) async => mockManager);

        await tester.pumpWidget(
          TestableWidget(child: StaffMoreTabUserDetails()),
        );

        expect(find.byType(LoadingUserListTile), findsOneWidget);
      });

      testWidgets('shows a loading failed user list tile if an error occurs',
          (WidgetTester tester) async {
        final mockUserRepo = TestMocks.userRepository;

        final error = Exception("Some error");

        when(mockUserRepo.staff).thenReturn(mockStaff);
        when(mockUserRepo.getManagerById(mockStaff.managerId))
            .thenAnswer((_) async => throw error);

        await tester.pumpWidget(
          TestableWidget(child: StaffMoreTabUserDetails()),
        );
        await tester.pumpAndSettle();

        expect(find.byType(LoadingFailedUserListTile), findsOneWidget);
      });
    });
  });
}
