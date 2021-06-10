import 'package:get/get.dart';
import '../controllers/manager_skill_overview_controller.dart';

class ManagerSkillOverviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManagerSkillOverviewController>(
        () => ManagerSkillOverviewController());
  }
}
