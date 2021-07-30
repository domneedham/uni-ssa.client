import 'package:get/get.dart';
import 'package:ssa_app/app/data/providers/staff_provider.dart';
import 'package:ssa_app/app/data/repository/category_repository.dart';
import 'package:ssa_app/app/data/repository/skill_manager_repository.dart';
import 'package:ssa_app/app/data/repository/skill_staff_repository.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IStaffProvider>(
      () => StaffProvider(),
      fenix: true,
    );

    Get.lazyPut<UserRepository>(
      () => UserRepository(staffProvider: Get.find()),
      fenix: true,
    );
    Get.lazyPut<SkillStaffRepository>(
      () => SkillStaffRepository(),
      fenix: true,
    );
    Get.lazyPut<SkillManagerRepository>(
      () => SkillManagerRepository(),
      fenix: true,
    );
    Get.lazyPut<CategoryRepository>(
      () => CategoryRepository(),
      fenix: true,
    );
  }
}
