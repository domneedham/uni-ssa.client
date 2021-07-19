import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_overview_controller.dart';

class ManagerOverviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ManagerOverviewController>(ManagerOverviewController());
  }
}
