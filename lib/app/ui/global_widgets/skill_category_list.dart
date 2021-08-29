import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';

/// Shows the [cardBuilder] widget in list form.
class SkillCategoryList extends StatelessWidget {
  const SkillCategoryList({
    Key? key,
    required this.entry,
    required this.cardBuilder,
  }) : super(key: key);

  /// The skill list, broken down into a category and skill list.
  final MapEntry<Category, List<Skill>> entry;

  /// The builder function that returns how the grid entry should look.
  final Widget Function(Skill) cardBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: entry.value.length,
      itemBuilder: (ctx, pos) {
        final skill = entry.value[pos];
        return cardBuilder(skill);
      },
    );
  }
}
