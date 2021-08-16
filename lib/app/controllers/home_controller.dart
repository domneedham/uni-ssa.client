import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/user.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';
import 'package:ssa_app/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final UserRepository repo = Get.find<UserRepository>();

  RxBool get loggedIn => repo.loggedIn;

  User? get user => repo.user;

  final RxDouble size = 96.0.obs;

  @override
  void onInit() {
    ever(repo.loggedIn, (value) {
      navigate(user);
    });

    super.onInit();
  }

  @override
  void onReady() async {
    size.value = 192;

    if (repo.firstLaunch.isFalse) {
      Future.delayed(Duration(seconds: 1, milliseconds: 500), () {
        navigate(repo.user);
      });
    }

    super.onReady();
  }

  void navigate(User? user) {
    if (user == null) {
      Get.offAndToNamed(Routes.LOGIN);
    } else if (user.isManager) {
      Get.offAllNamed(Routes.MANAGER_HOME);
    } else if (user.isStaff) {
      Get.offAllNamed(Routes.STAFF_HOME);
    }
  }
}
