import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/user.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';
import 'package:ssa_app/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final UserRepository repo = Get.find<UserRepository>();

  User? get user => repo.user;
  RxBool get loggedIn => repo.loggedIn;

  final RxDouble size = 96.0.obs;

  @override
  void onReady() async {
    super.onReady();

    size.value = 192;

    navigate(user);

    ever(loggedIn, (bool value) {
      navigate(user);
    });
  }

  void navigate(User? user) {
    if (user == null) {
      Get.toNamed(Routes.LOGIN);
    } else if (user.isManager) {
      Get.toNamed(Routes.MANAGER_HOME);
    } else if (user.isStaff) {
      Get.toNamed(Routes.STAFF_HOME);
    }
  }
}
