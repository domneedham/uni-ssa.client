import 'package:get/get.dart';
import 'package:ssa_app/app/data/repository/category_repository.dart';
import 'package:ssa_app/app/data/repository/manager_staff_skill_repository.dart';
import 'package:ssa_app/app/data/repository/skill_repository.dart';

import 'package:ssa_app/app/data/repository/staff_skill_repository.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';

import './gen_repo_mocks.mocks.dart';

class TestMocks {
  /// Get an instance of [MockUserRepository].
  /// Calls Get.put() to solve dependency injection for the test.
  static MockUserRepository get userRepository {
    final mockRepo = MockUserRepository();
    Get.lazyPut<UserRepository>(() => mockRepo, fenix: true);
    return mockRepo;
  }

  /// Get an instance of [MockSkillStaffRepository].
  /// Calls Get.put() to solve dependency injection for the test.
  static MockStaffSkillRepository get skillStaffRepository {
    final mockRepo = MockStaffSkillRepository();
    // ignore: unnecessary_cast
    Get.put(mockRepo as StaffSkillRepository);
    return mockRepo;
  }

  /// Get an instance of [MockSkillManagerRepository].
  /// Calls Get.put() to solve dependency injection for the test.
  static MockManagerStaffSkillRepository get skillManagerRepository {
    final mockRepo = MockManagerStaffSkillRepository();
    // ignore: unnecessary_cast
    Get.put(mockRepo as ManagerStaffSkillRepository);
    return mockRepo;
  }

  /// Get an instance of [MockCategoryRepository].
  /// Calls Get.put() to solve dependency injection for the test.
  static MockCategoryRepository get categoriesRepository {
    final mockRepo = MockCategoryRepository();
    // ignore: unnecessary_cast
    Get.put(mockRepo as CategoryRepository);
    return mockRepo;
  }

  /// Get an instance of [MockSkillRepository].
  /// Calls Get.put() to solve dependency injection for the test.
  static MockSkillRepository get skillRepository {
    final mockRepo = MockSkillRepository();
    // ignore: unnecessary_cast
    Get.put(mockRepo as SkillRepository);
    return mockRepo;
  }
}
