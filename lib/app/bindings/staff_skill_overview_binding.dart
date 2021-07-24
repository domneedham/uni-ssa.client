import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/staff_skill_overview_controller.dart';

class StaffSkillOverviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StaffSkillOverviewController>(
        () => StaffSkillOverviewController());
  }
}
