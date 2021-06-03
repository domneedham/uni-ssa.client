import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ssa_app/app/controllers/home_controller.dart';
import 'package:ssa_app/app/ui/pages/home_page/user_debug.dart';

class ManagerHomePage extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          UserDebug(user: controller.user),
        ],
      ),
    );
  }
}
