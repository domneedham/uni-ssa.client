import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/user/user.dart';

/// Shows a [User] debug information.
class UserDebug extends StatelessWidget {
  const UserDebug({Key? key, required this.user}) : super(key: key);

  /// The user to show.
  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(user.userDebugInfo),
    );
  }
}
