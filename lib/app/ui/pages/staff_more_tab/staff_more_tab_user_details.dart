import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/staff_more_tab_controller.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';

class StaffMoreTabUserDetails extends GetView<StaffMoreTabController> {
  const StaffMoreTabUserDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "User Details",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        ListTile(
          title: Text('Edit Your Details'),
          trailing: IconButton(
            onPressed: controller.navigateToEditDetails,
            icon: Icon(Icons.edit),
          ),
        ),
        FutureBuilder(
          future: controller.getManager(controller.user.id),
          builder: (BuildContext ctx, AsyncSnapshot<Manager> snapshot) {
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
        ),
      ],
    );
  }
}
