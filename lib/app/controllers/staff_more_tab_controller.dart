import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';
import 'package:ssa_app/app/routes/app_pages.dart';

class StaffMoreTabController extends GetxController {
  final userRepo = Get.find<UserRepository>();

  Staff get user => userRepo.user as Staff;

  void navigateToEditDetails() async {
    await Get.toNamed(Routes.STAFF_EDIT_DETAILS);
    update();
  }

  void logout() {
    userRepo.logout();
  }
}
