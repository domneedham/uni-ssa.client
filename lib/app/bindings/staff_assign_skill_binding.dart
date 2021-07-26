import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/staff_assign_skill_controller.dart';

class StaffAssignSkillBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StaffAssignSkillController>(() => StaffAssignSkillController());
  }
}
