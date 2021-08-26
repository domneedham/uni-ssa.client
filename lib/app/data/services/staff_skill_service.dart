import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/repository/staff_skill_repository.dart';
import 'package:ssa_app/app/data/services/user_service.dart';

class StaffSkillService {
  StaffSkillService({required this.staffSkillRepository});
  final StaffSkillRepository staffSkillRepository;

  Future<StaffSkill> getSkillById(int id) async {
    return staffSkillRepository.getById(id, UserService.to.user!.id);
  }

  Future<List<StaffSkill>> getSkillsForUser(int id) async {
    return staffSkillRepository.getAllByUserId(id);
  }

  Future<List<StaffSkill>> get skills {
    return staffSkillRepository.getAll();
  }

  Future<StaffSkill> saveEdited(StaffSkill skill) {
    return staffSkillRepository.update(skill, UserService.to.user!.id);
  }

  Future<StaffSkill> saveNew(StaffSkill skill) {
    return staffSkillRepository.create(skill, UserService.to.user!.id);
  }
}
