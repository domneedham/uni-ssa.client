import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/home_staff_controller.dart';

class StaffBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeStaffController>(() => HomeStaffController());
  }
}
