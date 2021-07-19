import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/staff_overview_controller.dart';

class StaffOverviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<StaffOverviewController>(StaffOverviewController());
  }
}
