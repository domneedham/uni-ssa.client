import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/ui/global_widgets/future_state_text.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/pages/user_overview/staff_overview/staff_overview_skill_list_tile.dart';
import 'package:ssa_app/app/ui/utils/typedefs.dart';

class StaffOverviewSkillList extends StatelessWidget {
  const StaffOverviewSkillList({
    Key? key,
    required this.staff,
    required this.future,
    required this.subtitleFunction,
  }) : super(key: key);

  final Staff staff;
  final NullableFutureStaffSkillListCallback future;
  final WidgetCallbackStaffSkill subtitleFunction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: const EdgeInsets.all(8),
          child: Text("Skill List:"),
        ),
        FutureBuilder(
          future: future(staff.skills),
          builder:
              (BuildContext ctx, AsyncSnapshot<List<StaffSkill>> snapshot) {
            if (snapshot.hasData) {
              final skills = snapshot.data!;
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: skills.length,
                itemBuilder: (ctx, pos) {
                  final skill = skills[pos];
                  return StaffOverviewSkillListTile(
                    skill: skill,
                    subtitle: subtitleFunction(skill),
                  );
                },
              );
            }

            if (snapshot.hasError) {
              return FutureStateText(text: "Failed to load skills");
            }
            return LoadingIndicator();
          },
        ),
      ],
    );
  }
}
