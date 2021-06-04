import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';

final mockManagerStaffSkillOne = ManagerStaffSkill(
  id: 1,
  name: "Sleeping",
  category: Category(id: 1, name: "ZZZ", icon: Icons.bed),
  staff: [1],
);

final mockManagerStaffSkillTwo = ManagerStaffSkill(
  id: 2,
  name: "Test",
  category: Category(id: 2, name: "Test Category", icon: Icons.text_fields),
  staff: [1],
);

final mockManager = Manager(id: 1, name: "DN", staff: [1]);

final mockUserNoSkills = Staff(id: 1, name: "DN", skills: []);

final mockUserOneSkill = Staff(id: 1, name: "DN", skills: [1]);

final mockUserTwoSkills = Staff(id: 1, name: "DN", skills: [1, 2]);
