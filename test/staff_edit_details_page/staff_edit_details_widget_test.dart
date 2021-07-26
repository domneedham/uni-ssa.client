import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/controllers/staff_edit_details_controller.dart';
import 'package:ssa_app/app/ui/staff_edit_details_page/staff_edit_details_page.dart';

import '../mocks/mocks.dart';
import '../testable_widget.dart';
import 'staff_edit_details_test_data.dart';

void main() {
  final binding = BindingsBuilder(() {
    Get.lazyPut<StaffEditDetailsController>(() => StaffEditDetailsController());
  });

  setUp(() async {
    Get.testMode = true;
    binding.builder();
  });

  tearDown(() async {
    Get.reset();
  });

  group('page', () {
    testWidgets('shows the right title in the appbar',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.user).thenReturn(mockStaff);

      await tester.pumpWidget(TestableWidget(child: StaffEditDetailsPage()));

      expect(find.text('Edit Details'), findsOneWidget);
    });

    testWidgets('shows a save button', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.user).thenReturn(mockStaff);

      await tester.pumpWidget(TestableWidget(child: StaffEditDetailsPage()));

      expect(find.byIcon(Icons.save), findsOneWidget);
    });
  });

  group('form', () {
    testWidgets('has a field for firstname', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.user).thenReturn(mockStaff);

      await tester.pumpWidget(TestableWidget(child: StaffEditDetailsPage()));

      expect(find.text('Firstname'), findsOneWidget);
    });

    testWidgets('has a field for surname', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.user).thenReturn(mockStaff);

      await tester.pumpWidget(TestableWidget(child: StaffEditDetailsPage()));

      expect(find.text('Surname'), findsOneWidget);
    });

    testWidgets('populates the firstname field on load',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.user).thenReturn(mockStaff);

      await tester.pumpWidget(TestableWidget(child: StaffEditDetailsPage()));
      await tester.pumpAndSettle();

      expect(find.text(mockStaff.firstname), findsOneWidget);
    });

    testWidgets('populates the surname field on load',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.user).thenReturn(mockStaff);

      await tester.pumpWidget(TestableWidget(child: StaffEditDetailsPage()));
      await tester.pumpAndSettle();

      expect(find.text(mockStaff.surname), findsOneWidget);
    });
  });
}
