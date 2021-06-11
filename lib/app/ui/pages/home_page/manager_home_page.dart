import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ssa_app/app/controllers/manager_controller.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_tab/manager_skill_tab.dart';

class ManagerHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagerController>(builder: (controller) {
      return Scaffold(
        body: IndexedStack(
          index: controller.selectedTab,
          children: [
            ManagerSkillTab(),
            Scaffold(
              appBar: AppBar(
                title: Text("Categories"),
              ),
              body: Center(
                child: Text("Categories"),
              ),
            ),
            Scaffold(
              appBar: AppBar(
                title: Text("Staff"),
              ),
              body: Center(
                child: Text("Staff"),
              ),
            ),
            Scaffold(
              appBar: AppBar(
                title: Text("Profile"),
              ),
              body: Center(
                child: Text("Profile"),
              ),
            ),
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
              icon: const Icon(Icons.category),
              label: "Categories",
            ),
            const BottomNavigationBarItem(
              icon: const Icon(Icons.people),
              label: "Staff",
            ),
            const BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      );
    });
  }
}
