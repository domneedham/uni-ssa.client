import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/repository/staff_skill_repository.dart';
import 'package:ssa_app/app/data/services/user_service.dart';

class StaffSkillService {
  StaffSkillService({
    required this.staffSkillRepository,
  });
  final IStaffSkillRepository staffSkillRepository;

  Future<StaffSkill> getById(int id) {
    return staffSkillRepository.getById(id, UserService.to.user!.id);
  }

  Future<List<StaffSkill>> getAllByUserId(int id) {
    return staffSkillRepository.getAllByUserId(id);
  }

  Future<List<StaffSkill>> getAll() {
    return staffSkillRepository.getAll();
  }

  Future<StaffSkill> create(StaffSkill skill) {
    return staffSkillRepository.create(skill, UserService.to.user!.id);
  }

  Future<StaffSkill> update(StaffSkill skill) {
    return staffSkillRepository.update(skill, UserService.to.user!.id);
  }
}
