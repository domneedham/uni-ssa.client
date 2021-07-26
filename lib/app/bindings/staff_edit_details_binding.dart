import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/staff_edit_details_controller.dart';

class StaffEditDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StaffEditDetailsController>(() => StaffEditDetailsController());
  }
}
