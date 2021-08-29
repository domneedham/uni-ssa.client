import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_category_list.dart';

import './skill_category_title.dart';
import 'skill_category_grid.dart';

/// Shows the list of skills, in either a grid or list dependant on the
/// [viewType] parameter.
class SkillList extends StatelessWidget {
  const SkillList({
    Key? key,
    required this.skills,
    required this.cardBuilder,
    required this.viewType,
    this.gridChildAspectRatio,
    this.padding = 16,
  }) : super(key: key);

  /// The skill list, broken down into a category and skill list.
  final Map<Category, List<Skill>> skills;

  /// The builder function that returns how the grid entry should look.
  final Widget Function(Skill skill) cardBuilder;

  /// Whether the list should render the list or grid view layout
  final SkillListViewType viewType;

  /// The aspect ratio for the grid. Not required for the list or grid, though
  /// will have a default when using the grid. See [SkillCategoryGrid].
  final double? gridChildAspectRatio;

  /// The padding for the top of the list only.
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: padding),
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        itemCount: skills.length,
        itemBuilder: (c, p) {
          final entry = skills.entries.elementAt(p);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkillCategoryTitle(category: entry.key),
              if (viewType == SkillListViewType.LIST)
                SkillCategoryList(
                  entry: entry,
                  cardBuilder: cardBuilder,
                )
              else
                SkillCategoryGrid(
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
