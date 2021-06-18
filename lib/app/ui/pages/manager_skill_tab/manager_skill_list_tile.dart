import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_skill_tab_controller.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';

class ManagerSkillListTile extends GetView<ManagerSkillTabController> {
  const ManagerSkillListTile({
    Key? key,
    required this.skill,
  }) : super(key: key);

  final ManagerStaffSkill skill;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(skill.name),
      subtitle: Text("Staff: ${skill.staff.length}"),
      trailing: Icon(Icons.chevron_right),
    );
    // return GestureDetector(
    //   onTap: () => controller.navigateToSkillOverview(skill.id, skill.name),
    //   child: Card(
    //     child: Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Wrap(
    //         direction: Axis.vertical,
    //         spacing: 8,
    //         children: [
    //           Text(
    //             skill.name,
    //             style: Get.textTheme.headline6,
    //           ),
    //           Text("Staff: ${skill.staff.length}")
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
