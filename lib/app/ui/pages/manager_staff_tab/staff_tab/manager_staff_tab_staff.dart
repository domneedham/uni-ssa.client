import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_staff_tab_staff_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';

import '../manager_staff_tab_search.dart';

class ManagerStaffTabStaff extends GetView<ManagerStaffTabStaffController> {
  const ManagerStaffTabStaff({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ManagerStaffTabSearch(
          hintText: "Search for a staff member",
          textController: controller.textController,
        ),
        Obx(() {
          if (controller.isLoading.value) {
            return LoadingIndicator();
          }
          return Center(child: Text("Not loading"));
        }),
      ],
    );
  }
}
