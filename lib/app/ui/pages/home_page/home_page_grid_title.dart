import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';

class HomePageGridTitle extends StatelessWidget {
  const HomePageGridTitle({
    Key? key,
    required this.entry,
  }) : super(key: key);

  final MapEntry<Category, List<Skill>> entry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(entry.key.icon),
          SizedBox(width: 8),
          Text(
            entry.key.name,
            style: Get.textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
