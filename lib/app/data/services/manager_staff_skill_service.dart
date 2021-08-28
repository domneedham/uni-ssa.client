import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/data/repository/manager_staff_skill_repository.dart';

class ManagerStaffSkillService {
  ManagerStaffSkillService({
    required this.managerStaffSkillRepository,
  });
  final IManagerStaffSkillRepository managerStaffSkillRepository;

  Future<ManagerStaffSkill> getById(int id) {
    return managerStaffSkillRepository.getById(id);
  }

  Future<List<ManagerStaffSkill>> getAll() {
    return managerStaffSkillRepository.getAll();
  }
}
