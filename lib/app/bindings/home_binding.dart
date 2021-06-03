import 'package:get/get.dart';
import '../controllers/home_staff_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HomeStaffController>(() => HomeStaffController());
  }
}
