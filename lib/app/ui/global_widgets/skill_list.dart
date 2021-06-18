import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_category_list.dart';

import './skill_category_title.dart';
import 'skill_category_grid.dart';

class SkillList extends StatelessWidget {
  const SkillList({
    Key? key,
    required this.skills,
    required this.cardBuilder,
    required this.viewType,
    this.gridChildAspectRatio,
    this.padding = 16,
  }) : super(key: key);

  final Map<Category, List<Skill>> skills;
  final Widget Function(Skill skill) cardBuilder;
  final SkillListViewType viewType;
  final double? gridChildAspectRatio;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: padding),
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        itemCount: skills.length,
        itemBuilder: (c, p) {
          final entry = skills.entries.elementAt(p);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkillCategoryTitle(category: entry.key),
              viewType == SkillListViewType.LIST
                  ? SkillCategoryList(
                      entry: entry,
                      cardBuilder: cardBuilder,
                    )
                  : SkillCategoryGrid(
                      childAspectRatio: gridChildAspectRatio,
                      entry: entry,
                      cardBuilder: cardBuilder,
                    ),
              SizedBox(
                height: padding,
              ),
            ],
          );
        },
      ),
    );
  }
}

enum SkillListViewType {
  LIST,
  GRID,
}
