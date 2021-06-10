import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_category_title.dart';

import 'home_page_grid.dart';

class HomePageSkillList extends StatelessWidget {
  const HomePageSkillList({
    Key? key,
    required this.skills,
    required this.cardBuilder,
    this.gridChildAspectRatio,
  }) : super(key: key);

  final Map<Category, List<Skill>> skills;
  final Widget Function(Skill skill) cardBuilder;
  final double? gridChildAspectRatio;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: skills.length,
      itemBuilder: (c, p) {
        final entry = skills.entries.elementAt(p);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkillCategoryTitle(category: entry.key),
            HomePageGrid(
              childAspectRatio: gridChildAspectRatio,
              entry: entry,
              cardBuilder: cardBuilder,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }
}
