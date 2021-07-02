import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_category_form_controller.dart';

class ManagerCategoryFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManagerCategoryFormController>(
        () => ManagerCategoryFormController());
  }
}
