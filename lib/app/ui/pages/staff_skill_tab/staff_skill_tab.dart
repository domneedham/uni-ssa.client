import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ssa_app/app/controllers/staff_skill_tab_controller.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/ui/global_widgets/future_state_text.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/global_widgets/page_title.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_list.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_tab/staff_skill_card.dart';
import 'package:ssa_app/app/ui/pages/home_page/user_debug.dart';

class StaffSkillTab extends GetWidget<StaffSkillTabController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skills'),
      ),
      body: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          UserDebug(user: controller.user),
          PageTitle(text: "Your Skills"),
          FutureBuilder(
            future: controller.skills,
            builder: (BuildContext ctx,
                AsyncSnapshot<Map<Category, List<StaffSkill>>?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingIndicator();
              }
              if (snapshot.hasData) {
                final skills = snapshot.data!;
                if (skills.isEmpty) {
                  return FutureStateText(text: "You have no registered skills");
                }
                return SkillList(
                  gridChildAspectRatio: 2,
                  skills: skills,
                  cardBuilder: (skill) =>
                      StaffSkillCard(skill: skill as StaffSkill),
                );
              }
              if (snapshot.hasError) {
                return FutureStateText(text: "Oh no, that didn't work.");
              }
              return FutureStateText(text: "You have no registered skills");
            },
          ),
        ],
      ),
    );
  }
}
