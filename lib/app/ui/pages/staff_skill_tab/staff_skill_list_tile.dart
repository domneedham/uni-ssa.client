import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';

class StaffSkillListTile extends StatelessWidget {
  const StaffSkillListTile({
    Key? key,
    required this.skill,
  }) : super(key: key);

  final StaffSkill skill;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(skill.category.icon),
      title: Text(skill.name),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Wrap(
          spacing: 1,
          children: List.generate(
            skill.rating.toInt(),
            (index) => const Icon(
              Icons.star,
              size: 18,
            ),
          ),
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
