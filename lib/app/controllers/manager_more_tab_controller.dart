import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';

class ManagerMoreTabController extends GetxController {
  final userRepo = Get.find<UserRepository>();

  Manager get user => userRepo.user as Manager;

  void logout() {
    userRepo.logout();
  }
}
