import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';

final mockSkillOne = StaffSkill(
  rating: 3,
  lastUpdated: DateTime.now(),
  id: 1,
  name: "Sleeping",
  category: Category(id: 1, name: "ZZZ", icon: Icons.bed),
);

final mockSkillTwo = StaffSkill(
  rating: 3,
  lastUpdated: DateTime.now(),
  id: 2,
  name: "Test",
  category: Category(id: 2, name: "Test Category", icon: Icons.text_fields),
);

final mockUserNoSkills = Staff(id: 1, name: "DN", skills: []);

final mockUserOneSkill = Staff(id: 1, name: "DN", skills: [1]);

final mockUserTwoSkills = Staff(id: 1, name: "DN", skills: [1, 2]);
