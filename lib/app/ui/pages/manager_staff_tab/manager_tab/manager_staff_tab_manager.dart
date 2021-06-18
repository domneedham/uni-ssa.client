import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_staff_tab_manager_controller.dart';

class ManagerStaffTabManager extends GetView<ManagerStaffTabManagerController> {
  const ManagerStaffTabManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [Text("Manager tab")],
    );
  }
}
