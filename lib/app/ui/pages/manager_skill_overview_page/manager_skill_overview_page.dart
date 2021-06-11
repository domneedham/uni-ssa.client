import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/global_widgets/page_title.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_category_title.dart';
import '../../../controllers/manager_skill_overview_controller.dart';
import 'manager_skill_overview_user_list.dart';

class ManagerSkillOverviewPage extends GetView<ManagerSkillOverviewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skill Overview'),
        actions: [
          IconButton(
            onPressed: controller.editSkill,
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: FutureBuilder(
        future: controller.getSkill(Get.parameters["id"]!),
        builder: (BuildContext ctx, AsyncSnapshot<ManagerStaffSkill> snapshot) {
          if (snapshot.hasData) {
            final skill = snapshot.data!;
            return ListView(
              physics: ClampingScrollPhysics(),
              children: [
                PageTitle(text: skill.name),
                SkillCategoryTitle(category: skill.category),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Staff Assigned:",
                    style: Get.textTheme.subtitle1,
                  ),
                ),
                ManagerSkillOverviewUserList(skill: skill),
              ],
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return LoadingIndicator();
        },
      ),
    );
  }
}
