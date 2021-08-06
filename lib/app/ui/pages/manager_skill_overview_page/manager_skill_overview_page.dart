import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/ui/global_widgets/future_state_text.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_category_title.dart';
import '../../../controllers/manager_skill_overview_controller.dart';
import 'manager_skill_overview_user_list.dart';

class ManagerSkillOverviewPage extends GetView<ManagerSkillOverviewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.skillName)),
        actions: [
          IconButton(
            onPressed: controller.editSkill,
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              Get.dialog(AlertDialog(
                title: Text("Are you sure you want to delete?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      // pop the dialog
                      Get.back();
                    },
                    child: Text("No"),
                  ),
                  TextButton(
                    onPressed: () {
                      // pop the dialog
                      Get.back();
                      controller.deleteSkill();
                    },
                    child: Text("Yes"),
                  ),
                ],
              ));
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.skill != null) {
          final skill = controller.skill!.value;
          return ListView(
            physics: ClampingScrollPhysics(),
            children: [
              SizedBox(height: 16),
              SkillCategoryTitle(category: skill.category),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Staff Assigned:",
                  style: Get.textTheme.subtitle1,
                ),
              ),
              ManagerSkillOverviewUserList(skill: skill),
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
