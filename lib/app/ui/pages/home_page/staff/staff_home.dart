import 'package:flutter/material.dart';
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
        children: [
          UserDebug(user: controller.user),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.skills.length,
                itemBuilder: (ctx, pos) {
                  return ListTile(title: Text(controller.skills[pos]));
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
