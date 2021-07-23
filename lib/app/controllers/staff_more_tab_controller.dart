import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';

class StaffMoreTabController extends GetxController {
  final userRepo = Get.find<UserRepository>();

  Staff get user => userRepo.staff;
}
