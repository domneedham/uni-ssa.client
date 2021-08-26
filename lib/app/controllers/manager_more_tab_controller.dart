import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/services/user_service.dart';

class ManagerMoreTabController extends GetxController {
  final userService = Get.find<UserService>();

  Manager get user => userService.user as Manager;

  void logout() {
    userService.logout();
  }
}
