import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/exceptions/no_data_found.dart';

class SkillManagerRepository {
  final skillOne = ManagerStaffSkill(
    id: 1,
    name: "Flutter",
    category: Category(id: 1, name: "Code", icon: Icons.code),
    staff: [1, 2],
  );

  final skillTwo = ManagerStaffSkill(
    id: 2,
    name: "Organisation",
    category: Category(id: 5, name: "People", icon: Icons.people),
    staff: [1, 2],
  );

  List<ManagerStaffSkill> get _skills => [skillOne, skillTwo];

  Future<ManagerStaffSkill> getManagerStaffSkillById(int id) async {
    try {
      return await Future.delayed(Duration(seconds: 1), () {
        return _skills.firstWhere((element) => element.id == id);
      });
    } catch (StateError) {
      return Future.error(Exception("That item wasn't found."));
    }
  }

  Future<List<ManagerStaffSkill>> get skills async {
    try {
      return await Future.delayed(Duration(seconds: 2), () {
        // throw NoDataReturned("No data returned from the server");
        return _skills;
      });
    } catch (StateError) {
      throw NoDataReturned("No data returned from the server");
    }
  }
}
