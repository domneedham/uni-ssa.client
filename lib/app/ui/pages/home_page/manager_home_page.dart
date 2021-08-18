import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ssa_app/app/controllers/manager_controller.dart';
import 'package:ssa_app/app/ui/pages/manager_category_tab/manager_category_tab.dart';
import 'package:ssa_app/app/ui/pages/manager_more_tab/manager_more_tab.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_tab/manager_skill_tab.dart';
import 'package:ssa_app/app/ui/pages/manager_staff_tab/manager_staff_tab.dart';

class ManagerHomePage extends StatelessWidget {
  const ManagerHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _widgets = [
      ManagerSkillTab(),
      ManagerCategoryTab(),
      ManagerStaffTab(),
      ManagerMoreTab(),
    ];

    return GetBuilder<ManagerController>(
      builder: (controller) {
        return Scaffold(
          body: _widgets[controller.selectedTab],
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
                icon: Icon(Icons.category),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Staff',
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
