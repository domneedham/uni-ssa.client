import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';

class SkillRepository {
  final skillOne = StaffSkill(
    rating: 4,
    lastUpdated: DateTime.now(),
    id: 1,
    name: "Dart",
    category: Category(id: 1, name: "Code", icon: Icons.code),
  );

  final skillTwo = StaffSkill(
    rating: 1,
    lastUpdated: DateTime.now(),
    id: 2,
    name: "Public Speaking",
    category: Category(id: 3, name: "People", icon: Icons.people),
  );

  final skillThree = StaffSkill(
    rating: 4,
    lastUpdated: DateTime.now(),
    id: 3,
    name: "Flutter",
    category: Category(id: 1, name: "Code", icon: Icons.code),
  );

  final skillFour = StaffSkill(
    rating: 4,
    lastUpdated: DateTime.now(),
    id: 4,
    name: "Tidyness",
    category: Category(id: 2, name: "Organisation", icon: Icons.sort),
  );

  List<StaffSkill> get _skills => [skillOne, skillTwo, skillThree, skillFour];

  StaffSkill? getStaffSkillById(int id) {
    try {
      return _skills.firstWhere((element) => element.id == id);
    } catch (StateError) {
      return null;
    }
  }
}
