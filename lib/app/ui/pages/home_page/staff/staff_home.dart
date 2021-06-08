import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ssa_app/app/controllers/home_staff_controller.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/ui/global_widgets/page_title.dart';
import 'package:ssa_app/app/ui/pages/home_page/home_page_future_state_text.dart';
import 'package:ssa_app/app/ui/pages/home_page/staff/staff_skill_card.dart';
import 'package:ssa_app/app/ui/pages/home_page/user_debug.dart';

import '../home_page_skill_list.dart';

class StaffHomePage extends GetWidget<HomeStaffController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
                return HomePageFutureStateText(text: "Loading");
              }
              if (snapshot.hasData) {
                final skills = snapshot.data!;
                if (skills.isEmpty) {
                  return HomePageFutureStateText(
                      text: "You have no registered skills");
                }
                return HomePageSkillList(
                  gridChildAspectRatio: 2,
                  skills: skills,
                  cardBuilder: (skill) =>
                      StaffSkillCard(skill: skill as StaffSkill),
                );
              }
              if (snapshot.hasError) {
                return HomePageFutureStateText(
                    text: "Oh no, that didn't work.");
              }
              return HomePageFutureStateText(
                  text: "You have no registered skills");
            },
          ),
        ],
      ),
    );
  }
}
