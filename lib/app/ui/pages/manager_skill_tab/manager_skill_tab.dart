import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ssa_app/app/controllers/manager_skill_tab_controller.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/ui/global_widgets/future_state_text.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_list.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_tab/manager_skill_card.dart';

class ManagerSkillTab extends GetWidget<ManagerSkillTabController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Skills"),
        actions: [
          IconButton(
            onPressed: controller.createNewSkill,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.skills != null) {
          final skills = controller.skills!;
          if (skills.isEmpty) {
            return FutureStateText(text: "No skills loaded.");
          }
          return SkillList(
            gridChildAspectRatio: 2.5,
            skills: skills,
            cardBuilder: (skill) =>
                ManagerSkillCard(skill: skill as ManagerStaffSkill),
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
