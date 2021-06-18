import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_staff_tab_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';

import '../manager_staff_tab_search.dart';

class ManagerStaffTabStaff extends GetView<ManagerStaffTabController> {
  const ManagerStaffTabStaff({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ManagerStaffTabSearch(
          hintText: "Search for a staff member",
          textController: controller.textController,
        ),
        Obx(() {
          if (controller.isLoading.value) {
            return LoadingIndicator();
          }
          if (controller.searchText.isEmpty) {
            return Center(
              child: Text("Waiting for a search"),
            );
          }
          if (controller.staffList.isEmpty) {
            return Center(child: Text("No staff found"));
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: controller.staffList.length,
            itemBuilder: (context, pos) {
              final item = controller.staffList[pos];
              return ListTile(
                title: Text(item.name),
                trailing: Icon(Icons.chevron_right),
              );
            },
          );
        }),
      ],
    );
  }
}
