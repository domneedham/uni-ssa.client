import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ssa_app/app/controllers/home_staff.controller.dart';

class StaffHomePage extends GetWidget<HomeStaffController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(controller.user.toString()),
          ),
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
