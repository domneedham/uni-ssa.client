import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_staff_tab_controller.dart';
import 'package:ssa_app/app/ui/pages/manager_staff_tab/manager_tab/manager_staff_tab_manager.dart';
import 'package:ssa_app/app/ui/pages/manager_staff_tab/staff_tab/manager_staff_tab_staff.dart';

class ManagerStaffTab extends GetWidget<ManagerStaffTabController> {
  const ManagerStaffTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _widgets = [
      ManagerStaffTabStaff(),
      ManagerStaffTabManager(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff'),
        bottom: TabBar(
          controller: controller.tabController,
          indicator: const UnderlineTabIndicator(),
          tabs: const [
            Tab(text: 'Staff'),
            Tab(text: 'Managers'),
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
