import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/services/user_service.dart';
import 'package:ssa_app/app/routes/app_pages.dart';

class StaffMoreTabController extends GetxController {
  final userService = Get.find<UserService>();

  Staff get user => userService.user as Staff;

  void navigateToEditDetails() async {
    await Get.toNamed(Routes.STAFF_EDIT_DETAILS);
    update();
  }

  void logout() {
    userService.logout();
  }
}
