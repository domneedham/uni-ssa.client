import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/enums/user_role.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/models/user/user.dart';

class TestData {
  static Category get mockCategoryOne =>
      Category(id: 1, name: "Test Category One", icon: Icons.ac_unit);
  static Category get mockCategoryTwo =>
      Category(id: 1, name: "Test Category Two", icon: Icons.access_alarm);

  /// [Skill] class
  static Skill get mockSkillOne =>
      Skill(id: 1, name: "Test Skill One", category: TestData.mockCategoryOne);

  /// [Skill] class
  static Skill get mockSkillTwo =>
      Skill(id: 2, name: "Test Skill Two", category: TestData.mockCategoryTwo);

  static User get mockUserStaffOne =>
      User(id: 1, firstname: "Staff", surname: "One", userRole: UserRole.STAFF);
  static User get mockUserStaffTwo =>
      User(id: 2, firstname: "Staff", surname: "Two", userRole: UserRole.STAFF);
  static User get mockUserStaffThree => User(
      id: 3, firstname: "Staff", surname: "Three", userRole: UserRole.STAFF);
  static User get mockUserStaffFour => User(
      id: 4, firstname: "Staff", surname: "Four", userRole: UserRole.STAFF);

  static User get mockUserManagerOne => User(
      id: 5, firstname: "Manager", surname: "One", userRole: UserRole.MANAGER);
  static User get mockUserManagerTwo => User(
      id: 6, firstname: "Manager", surname: "Two", userRole: UserRole.MANAGER);

  static Manager get mockManagerNoStaff => Manager(
        id: TestData.mockUserManagerOne.id,
        firstname: TestData.mockUserManagerOne.firstname,
        surname: TestData.mockUserManagerOne.surname,
        staff: [],
      );

  static Manager get mockManagerWithStaff => Manager(
        id: TestData.mockUserManagerTwo.id,
        firstname: TestData.mockUserManagerTwo.firstname,
        surname: TestData.mockUserManagerTwo.surname,
        staff: [
          TestData.mockUserStaffOne,
          TestData.mockUserStaffTwo,
          TestData.mockUserStaffThree,
          TestData.mockUserStaffFour
        ],
      );

  static StaffSkill get mockStaffSkillOneWithNoExpiry => StaffSkill(
        id: TestData.mockSkillOne.id,
        name: TestData.mockSkillOne.name,
        category: TestData.mockSkillOne.category,
        lastUpdated: DateTime.now(),
        rating: 3,
      );

  static StaffSkill get mockStaffSkillTwoWithNoExpiry => StaffSkill(
        id: TestData.mockSkillTwo.id,
        name: TestData.mockSkillTwo.name,
        category: TestData.mockSkillTwo.category,
        lastUpdated: DateTime.now(),
        rating: 3,
      );
  static StaffSkill get mockStaffSkillOneWithExpiry => StaffSkill(
        id: TestData.mockSkillOne.id,
        name: TestData.mockSkillOne.name,
        category: TestData.mockSkillOne.category,
        lastUpdated: DateTime.now(),
        rating: 3,
        expires: DateTime.now().add(Duration(days: 30)),
      );

  static StaffSkill get mockStaffSkillTwoWithExpiry => StaffSkill(
        id: TestData.mockSkillTwo.id,
        name: TestData.mockSkillTwo.name,
        category: TestData.mockSkillTwo.category,
        lastUpdated: DateTime.now(),
        rating: 3,
        expires: DateTime.now().add(Duration(days: 30)),
      );

  static StaffSkill get mockStaffSkillOneWithExpiryExpired => StaffSkill(
        id: TestData.mockSkillOne.id,
        name: TestData.mockSkillOne.name,
        category: TestData.mockSkillOne.category,
        lastUpdated: DateTime.now(),
        rating: 3,
        expires: DateTime.now().subtract(Duration(days: 30)),
      );

  static StaffSkill get mockStaffSkillTwoWithExpiryExpired => StaffSkill(
        id: TestData.mockSkillTwo.id,
        name: TestData.mockSkillTwo.name,
        category: TestData.mockSkillTwo.category,
        lastUpdated: DateTime.now(),
        rating: 3,
        expires: DateTime.now().subtract(Duration(days: 30)),
      );

  /// [Staff] class with no skills assigned to them. ID = 1
  static Staff get mockStaffNoSkills => Staff(
        id: TestData.mockUserStaffOne.id,
        firstname: TestData.mockUserStaffOne.firstname,
        surname: TestData.mockUserStaffOne.surname,
        manager: TestData.mockUserManagerTwo,
        skills: [],
      );

  /// [Staff] class. ID = 2
  static Staff get mockStaffWithExpirySkills => Staff(
        id: TestData.mockUserStaffTwo.id,
        firstname: TestData.mockUserStaffTwo.firstname,
        surname: TestData.mockUserStaffTwo.surname,
        manager: TestData.mockUserManagerTwo,
        skills: [
          TestData.mockStaffSkillOneWithExpiry,
          TestData.mockStaffSkillTwoWithExpiry,
        ],
      );

  /// [Staff] class ID = 3
  static Staff get mockStaffWithExpirySkillsThatHaveExpired => Staff(
        id: TestData.mockUserStaffThree.id,
        firstname: TestData.mockUserStaffThree.firstname,
        surname: TestData.mockUserStaffThree.surname,
        manager: TestData.mockUserManagerTwo,
        skills: [
          TestData.mockStaffSkillOneWithExpiryExpired,
          TestData.mockStaffSkillTwoWithExpiryExpired,
        ],
      );

  /// [Staff] class. ID = 4
  static Staff get mockStaffWithNonExpirySkills => Staff(
        id: TestData.mockUserStaffFour.id,
        firstname: TestData.mockUserStaffFour.firstname,
        surname: TestData.mockUserStaffFour.surname,
        manager: TestData.mockUserManagerTwo,
        skills: [
          TestData.mockStaffSkillOneWithNoExpiry,
          TestData.mockStaffSkillTwoWithNoExpiry,
        ],
      );

  static ManagerStaffSkill get mockManagerStaffSkillOne => ManagerStaffSkill(
        id: TestData.mockSkillOne.id,
        name: TestData.mockSkillOne.name,
        category: TestData.mockSkillOne.category,
        staff: [TestData.mockUserStaffOne],
      );
  static ManagerStaffSkill get mockManagerStaffSkillTwo => ManagerStaffSkill(
        id: TestData.mockSkillTwo.id,
        name: TestData.mockSkillTwo.name,
        category: TestData.mockSkillTwo.category,
        staff: [TestData.mockUserStaffTwo],
      );
}
