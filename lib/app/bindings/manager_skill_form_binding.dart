import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_skill_form_controller.dart';

class ManagerSkillFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManagerSkillFormController>(() => ManagerSkillFormController());
  }
}
