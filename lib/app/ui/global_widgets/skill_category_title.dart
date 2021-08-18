import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';

class SkillCategoryTitle extends StatelessWidget {
  const SkillCategoryTitle({
    Key? key,
    required this.category,
  }) : super(key: key);

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
