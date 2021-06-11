import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ssa_app/app/controllers/staff_controller.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_tab/staff_skill_tab.dart';

class StaffHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaffController>(builder: (controller) {
      return Scaffold(
        body: IndexedStack(
          index: controller.selectedTab,
          children: [
            StaffSkillTab(),
            Center(
              child: Text("Profile"),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedTab,
          onTap: controller.setSelectedTab,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: "Skills",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      );
    });
  }
}
