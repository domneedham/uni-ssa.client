import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssa_app/app/data/models/enums/user_role.dart';
import 'package:ssa_app/app/data/models/user/user.dart';
import 'package:ssa_app/app/ui/global_widgets/user_list_tile.dart';

import '../testable_widget.dart';

final mockUser =
    User(id: 1, firstname: 'Test', surname: 'User', userRole: UserRole.MANAGER);

void main() {
  group('user list tile', () {
    testWidgets('renders a list tile', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestableWidget(child: UserListTile(user: mockUser)),
      );

      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('shows the person icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestableWidget(child: UserListTile(user: mockUser)),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('shows the users name', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestableWidget(child: UserListTile(user: mockUser)),
      );

      expect(find.text(mockUser.name), findsOneWidget);
    });
  });

  group('loading user list tile', () {
    testWidgets('renders a list tile', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestableWidget(child: LoadingUserListTile()),
      );

      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('shows the person icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestableWidget(child: LoadingUserListTile()),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('shows loading user text', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestableWidget(child: LoadingUserListTile()),
      );

      expect(find.text('Loading user...'), findsOneWidget);
    });
  });

  group('loading failed user list tile', () {
    testWidgets('renders a list tile', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestableWidget(child: LoadingFailedUserListTile()),
      );

      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('shows the person off icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestableWidget(child: LoadingFailedUserListTile()),
      );

      expect(find.byIcon(Icons.person_off), findsOneWidget);
    });

    testWidgets('shows user failed to load text', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestableWidget(child: LoadingFailedUserListTile()),
      );

      expect(find.text('User failed to load'), findsOneWidget);
    });
  });
}
