import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/staff_skill_overview_controller.dart';

class StaffSkillOverviewRating extends GetView<StaffSkillOverviewController> {
  const StaffSkillOverviewRating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: controller.decrementRating,
            icon: Icon(Icons.remove),
          ),
          SizedBox(width: 16),
          Wrap(
            children: List.generate(5, (index) {
              if (index < controller.rating.value.toInt()) {
                return Icon(Icons.star, size: 24);
              }
              return Icon(Icons.star_border, size: 24);
            }),
          ),
          SizedBox(width: 16),
          IconButton(
            onPressed: controller.incrementRating,
            icon: Icon(Icons.add),
          ),
        ],
      );
    });
  }
}
