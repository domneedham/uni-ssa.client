import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/user/user.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(user.name),
    );
  }
}

class LoadingUserListTile extends StatelessWidget {
  const LoadingUserListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text("Loading user..."),
    );
  }
}

class LoadingFailedUserListTile extends StatelessWidget {
  const LoadingFailedUserListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person_off),
      title: Text("User failed to load"),
    );
  }
}
