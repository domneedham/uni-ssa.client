import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/user/user.dart';
import 'package:ssa_app/app/ui/global_widgets/user_list_tile.dart';

/// Shows a list of the users.
class StaffList extends StatelessWidget {
  const StaffList({
    Key? key,
    required this.staffList,
  }) : super(key: key);

  /// The list of the users to show in this list.
  final List<User> staffList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: staffList.length,
      itemBuilder: (context, pos) {
        final staff = staffList[pos];
        return UserListTile(user: staff);
      },
    );
  }
}
