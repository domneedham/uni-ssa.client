import 'package:get/get.dart';
import 'package:ssa_app/app/data/repository/skill_repository.dart';
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

  /// Get an instance of [MockSkillRepository].
  /// Calls Get.put() to solve dependency injection for the test.
  static MockSkillRepository get skillRepository {
    final mockRepo = MockSkillRepository();
    // ignore: unnecessary_cast
    Get.put(mockRepo as SkillRepository);
    return mockRepo;
  }
}
