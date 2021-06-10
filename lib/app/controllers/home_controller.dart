import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/enums/user_role.dart';
import 'package:ssa_app/app/data/models/user/user.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';
import 'package:ssa_app/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final UserRepository repo = Get.find<UserRepository>();

  User get user => repo.user;

  @override
  void onReady() {
    super.onReady();
    // simulate loading the user
    Future.delayed(Duration(seconds: 2), () {
      if (user.userRole == UserRole.MANAGER) {
        Get.offAllNamed(Routes.MANAGER_HOME);
      } else {
        Get.offAllNamed(Routes.STAFF_HOME);
      }
    });
  }
}
