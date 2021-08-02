import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_overview_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/future_state_text.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/global_widgets/staff_list.dart';
import 'package:ssa_app/app/ui/global_widgets/user_profile_header.dart';

class ManagerOverviewPage extends GetWidget<ManagerOverviewController> {
  const ManagerOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manager Overview"),
      ),
      body: Obx(() {
        if (controller.manager != null) {
          final manager = controller.manager!.value;
          return ListView(
            children: [
              UserProfileHeader(user: manager),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text("Staff list:"),
              ),
              StaffList(
                staffList: manager.staff,
              )
            ],
          );
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
