import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/staff_more_tab_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/user_list_tile.dart';

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
        UserListTile(user: controller.user.manager),
      ],
    );
  }
}
