import 'package:get/get.dart';
import 'package:ssa_app/app/data/providers/auth_provider.dart';
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
import 'package:ssa_app/app/data/services/box_service.dart';
import 'package:ssa_app/app/data/services/category_service.dart';
import 'package:ssa_app/app/data/services/manager_staff_skill_service.dart';
import 'package:ssa_app/app/data/services/skill_service.dart';
import 'package:ssa_app/app/data/services/staff_skill_service.dart';
import 'package:ssa_app/app/data/services/user_service.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IAuthProvider>(
      () => AuthProvider(),
      fenix: true,
    );
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

    Get.lazyPut<IUserRepository>(
      () => UserRepository(
        staffProvider: Get.find(),
        managerProvider: Get.find(),
        authProvider: Get.find(),
      ),
      fenix: true,
    );
    Get.lazyPut<IStaffSkillRepository>(
      () => StaffSkillRepository(
        staffSkillProvider: Get.find(),
      ),
      fenix: true,
    );
    Get.lazyPut<IManagerStaffSkillRepository>(
      () => ManagerStaffSkillRepository(
        managerStaffSkillProvider: Get.find(),
      ),
      fenix: true,
    );
    Get.lazyPut<ICategoryRepository>(
      () => CategoryRepository(
        categoryProvider: Get.find(),
      ),
      fenix: true,
    );
    Get.lazyPut<ISkillRepository>(
      () => SkillRepository(skillProvider: Get.find()),
      fenix: true,
    );

    Get.lazyPut<BoxService>(() => BoxService());

    Get.put<UserService>(
      UserService(
        boxService: Get.find(),
        userRepository: Get.find(),
      ),
      permanent: true,
    );
    Get.lazyPut<StaffSkillService>(
      () => StaffSkillService(
        staffSkillRepository: Get.find(),
      ),
      fenix: true,
    );
    Get.lazyPut<ManagerStaffSkillService>(
      () => ManagerStaffSkillService(
        managerStaffSkillRepository: Get.find(),
      ),
      fenix: true,
    );
    Get.lazyPut<CategoryService>(
      () => CategoryService(
        categoryRepository: Get.find(),
      ),
      fenix: true,
    );
    Get.lazyPut<SkillService>(
      () => SkillService(
        skillRepository: Get.find(),
      ),
      fenix: true,
    );
  }
}
