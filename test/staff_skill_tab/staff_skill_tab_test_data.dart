import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';

final mockStaffSkillOne = StaffSkill(
  rating: 3,
  lastUpdated: DateTime.now(),
  id: 1,
  name: "Sleeping",
  category: Category(id: 1, name: "ZZZ", icon: Icons.bed),
);

final mockStaffSkillTwo = StaffSkill(
  rating: 3,
  lastUpdated: DateTime.now(),
  id: 2,
  name: "Test",
  category: Category(id: 2, name: "Test Category", icon: Icons.text_fields),
);

final mockStaffNoSkills =
    Staff(id: 1, firstname: "D", surname: "N", skills: [], managerId: 1);

final mockStaffOneSkill =
    Staff(id: 1, firstname: "D", surname: "N", skills: [1], managerId: 1);

final mockStaffTwoSkills =
    Staff(id: 1, firstname: "D", surname: "N", skills: [1, 2], managerId: 1);
