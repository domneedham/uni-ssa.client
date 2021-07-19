import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';

class StaffOverviewSkillListTile extends StatelessWidget {
  const StaffOverviewSkillListTile({
    Key? key,
    required this.skill,
    required this.subtitle,
  }) : super(key: key);

  final StaffSkill skill;
  final Widget subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(skill.category.icon),
      title: Text(skill.name),
      subtitle: subtitle,
    );
  }
}
