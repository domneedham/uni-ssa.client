import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/user/user.dart';

/// Shows a [ListTile] with the users details and a person icon.
class UserListTile extends StatelessWidget {
  const UserListTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  /// The user whose details are used.
  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: Text(user.name),
    );
  }
}

/// Shows a [ListTile] to indicate user information is loading and a person icon.
class LoadingUserListTile extends StatelessWidget {
  const LoadingUserListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: Icon(Icons.person),
      title: Text('Loading user...'),
    );
  }
}

/// Shows a [ListTile] to indicate the user details failed to load. Shows a
/// person off icon instead of the standard person icon.
class LoadingFailedUserListTile extends StatelessWidget {
  const LoadingFailedUserListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: Icon(Icons.person_off),
      title: Text('User failed to load'),
    );
  }
}
