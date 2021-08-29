import 'package:get/get.dart';
import 'package:ssa_app/app/data/repository/category_repository.dart';
import 'package:ssa_app/app/data/repository/manager_staff_skill_repository.dart';
import 'package:ssa_app/app/data/repository/skill_repository.dart';

import 'package:ssa_app/app/data/repository/staff_skill_repository.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';
import 'package:ssa_app/app/data/services/category_service.dart';
import 'package:ssa_app/app/data/services/manager_staff_skill_service.dart';
import 'package:ssa_app/app/data/services/skill_service.dart';
import 'package:ssa_app/app/data/services/staff_skill_service.dart';
import 'package:ssa_app/app/data/services/user_service.dart';

import './gen_repo_mocks.mocks.dart';

// ignore_for_file: unnecessary_cast

// ignore: avoid_classes_with_only_static_members
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
    Get.put(mockRepo as StaffSkillRepository);
    return mockRepo;
  }

  /// Get an instance of [MockSkillManagerRepository].
  /// Calls Get.put() to solve dependency injection for the test.
  static MockManagerStaffSkillRepository get skillManagerRepository {
    final mockRepo = MockManagerStaffSkillRepository();
    Get.put(mockRepo as ManagerStaffSkillRepository);
    return mockRepo;
  }

  /// Get an instance of [MockCategoryRepository].
  /// Calls Get.put() to solve dependency injection for the test.
  static MockCategoryRepository get categoriesRepository {
    final mockRepo = MockCategoryRepository();
    Get.put(mockRepo as CategoryRepository);
    return mockRepo;
  }

  /// Get an instance of [MockSkillRepository].
  /// Calls Get.put() to solve dependency injection for the test.
  static MockSkillRepository get skillRepository {
    final mockRepo = MockSkillRepository();
    Get.put(mockRepo as SkillRepository);
    return mockRepo;
  }

  /// Get an instance of [MockUserService].
  /// Calls Get.put() to solve dependency injection for the test.
  static MockUserService get userService {
    final mockService = MockUserService();
    Get.lazyPut<UserService>(() => mockService, fenix: true);
    // instantiate repositories
    TestMocks.userRepository;
    return mockService;
  }

  /// Get an instance of [MockSkillStaffService].
  /// Calls Get.put() to solve dependency injection for the test.
  static MockStaffSkillService get skillStaffService {
    final mockService = MockStaffSkillService();
    Get.put(mockService as StaffSkillService);
    // instantiate repositories
    TestMocks.skillRepository;
    return mockService;
  }

  /// Get an instance of [MockSkillManagerService].
  /// Calls Get.put() to solve dependency injection for the test.
  static MockManagerStaffSkillService get skillManagerService {
    final mockService = MockManagerStaffSkillService();
    Get.put(mockService as ManagerStaffSkillService);
    // instantiate repositories
    TestMocks.skillManagerRepository;
    return mockService;
  }

  /// Get an instance of [MockCategoryService].
  /// Calls Get.put() to solve dependency injection for the test.
  static MockCategoryService get categoriesService {
    final mockService = MockCategoryService();
    Get.put(mockService as CategoryService);
    // instantiate repositories
    TestMocks.categoriesRepository;
    return mockService;
  }

  /// Get an instance of [MockSkillService].
  /// Calls Get.put() to solve dependency injection for the test.
  static MockSkillService get skillService {
    final mockService = MockSkillService();
    Get.put(mockService as SkillService);
    // instantiate repositories
    TestMocks.skillRepository;
    return mockService;
  }
}
