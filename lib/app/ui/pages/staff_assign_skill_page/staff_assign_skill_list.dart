import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/utils/typedefs.dart';

class StaffAssignSkillList extends StatelessWidget {
  StaffAssignSkillList({
    Key? key,
    required this.isLoading,
    required this.searchText,
    required this.skillList,
    required this.onPressed,
  });

  final bool isLoading;
  final String searchText;
  final List<Skill> skillList;
  final SkillVoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return LoadingIndicator();
    }
    if (searchText.isEmpty) {
      return Center(
        child: Text("Waiting for a search"),
      );
    }
    if (skillList.isEmpty) {
      return Center(child: Text("No skills found"));
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: skillList.length,
      itemBuilder: (context, pos) {
        final skill = skillList[pos];
        return ListTile(
          title: Text(skill.name),
          subtitle: Text(skill.category.name),
          trailing: IconButton(
            onPressed: () => onPressed(skill),
            icon: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
