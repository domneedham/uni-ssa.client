import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/ui/utils/typedefs.dart';

class StaffList extends StatelessWidget {
  const StaffList({
    Key? key,
    required this.staffList,
    required this.future,
  }) : super(key: key);

  final List<int> staffList;
  final NullableFutureStaffCallback future;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: staffList.length,
      itemBuilder: (context, pos) {
        final staffId = staffList[pos];
        return FutureBuilder(
          future: future(staffId),
          builder: (BuildContext ctx, AsyncSnapshot<Staff> snapshot) {
            if (snapshot.hasData) {
              final user = snapshot.data!;
              return ListTile(
                leading: Icon(Icons.person),
                title: Text(user.name),
              );
            }
            if (snapshot.hasError) {
              return ListTile(
                leading: Icon(Icons.person_off),
                title: Text("User failed to load"),
              );
            }
            return ListTile(
              leading: Icon(Icons.person),
              title: Text("Loading user..."),
            );
          },
        );
      },
    );
  }
}
