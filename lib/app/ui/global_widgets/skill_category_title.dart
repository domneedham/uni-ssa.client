import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';

/// Shows a title to be used when displaying a category above a skill.
class SkillCategoryTitle extends StatelessWidget {
  const SkillCategoryTitle({
    Key? key,
    required this.category,
  }) : super(key: key);

  /// The category data for use in this widget.
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Icon(category.icon),
          const SizedBox(width: 8),
          Text(
            category.name,
            style: Get.textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
