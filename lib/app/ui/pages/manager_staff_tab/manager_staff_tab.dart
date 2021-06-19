import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_staff_tab_controller.dart';
import 'package:ssa_app/app/ui/pages/manager_staff_tab/manager_tab/manager_staff_tab_manager.dart';
import 'package:ssa_app/app/ui/pages/manager_staff_tab/staff_tab/manager_staff_tab_staff.dart';

class ManagerStaffTab extends GetWidget<ManagerStaffTabController> {
  ManagerStaffTab({Key? key}) : super(key: key);

  final _widgets = [
    ManagerStaffTabStaff(),
    ManagerStaffTabManager(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff"),
        bottom: TabBar(
          controller: controller.tabController,
          indicator: UnderlineTabIndicator(),
          tabs: [
            Tab(text: "Staff"),
            Tab(text: "Managers"),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: _widgets,
      ),
    );
  }
}
