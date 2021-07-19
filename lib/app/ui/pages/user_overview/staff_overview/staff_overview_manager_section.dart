import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/ui/global_widgets/user_list_tile.dart';
import 'package:ssa_app/app/ui/utils/typedefs.dart';

class StaffOverviewManagerSection extends StatelessWidget {
  const StaffOverviewManagerSection({
    Key? key,
    required this.staff,
    required this.future,
  }) : super(key: key);

  final Staff staff;
  final NullableFutureManagerCallback future;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: const EdgeInsets.all(8),
          child: Text("Reports To:"),
        ),
        FutureBuilder(
          future: future(staff.id),
          builder: (BuildContext ctx, AsyncSnapshot<Manager> snapshot) {
            if (snapshot.hasData) {
              final user = snapshot.data!;
              return UserListTile(user: user);
            }
            if (snapshot.hasError) {
              return const LoadingFailedUserListTile();
            }
            return const LoadingUserListTile();
          },
        ),
      ],
    );
  }
}
