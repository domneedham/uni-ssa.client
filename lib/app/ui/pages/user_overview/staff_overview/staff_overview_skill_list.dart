import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/ui/pages/user_overview/staff_overview/staff_overview_skill_list_tile.dart';
import 'package:ssa_app/app/ui/utils/typedefs.dart';

class StaffOverviewSkillList extends StatelessWidget {
  const StaffOverviewSkillList({
    Key? key,
    required this.staff,
    required this.subtitleFunction,
  }) : super(key: key);

  final Staff staff;
  final WidgetCallbackStaffSkill subtitleFunction;

  @override
  Widget build(BuildContext context) {
    final skills = staff.skills;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text('Skill List:'),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: skills.length,
          itemBuilder: (ctx, pos) {
            final skill = skills[pos];
            return StaffOverviewSkillListTile(
              skill: skill,
              subtitle: subtitleFunction(skill),
            );
          },
        ),
      ],
    );
  }
}
