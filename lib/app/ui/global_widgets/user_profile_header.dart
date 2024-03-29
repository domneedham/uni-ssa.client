import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/user/user.dart';

/// Shows the user intials in a circular background, with their name underneath.
///
/// Made to resemble a profile picture, though these are not yet used in the app.
class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({
    Key? key,
    required this.user,
  }) : super(key: key);

  /// The users details.
  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: CircleAvatar(
            child: Text(
              '${user.firstname[0]}${user.surname[0]}',
              style: const TextStyle(fontSize: 36),
            ),
            radius: 48,
          ),
        ),
        Text(
          user.name,
          style: const TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}
