import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ssa_app/app/controllers/manager_category_tab_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/future_state_text.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';

import 'manager_category_list.dart';

class ManagerCategoryTab extends GetWidget<ManagerCategoryTabController> {
  const ManagerCategoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        actions: [
          IconButton(onPressed: null, icon: Icon(Icons.add)),
        ],
      ),
      body: Obx(() {
        if (controller.categories != null) {
          final skills = controller.categories!;
          if (skills.isEmpty) {
            return FutureStateText(text: "No skills loaded.");
          }
          return ManagerCategoryList();
        }
        if (controller.isError.value) {
          return FutureStateText(text: controller.error.value);
        }
        if (controller.isLoading.value) {
          return LoadingIndicator();
        }
        return FutureStateText(text: "Unknown state");
      }),
    );
  }
}
