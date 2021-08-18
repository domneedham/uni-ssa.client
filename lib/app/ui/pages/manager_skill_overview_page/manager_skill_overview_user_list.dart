import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_skill_overview_controller.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/ui/global_widgets/user_list_tile.dart';

class ManagerSkillOverviewUserList
    extends GetWidget<ManagerSkillOverviewController> {
  const ManagerSkillOverviewUserList({
    Key? key,
    required this.skill,
  }) : super(key: key);

  final ManagerStaffSkill skill;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: skill.staff.length,
      itemBuilder: (c, pos) {
        final staff = skill.staff[pos];
        return UserListTile(user: staff);
      },
    );
  }
}
