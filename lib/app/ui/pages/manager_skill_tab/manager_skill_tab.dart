import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ssa_app/app/controllers/home_manager_controller.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/ui/global_widgets/page_title.dart';
import 'package:ssa_app/app/ui/pages/home_page/home_page_future_state_text.dart';
import 'package:ssa_app/app/ui/pages/home_page/home_page_skill_list.dart';
import 'package:ssa_app/app/ui/pages/home_page/manager/manager_skill_card.dart';
import 'package:ssa_app/app/ui/pages/home_page/user_debug.dart';

class ManagerSkillTab extends GetWidget<HomeManagerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Skills")),
      body: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          UserDebug(user: controller.user),
          PageTitle(text: "Skills"),
          FutureBuilder(
            future: controller.skills,
            builder: (BuildContext ctx,
                AsyncSnapshot<Map<Category, List<ManagerStaffSkill>>?>
                    snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return HomePageFutureStateText(text: "Loading");
              }
              if (snapshot.hasData) {
                final skills = snapshot.data!;
                if (skills.isEmpty) {
                  return HomePageFutureStateText(text: "No skills loaded.");
                }
                return HomePageSkillList(
                  gridChildAspectRatio: 2.5,
                  skills: skills,
                  cardBuilder: (skill) =>
                      ManagerSkillCard(skill: skill as ManagerStaffSkill),
                );
              }
              if (snapshot.hasError) {
                return HomePageFutureStateText(
                    text: "Oh no, that didn't work.");
              }
              return HomePageFutureStateText(
                  text: "Looks like that didn't work.");
            },
          ),
        ],
      ),
    );
  }
}
