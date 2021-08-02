import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/staff_assign_skill_controller.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';
import 'package:ssa_app/app/ui/pages/staff_assign_skill_page/staff_assign_skill_list.dart';

import 'staff_assign_skill_search.dart';

class StaffAssignSkillPage extends GetView<StaffAssignSkillController> {
  const StaffAssignSkillPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assign Skill"),
      ),
      body: Column(
        children: [
          StaffAssignSkillSearch(
            hintText: "Search for a skill",
            textController: controller.textController,
          ),
          Obx(() {
            return StaffAssignSkillList(
              isLoading: controller.isLoading.value,
              searchText: controller.searchText.value,
              skillList: controller.skillList,
              onPressed: (Skill skill) => controller.assignSkill(skill),
            );
          }),
        ],
      ),
    );
  }
}
