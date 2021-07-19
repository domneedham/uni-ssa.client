import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/ui/global_widgets/staff_list.dart';

import '../mocks/mocks.dart';
import '../testable_widget.dart';

final mockStaffOne =
    Staff(id: 1, firstname: "Test", surname: "One", skills: [], managerId: 1);
final mockStaffTwo =
    Staff(id: 2, firstname: "Test", surname: "Two", skills: [], managerId: 1);

final staffList = [mockStaffOne.id, mockStaffTwo.id];

void main() {
  group('when loading', () {
    testWidgets('the name is shown as loading user',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.getStaffById(1)).thenAnswer((_) async => mockStaffOne);
      when(mockUserRepo.getStaffById(2)).thenAnswer((_) async => mockStaffTwo);

      await tester.pumpWidget(
        TestableWidget(
          child: StaffList(
            staffList: staffList,
            future: (int id) => mockUserRepo.getStaffById(id),
          ),
        ),
      );

      expect(find.text("Loading user..."), findsNWidgets(2));
    });
  });

  group('after successful loading', () {
    testWidgets('the name is shown', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.getStaffById(1)).thenAnswer((_) async => mockStaffOne);
      when(mockUserRepo.getStaffById(2)).thenAnswer((_) async => mockStaffTwo);

      await tester.pumpWidget(
        TestableWidget(
          child: StaffList(
            staffList: staffList,
            future: (int id) => mockUserRepo.getStaffById(id),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text("Test One"), findsOneWidget);
      expect(find.text("Test Two"), findsOneWidget);
    });

    testWidgets('the person icon is shown', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      when(mockUserRepo.getStaffById(1)).thenAnswer((_) async => mockStaffOne);
      when(mockUserRepo.getStaffById(2)).thenAnswer((_) async => mockStaffTwo);

      await tester.pumpWidget(
        TestableWidget(
          child: StaffList(
            staffList: staffList,
            future: (int id) => mockUserRepo.getStaffById(id),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.person), findsNWidgets(2));
    });
  });

  group('after failed loading', () {
    testWidgets('the name is shown as user failed to load',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      final error = Exception("Some error");

      when(mockUserRepo.getStaffById(1)).thenAnswer((_) async => throw error);
      when(mockUserRepo.getStaffById(2)).thenAnswer((_) async => throw error);

      await tester.pumpWidget(
        TestableWidget(
          child: StaffList(
            staffList: staffList,
            future: (int id) => mockUserRepo.getStaffById(id),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text("User failed to load"), findsNWidgets(2));
    });

    testWidgets('the person off icon is shown', (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      final error = Exception("Some error");

      when(mockUserRepo.getStaffById(1)).thenAnswer((_) async => throw error);
      when(mockUserRepo.getStaffById(2)).thenAnswer((_) async => throw error);

      await tester.pumpWidget(
        TestableWidget(
          child: StaffList(
            staffList: staffList,
            future: (int id) => mockUserRepo.getStaffById(id),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.person_off), findsNWidgets(2));
    });

    testWidgets('only the user who failed to load should have the error text',
        (WidgetTester tester) async {
      final mockUserRepo = TestMocks.userRepository;

      final error = Exception("Some error");

      when(mockUserRepo.getStaffById(1)).thenAnswer((_) async => mockStaffOne);
      when(mockUserRepo.getStaffById(2)).thenAnswer((_) async => throw error);

      await tester.pumpWidget(
        TestableWidget(
          child: StaffList(
            staffList: staffList,
            future: (int id) => mockUserRepo.getStaffById(id),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Test One'), findsOneWidget);
      expect(find.text("User failed to load"), findsOneWidget);
    });
  });
}
