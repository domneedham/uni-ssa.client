import 'package:get/get.dart';
import 'package:ssa_app/app/data/repository/skill_manager_repository.dart';
import 'package:ssa_app/app/data/repository/skill_staff_repository.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';

import './gen_repo_mocks.mocks.dart';

class TestMocks {
  /// Get an instance of [MockUserRepository].
  /// Calls Get.put() to solve dependency injection for the test.
  static MockUserRepository get userRepository {
    final mockRepo = MockUserRepository();
    // ignore: unnecessary_cast
    Get.put(mockRepo as UserRepository);
    return mockRepo;
  }

  /// Get an instance of [MockSkillStaffRepository].
  /// Calls Get.put() to solve dependency injection for the test.
  static MockSkillStaffRepository get skillStaffRepository {
    final mockRepo = MockSkillStaffRepository();
    // ignore: unnecessary_cast
    Get.put(mockRepo as SkillStaffRepository);
    return mockRepo;
  }

  /// Get an instance of [MockSkillManagerRepository].
  /// Calls Get.put() to solve dependency injection for the test.
  static MockSkillManagerRepository get skillManagerRepository {
    final mockRepo = MockSkillManagerRepository();
    // ignore: unnecessary_cast
    Get.put(mockRepo as SkillManagerRepository);
    return mockRepo;
  }
}
