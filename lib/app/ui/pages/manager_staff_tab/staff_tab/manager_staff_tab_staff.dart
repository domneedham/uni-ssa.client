import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_staff_tab_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/future_state_text.dart';

import '../manager_staff_tab_list.dart';
import '../manager_staff_tab_search.dart';

class ManagerStaffTabStaff extends GetView<ManagerStaffTabController> {
  const ManagerStaffTabStaff({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ManagerStaffTabSearch(
          hintText: 'Search for a staff member',
          textController: controller.textController,
        ),
        Obx(() {
          if (controller.isError.isTrue) {
            return FutureStateText(text: controller.error.string);
          }
          return ManagerStaffTabList(
            isLoading: controller.isLoading.value,
            searchText: controller.searchText.value,
            staffList: controller.staffList,
            onPressed: (int? id) => controller.navigateToUserOverview(id),
          );
        }),
      ],
    );
  }
}
