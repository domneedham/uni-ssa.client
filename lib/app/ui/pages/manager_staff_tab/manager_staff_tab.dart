import 'package:flutter/material.dart';
import 'package:ssa_app/app/ui/pages/manager_staff_tab/manager_tab/manager_staff_tab_manager.dart';
import 'package:ssa_app/app/ui/pages/manager_staff_tab/staff_tab/manager_staff_tab_staff.dart';

class ManagerStaffTab extends StatelessWidget {
  ManagerStaffTab({Key? key}) : super(key: key);

  final _widgets = [
    ManagerStaffTabStaff(),
    ManagerStaffTabManager(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Staff"),
          bottom: TabBar(
            indicator: UnderlineTabIndicator(),
            tabs: [
              Tab(text: "Staff"),
              Tab(text: "Managers"),
            ],
          ),
        ),
        body: TabBarView(
          children: _widgets,
        ),
      ),
    );
  }
}
