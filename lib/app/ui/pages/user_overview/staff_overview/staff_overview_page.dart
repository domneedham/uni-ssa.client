import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/staff_overview_controller.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/ui/global_widgets/future_state_text.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/global_widgets/user_profile_header.dart';
import 'package:ssa_app/app/ui/pages/user_overview/staff_overview/staff_overview_manager_section.dart';
import 'package:ssa_app/app/ui/pages/user_overview/staff_overview/staff_overview_skill_list.dart';

class StaffOverviewPage extends GetWidget<StaffOverviewController> {
  const StaffOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff Overview"),
      ),
      body: Obx(() {
        if (controller.staff != null) {
          final staff = controller.staff!.value;
          return ListView(
            children: [
              UserProfileHeader(user: staff),
              const Divider(),
              StaffOverviewManagerSection(
                staff: staff,
                future: (id) => controller.getManagerById(id),
              ),
              const Divider(),
              StaffOverviewSkillList(
                future: (List<int> ids) => controller.getSkillsByIds(ids),
                subtitleFunction: (StaffSkill skill) =>
                    controller.expiryTextWidget(skill),
                staff: staff,
              ),
            ],
          );
        }
        if (controller.isError.value) {
          return FutureStateText(text: controller.error.value);
        }
        if (controller.isLoading.value) {
          return const LoadingIndicator();
        }
        return const FutureStateText(text: "Unknown state");
      }),
    );
  }
}
