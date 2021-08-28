import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/data/providers/manager_staff_skill_provider.dart';

abstract class IManagerStaffSkillRepository {
  Future<List<ManagerStaffSkill>> getAll();
  Future<ManagerStaffSkill> getById(int id);
}

class ManagerStaffSkillRepository implements IManagerStaffSkillRepository {
  ManagerStaffSkillRepository({
    required this.managerStaffSkillProvider,
  });
  final IManagerStaffSkillProvider managerStaffSkillProvider;

  @override
  Future<List<ManagerStaffSkill>> getAll() {
    return managerStaffSkillProvider.getAll();
  }

  @override
  Future<ManagerStaffSkill> getById(int id) {
    return managerStaffSkillProvider.getById(id);
  }
}
