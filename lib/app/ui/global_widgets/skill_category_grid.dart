import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';

/// Shows the [cardBuilder] widget in grid form.
class SkillCategoryGrid extends StatelessWidget {
  const SkillCategoryGrid({
    Key? key,
    this.childAspectRatio = 2.5,
    required this.entry,
    required this.cardBuilder,
  }) : super(key: key);

  /// The aspect ratio for the grid. Defaults to 2.5.
  final double? childAspectRatio;

  /// The skill list, broken down into a category and skill list.
  final MapEntry<Category, List<Skill>> entry;

  /// The builder function that returns how the grid entry should look.
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
