import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/staff_skill_overview_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/page_title.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_category_title.dart';

class StaffSkillOverviewBody extends GetView<StaffSkillOverviewController> {
  const StaffSkillOverviewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = Get.parameters["name"];
    final skill = controller.skill!.value;

    return Obx(() {
      return ListView(
        physics: ClampingScrollPhysics(),
        children: [
          if (name == null) PageTitle(text: skill.name),
          if (name != null) SizedBox(height: 16),
          SkillCategoryTitle(category: skill.category),
          SizedBox(height: 24),
          Row(
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
          ),
          SizedBox(height: 24),
          ListTile(
            title: Text(
              controller.formatDate(controller.expires.value),
              style: TextStyle(fontSize: 18),
            ),
            trailing: IconButton(
              onPressed: () async => controller.datePicker(),
              icon: Icon(Icons.calendar_today),
            ),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed:
                controller.isEdited.value ? controller.saveEditedSkill : null,
            child: Text("Save"),
          )
        ],
      );
    });
  }
}
