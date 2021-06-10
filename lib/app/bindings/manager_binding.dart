import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/home_manager_controller.dart';
import 'package:ssa_app/app/controllers/manager_skill_overview_controller.dart';

class ManagerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeManagerController>(() => HomeManagerController());
    Get.lazyPut<ManagerSkillOverviewController>(
        () => ManagerSkillOverviewController());
  }
}
