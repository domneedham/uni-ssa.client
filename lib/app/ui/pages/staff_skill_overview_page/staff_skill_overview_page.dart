import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/staff_skill_overview_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/future_state_text.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_overview_page/staff_skill_overview_body.dart';

class StaffSkillOverviewPage extends GetView<StaffSkillOverviewController> {
  const StaffSkillOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = Get.parameters['name'];

    return Scaffold(
      appBar: AppBar(
        title: Text(name ?? 'Skill Overview'),
      ),
      body: Obx(() {
        if (controller.skill != null) {
          return const StaffSkillOverviewBody();
        }
        if (controller.isError.value) {
          return FutureStateText(text: controller.error.value);
        }
        if (controller.isLoading.value) {
          return const LoadingIndicator();
        }
        return const FutureStateText(text: 'Unknown state');
      }),
    );
  }
}
