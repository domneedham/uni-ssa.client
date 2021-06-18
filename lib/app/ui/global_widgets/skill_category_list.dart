import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';

class SkillCategoryList extends StatelessWidget {
  SkillCategoryList({
    Key? key,
    required this.entry,
    required this.cardBuilder,
  }) : super(key: key);

  final MapEntry<Category, List<Skill>> entry;
  final Widget Function(Skill) cardBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: entry.value.length,
      itemBuilder: (ctx, pos) {
        final skill = entry.value[pos];
        return cardBuilder(skill);
      },
    );
  }
}
