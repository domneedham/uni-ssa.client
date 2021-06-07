import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/home_manager_controller.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';

class ManagerSkillCard extends GetWidget<HomeManagerController> {
  const ManagerSkillCard({
    Key? key,
    required this.skill,
  }) : super(key: key);

  final ManagerStaffSkill skill;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.navigateToSkillOverview,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            direction: Axis.vertical,
            spacing: 8,
            children: [
              Text(
                skill.name,
                style: Get.textTheme.headline6,
              ),
              Text("Staff: ${skill.staff.length}")
            ],
          ),
        ),
      ),
    );
  }
}
