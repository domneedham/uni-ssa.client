import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/data/repository/manager_staff_skill_repository.dart';

/// Servicec for interacting with the [ManagerStaffSkillRepository].
class ManagerStaffSkillService {
  ManagerStaffSkillService({
    required this.managerStaffSkillRepository,
  });
  final IManagerStaffSkillRepository managerStaffSkillRepository;

  /// Finds the manager staff skill with [id] given.
  Future<ManagerStaffSkill> getById(int id) {
    return managerStaffSkillRepository.getById(id);
  }

  /// Finds all manager staff skills.
  Future<List<ManagerStaffSkill>> getAll() {
    return managerStaffSkillRepository.getAll();
  }
}
