import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';

final mockStaff =
    Staff(id: 1, firstname: "Test", surname: "User", managerId: 1, skills: []);

final mockSkillWithExpiry = StaffSkill(
  rating: 4,
  lastUpdated: DateTime.now(),
  id: 1,
  name: "Test Skill with Expiry",
  category:
      Category(icon: Icons.calendar_today, id: 1, name: 'Expiry Category'),
  expires: DateTime.now().add(Duration(days: 30)),
);

final mockSkillNoExpiry = StaffSkill(
  rating: 4,
  lastUpdated: DateTime.now(),
  id: 2,
  name: "Test Skill",
  category: Category(icon: Icons.calendar_today, id: 1, name: 'Category'),
);
