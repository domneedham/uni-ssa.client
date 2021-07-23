import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';

final mockStaff =
    Staff(id: 1, firstname: "Test", surname: "User", skills: [], managerId: 1);

final mockSkillOne = Skill(
  id: 1,
  name: "Test Skill",
  category: Category(id: 1, name: "Test Category", icon: Icons.code),
);

final mockSkillTwo = Skill(
  id: 2,
  name: "Crazy Skill",
  category: Category(id: 1, name: "Crazy Category", icon: Icons.code),
);
