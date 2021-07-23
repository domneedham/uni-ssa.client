import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ssa_app/app/controllers/staff_controller.dart';
import 'package:ssa_app/app/ui/pages/staff_more_tab/staff_more_tab.dart';
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
            StaffMoreTab(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.selectedTab,
          onTap: controller.setSelectedTab,
          items: [
            const BottomNavigationBarItem(
              icon: const Icon(Icons.star),
              label: "Skills",
            ),
            const BottomNavigationBarItem(
              icon: const Icon(Icons.more_horiz),
              label: "More",
            ),
          ],
        ),
      );
    });
  }
}
