import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';

final mockError = Exception("Some error");

final mockManager =
    Manager(id: 1, firstname: "Test", surname: "User", staff: [1, 2]);

final mockStaffOne =
    Staff(id: 1, firstname: "Test", surname: "User", managerId: 1, skills: []);

final mockStaffTwo =
    Staff(id: 2, firstname: "Test", surname: "User", managerId: 1, skills: []);

final mockStaffBadManager =
    Staff(id: 3, firstname: "Test", surname: "User", skills: [], managerId: -1);

final mockSkillNoExpiry = StaffSkill(
  rating: 4,
  lastUpdated: DateTime.now(),
  id: 1,
  name: "No Expiry Name",
  category: Category(id: 1, name: "Test Category", icon: Icons.code),
);

final mockSkillExpiryInTime = StaffSkill(
  rating: 4,
  lastUpdated: DateTime.now(),
  id: 1,
  name: "An Expiry Name",
  category: Category(id: 1, name: "Test Category", icon: Icons.code),
  expires: DateTime.now().add(Duration(days: 5)),
);

final mockSkillExpiryExpired = StaffSkill(
  rating: 4,
  lastUpdated: DateTime.now(),
  id: 1,
  name: "Expired Expiry Name",
  category: Category(id: 1, name: "Test Category", icon: Icons.code),
  expires: DateTime.now().subtract(Duration(days: 5)),
);
