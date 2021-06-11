import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';

class StaffSkillCard extends StatelessWidget {
  const StaffSkillCard({
    Key? key,
    required this.skill,
  }) : super(key: key);

  final StaffSkill skill;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          direction: Axis.vertical,
          spacing: 8,
          children: [
            Text(
              skill.name,
              style: Get.textTheme.headline6,
            ),
            Wrap(
              children: List.generate(
                skill.rating.toInt(),
                (index) => Icon(Icons.star, size: 16),
              ),
            ),
            Text(
              skill.expires?.toString() ?? "No expiry",
            ),
          ],
        ),
      ),
    );
  }
}
