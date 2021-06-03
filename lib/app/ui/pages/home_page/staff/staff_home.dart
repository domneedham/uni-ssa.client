import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ssa_app/app/controllers/home_staff.controller.dart';
import 'package:ssa_app/app/ui/pages/home_page/user_debug.dart';

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
          ListView.builder(
            shrinkWrap: true,
            itemCount: controller.skills.length,
            itemBuilder: (ctx, pos) {
              final skill = controller.skills[pos];
              return ListTile(
                leading: Icon(skill.category.icon),
                title: Text(skill.name),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Wrap(
                    spacing: 1,
                    children: List.generate(
                      skill.rating.toInt(),
                      (index) => Icon(
                        Icons.star,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                trailing: Icon(Icons.chevron_right),
              );
            },
          ),
        ],
      ),
    );
  }
}
