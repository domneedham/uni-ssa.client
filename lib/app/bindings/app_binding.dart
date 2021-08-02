import 'package:get/get.dart';
import 'package:ssa_app/app/data/providers/category_provider.dart';
import 'package:ssa_app/app/data/providers/manager_provider.dart';
import 'package:ssa_app/app/data/providers/manager_staff_skill_provider.dart';
import 'package:ssa_app/app/data/providers/skill_provider.dart';
import 'package:ssa_app/app/data/providers/staff_provider.dart';
import 'package:ssa_app/app/data/providers/staff_skill_provider.dart';
import 'package:ssa_app/app/data/repository/category_repository.dart';
import 'package:ssa_app/app/data/repository/manager_staff_skill_repository.dart';
import 'package:ssa_app/app/data/repository/skill_repository.dart';
import 'package:ssa_app/app/data/repository/staff_skill_repository.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IStaffProvider>(
      () => StaffProvider(),
      fenix: true,
    );
    Get.lazyPut<IManagerProvider>(
      () => ManagerProvider(),
      fenix: true,
    );
    Get.lazyPut<ICategoryProvider>(
      () => CategoryProvider(),
      fenix: true,
    );
    Get.lazyPut<IManagerStaffSkillProvider>(
      () => ManagerStaffSkillProvider(),
      fenix: true,
    );
    Get.lazyPut<IStaffSkillProvider>(
      () => StaffSkillProvider(),
      fenix: true,
    );
    Get.lazyPut<ISkillProvider>(
      () => SkillProvider(),
      fenix: true,
    );

    Get.lazyPut<UserRepository>(
      () => UserRepository(
        staffProvider: Get.find(),
        managerProvider: Get.find(),
      ),
      fenix: true,
    );
    Get.lazyPut<StaffSkillRepository>(
      () => StaffSkillRepository(
        staffSkillProvider: Get.find(),
      ),
      fenix: true,
    );
    Get.lazyPut<ManagerStaffSkillRepository>(
      () => ManagerStaffSkillRepository(
        managerStaffSkillProvider: Get.find(),
      ),
      fenix: true,
    );
    Get.lazyPut<CategoryRepository>(
      () => CategoryRepository(
        categoryProvider: Get.find(),
      ),
      fenix: true,
    );
    Get.lazyPut<SkillRepository>(
      () => SkillRepository(skillProvider: Get.find()),
      fenix: true,
    );
  }
}
