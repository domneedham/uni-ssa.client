import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ssa_app/app/controllers/staff_skill_tab_controller.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/ui/global_widgets/future_state_text.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_list.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_tab/staff_skill_card.dart';

class StaffSkillTab extends GetWidget<StaffSkillTabController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Skills'),
      ),
      body: Obx(() {
        if (controller.skills != null) {
          final skills = controller.skills!;
          if (skills.isEmpty) {
            return FutureStateText(text: "You have no registered skills");
          }
          return SkillList(
            gridChildAspectRatio: 2,
            skills: skills,
            cardBuilder: (skill) => StaffSkillCard(skill: skill as StaffSkill),
          );
        }
        if (controller.isError.value) {
          return FutureStateText(text: controller.error.value.toString());
        }
        if (controller.isLoading.value) {
          return LoadingIndicator();
        }

        return FutureStateText(text: "Unknown state");
      }),
    );
  }
}
