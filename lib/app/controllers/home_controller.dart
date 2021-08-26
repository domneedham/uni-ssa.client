import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/user.dart';
import 'package:ssa_app/app/data/services/user_service.dart';
import 'package:ssa_app/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final UserService repo = Get.find<UserService>();

  RxBool get loggedIn => repo.loggedIn;

  User? get user => repo.user;

  final RxDouble size = 96.0.obs;

  @override
  void onInit() {
    ever(repo.loggedIn, (_) {
      navigate(user);
    });

    super.onInit();
  }

  @override
  void onReady() async {
    size.value = 192;

    if (repo.firstLaunch.isFalse) {
      // let animation run
      Future.delayed(const Duration(seconds: 1), () async {
        try {
          final user = await repo.initLogin();

          // if user is null, must manually call navigate as the ever function
          // will not be called
          if (user == null) {
            navigate(user);
          }
        } catch (e) {
          navigate(null);
          print('Failed to login on init');
        }
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
