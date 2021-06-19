import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/staff_skill_tab_controller.dart';
import 'package:ssa_app/app/controllers/staff_controller.dart';

class StaffBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StaffController>(() => StaffController());
    Get.lazyPut<StaffSkillTabController>(() => StaffSkillTabController());
  }
}
