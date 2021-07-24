import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/staff_skill_overview_controller.dart';

class StaffSkillOverviewSaveButton
    extends GetView<StaffSkillOverviewController> {
  const StaffSkillOverviewSaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextButton(
        onPressed:
            controller.isEdited.value ? controller.saveEditedSkill : null,
        child: Text("Save"),
      );
    });
  }
}
