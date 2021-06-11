import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_profile_tab_controller.dart';
import 'package:ssa_app/app/controllers/manager_skill_tab_controller.dart';
import 'package:ssa_app/app/controllers/manager_controller.dart';
import 'package:ssa_app/app/controllers/manager_skill_overview_controller.dart';

class ManagerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManagerController>(() => ManagerController());

    Get.lazyPut<ManagerSkillTabController>(() => ManagerSkillTabController());
    Get.lazyPut<ManagerSkillOverviewController>(
        () => ManagerSkillOverviewController());

    Get.lazyPut<ManagerProfileTabController>(
        () => ManagerProfileTabController());
  }
}
