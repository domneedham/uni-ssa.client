import 'package:get/get.dart';
import 'package:ssa_app/app/data/repository/skill_manager_repository.dart';
import 'package:ssa_app/app/data/repository/skill_staff_repository.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRepository>(() => UserRepository());
    Get.lazyPut<SkillRepository>(() => SkillRepository());
    Get.lazyPut<SkillManagerRepository>(() => SkillManagerRepository());
  }
}
