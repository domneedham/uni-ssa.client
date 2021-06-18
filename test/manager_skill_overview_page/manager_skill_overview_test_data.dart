import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';

final skillOne = ManagerStaffSkill(
  id: 1,
  name: "One",
  category: Category(id: 1, name: "Cat One", icon: Icons.text_fields),
  staff: [1],
);

final skillTwo = ManagerStaffSkill(
  id: 2,
  name: "Two",
  category: Category(id: 2, name: "Cat Two", icon: Icons.text_fields),
  staff: [1],
);

final staffOne =
    Staff(id: 1, firstname: "Staff", surname: "One", skills: [1], managerId: 1);

final managerOne =
    Manager(id: 1, firstname: "Manager", surname: "One", staff: [1]);
