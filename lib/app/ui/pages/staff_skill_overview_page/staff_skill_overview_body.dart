import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/staff_skill_overview_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/page_title.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_category_title.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_overview_page/staff_skill_overview_expiry.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_overview_page/staff_skill_overview_rating.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_overview_page/staff_skill_overview_save_button.dart';

class StaffSkillOverviewBody extends GetView<StaffSkillOverviewController> {
  const StaffSkillOverviewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = Get.parameters['name'];
    final skill = controller.skill!.value;

    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        if (name == null) PageTitle(text: skill.name),
        if (name != null) const SizedBox(height: 16),
        SkillCategoryTitle(category: skill.category),
        const SizedBox(height: 24),
        const StaffSkillOverviewRating(),
        const SizedBox(height: 24),
        const StaffSkillOverviewExpiry(),
        const SizedBox(height: 16),
        const StaffSkillOverviewSaveButton(),
      ],
    );
  }
}
