import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/staff_assign_skill_controller.dart';

class StaffAssignSkillPage extends GetView<StaffAssignSkillController> {
  const StaffAssignSkillPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assign Skill"),
      ),
      body: Text("Assign Skill"),
    );
  }
}
