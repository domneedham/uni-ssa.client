import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/data/providers/manager_staff_skill_provider.dart';

class ManagerStaffSkillRepository {
  ManagerStaffSkillRepository({required this.managerStaffSkillProvider});
  final IManagerStaffSkillProvider managerStaffSkillProvider;

  Future<ManagerStaffSkill> getManagerStaffSkillById(int id) async {
    return managerStaffSkillProvider.getById(id);
  }

  Future<List<ManagerStaffSkill>> get skills async {
    return managerStaffSkillProvider.getAll();
  }
}
