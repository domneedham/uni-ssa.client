import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_staff_tab_controller.dart';

class ManagerStaffTab extends GetView<ManagerStaffTabController> {
  const ManagerStaffTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff"),
      ),
      body: Center(
        child: Text("Staff tab"),
      ),
    );
  }
}
