import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/user.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';
import 'package:ssa_app/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final UserRepository repo = Get.find<UserRepository>();

  User get user => repo.user;

  final RxDouble size = 96.0.obs;

  @override
  void onReady() {
    super.onReady();

    size.value = 192;

    // simulate loading the user
    Future.delayed(Duration(seconds: 2), () {
      if (user.isManager) {
        Get.offAllNamed(Routes.MANAGER_HOME);
      } else if (user.isStaff) {
        Get.offAllNamed(Routes.STAFF_HOME);
      }
    });
  }
}
