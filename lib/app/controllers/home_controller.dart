import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/user.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';

class HomeController extends GetxController {
  final UserRepository repo = Get.find<UserRepository>();

  User get user => repo.user;
}
