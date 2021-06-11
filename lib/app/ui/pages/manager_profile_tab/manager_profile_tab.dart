import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_profile_tab_controller.dart';

class ManagerProfileTab extends GetWidget<ManagerProfileTabController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Text(controller.userRepo.user.userDebugInfo),
      ),
    );
  }
}
