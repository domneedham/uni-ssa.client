import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/providers/staff_skill_provider.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';

class StaffSkillRepository {
  StaffSkillRepository({required this.staffSkillProvider});
  final IStaffSkillProvider staffSkillProvider;

  Future<StaffSkill> getSkillById(int id) async {
    return staffSkillProvider.getByIdDecoded(
      id,
      UserRepository.to.user!.id,
    );
  }

  Future<List<StaffSkill>> getSkillsForUser(int id) async {
    return staffSkillProvider.getAllForUser(id);
  }

  Future<List<StaffSkill>> get skills {
    return staffSkillProvider.getAll();
  }

  Future<StaffSkill> saveEdited(StaffSkill skill) {
    return staffSkillProvider.saveEdited(skill, UserRepository.to.user!.id);
  }

  Future<StaffSkill> saveNew(StaffSkill skill) {
    return staffSkillProvider.saveNew(skill, UserRepository.to.user!.id);
  }
}
