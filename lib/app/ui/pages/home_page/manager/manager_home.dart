import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ssa_app/app/controllers/home_manager_controller.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/ui/pages/home_page/home_page_future_state_text.dart';
import 'package:ssa_app/app/ui/pages/home_page/home_page_header.dart';
import 'package:ssa_app/app/ui/pages/home_page/user_debug.dart';

import '../home_page_skill_list.dart';
import 'manager_skill_card.dart';

class ManagerHomePage extends GetWidget<HomeManagerController> {
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
          HomePageHeader(text: "Skills"),
          FutureBuilder(
            future: controller.skills,
            builder: (BuildContext ctx,
                AsyncSnapshot<Map<Category, List<ManagerStaffSkill>>?>
                    snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return HomePageFutureStateText(text: "Fetching data");
              }
              if (snapshot.hasData) {
                final skills = snapshot.data!;
                if (skills.isEmpty) {
                  return HomePageFutureStateText(text: "No skills loaded");
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
