import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_skill_overview_controller.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';

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
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: skill.staff.length,
      itemBuilder: (c, pos) {
        final staffId = skill.staff[pos];
        return FutureBuilder(
          future: controller.getStaffById(staffId),
          builder: (BuildContext ctx, AsyncSnapshot<Staff> snapshot) {
            if (snapshot.hasData) {
              final user = snapshot.data!;
              return ListTile(
                leading: Icon(Icons.person),
                title: Text(user.name),
              );
            }
            if (snapshot.hasError) {
              return ListTile(
                leading: Icon(Icons.person_off),
                title: Text("User failed to load"),
              );
            }
            return ListTile(
              leading: Icon(Icons.person),
              title: Text("Loading user..."),
            );
          },
        );
      },
    );
  }
}
