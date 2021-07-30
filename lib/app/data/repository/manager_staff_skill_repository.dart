import 'package:flutter/material.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/data/providers/manager_staff_skill_provider.dart';

class ManagerStaffSkillRepository {
  ManagerStaffSkillRepository({required this.managerStaffSkillProvider});
  final IManagerStaffSkillProvider managerStaffSkillProvider;

  Future<ManagerStaffSkill> getManagerStaffSkillById(int id) async {
    final res = await managerStaffSkillProvider.getById(id);
    return res.body!;
  }

  Future<List<ManagerStaffSkill>> get skills async {
    print(Icons.cabin.codePoint);
    final res = await managerStaffSkillProvider.getAll();
    return res.body!;
  }
}
