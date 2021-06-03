import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ssa_app/app/controllers/home_staff_controller.dart';
import 'package:ssa_app/app/ui/pages/home_page/user_debug.dart';

import 'skill_list_tile.dart';

class StaffHomePage extends GetWidget<HomeStaffController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserDebug(user: controller.user),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Your Skills",
              style: Get.textTheme.headline4,
            ),
          ),
          controller.skills.length == 0
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("You have no registered skills"),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.skills.length,
                  itemBuilder: (ctx, pos) {
                    final skill = controller.skills[pos];
                    return SkillListTile(skill: skill);
                  },
                ),
        ],
      ),
    );
  }
}
