import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/ui/global_widgets/future_state_text.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/global_widgets/page_title.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_category_title.dart';
import '../../../controllers/manager_skill_overview_controller.dart';
import 'manager_skill_overview_user_list.dart';

class ManagerSkillOverviewPage extends GetView<ManagerSkillOverviewController> {
  final id = Get.parameters["id"]!;
  final name = Get.parameters["name"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name ?? 'Skill Overview'),
        actions: [
          IconButton(
            onPressed: controller.editSkill,
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.skill != null) {
          final skill = controller.skill!.value;
          return ListView(
            physics: ClampingScrollPhysics(),
            children: [
              if (name == null) PageTitle(text: skill.name),
              if (name != null) SizedBox(height: 16),
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
