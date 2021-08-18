import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ssa_app/app/controllers/staff_controller.dart';
import 'package:ssa_app/app/ui/pages/staff_more_tab/staff_more_tab.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_tab/staff_skill_tab.dart';

class StaffHomePage extends StatelessWidget {
  const StaffHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaffController>(
      builder: (controller) {
        return Scaffold(
          body: IndexedStack(
            index: controller.selectedTab,
            children: const [
              StaffSkillTab(),
              StaffMoreTab(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.selectedTab,
            onTap: controller.setSelectedTab,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Skills',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz),
                label: 'More',
              ),
            ],
          ),
        );
      },
    );
  }
}
