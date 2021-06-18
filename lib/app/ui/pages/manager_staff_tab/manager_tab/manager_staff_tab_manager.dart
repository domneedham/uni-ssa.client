import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_staff_tab_manager_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';

import '../manager_staff_tab_search.dart';

class ManagerStaffTabManager extends GetView<ManagerStaffTabManagerController> {
  const ManagerStaffTabManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ManagerStaffTabSearch(
          hintText: "Search for a manager",
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
          if (controller.managerList.isEmpty) {
            return Center(child: Text("No staff found"));
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: controller.managerList.length,
            itemBuilder: (context, pos) {
              final item = controller.managerList[pos];
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
