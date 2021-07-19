import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/models/user/user.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/utils/typedefs.dart';

class ManagerStaffTabList extends StatelessWidget {
  ManagerStaffTabList({
    Key? key,
    required this.isLoading,
    required this.searchText,
    this.managerList,
    this.staffList,
    required this.onPressed,
  }) : assert(
          managerList != null || staffList != null,
          'The manager or staff list must be populated',
        );

  final bool isLoading;
  final String searchText;
  final List<Manager>? managerList;
  final List<Staff>? staffList;
  final NullableIntVoidCallback onPressed;

  int get itemCount {
    if (staffList != null) return staffList!.length;
    if (managerList != null) return managerList!.length;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return LoadingIndicator();
    }
    if (searchText.isEmpty) {
      return Center(
        child: Text("Waiting for a search"),
      );
    }
    if (staffList != null && staffList!.isEmpty) {
      return Center(child: Text("No staff found"));
    }
    if (managerList != null && managerList!.isEmpty) {
      return Center(child: Text("No managers found"));
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (context, pos) {
        User? user;
        if (staffList != null) user = staffList![pos];
        if (managerList != null) user = managerList![pos];
        return ListTile(
          title: Text(user?.name ?? "Error"),
          trailing: Icon(Icons.chevron_right),
          onTap: () => onPressed(user?.id),
        );
      },
    );
  }
}
