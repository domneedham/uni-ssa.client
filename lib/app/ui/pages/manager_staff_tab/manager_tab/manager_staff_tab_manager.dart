import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_staff_tab_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/future_state_text.dart';
import 'package:ssa_app/app/ui/pages/manager_staff_tab/manager_staff_tab_list.dart';

import '../manager_staff_tab_search.dart';

class ManagerStaffTabManager extends GetView<ManagerStaffTabController> {
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
          if (controller.isError.isTrue) {
            return FutureStateText(text: controller.error.string);
          }
          return ManagerStaffTabList(
            isLoading: controller.isLoading.value,
            searchText: controller.searchText.value,
            managerList: controller.managerList,
            onPressed: (int? id) => controller.navigateToUserOverview(id),
          );
        }),
      ],
    );
  }
}
