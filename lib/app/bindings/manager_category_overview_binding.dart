import 'package:get/get.dart';
import '../controllers/manager_category_overview_controller.dart';

class ManagerCategoryOverviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManagerCategoryOverviewController>(
        () => ManagerCategoryOverviewController());
  }
}
