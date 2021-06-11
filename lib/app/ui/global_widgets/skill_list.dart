import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';

import './skill_category_title.dart';
import 'skill_grid.dart';

class SkillList extends StatelessWidget {
  const SkillList({
    Key? key,
    required this.skills,
    required this.cardBuilder,
    this.gridChildAspectRatio,
    this.padding = 16,
  }) : super(key: key);

  final Map<Category, List<Skill>> skills;
  final Widget Function(Skill skill) cardBuilder;
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
              SkillGrid(
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
