import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';

class SkillCategoryGrid extends StatelessWidget {
  SkillCategoryGrid({
    Key? key,
    this.childAspectRatio = 2.5,
    required this.entry,
    required this.cardBuilder,
  }) : super(key: key);

  final double? childAspectRatio;
  final MapEntry<Category, List<Skill>> entry;
  final Widget Function(Skill) cardBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: childAspectRatio ?? 2.5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
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
