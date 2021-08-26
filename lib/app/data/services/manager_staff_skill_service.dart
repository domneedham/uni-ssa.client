import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/data/repository/manager_staff_skill_repository.dart';

class ManagerStaffSkillService {
  ManagerStaffSkillService({required this.managerStaffSkillRepository});
  final ManagerStaffSkillRepository managerStaffSkillRepository;

  Future<ManagerStaffSkill> getManagerStaffSkillById(int id) {
    return managerStaffSkillRepository.getManagerStaffSkillById(id);
  }

  Future<List<ManagerStaffSkill>> get skills {
    return managerStaffSkillRepository.skills;
  }
}
