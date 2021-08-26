import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/providers/staff_skill_provider.dart';

class StaffSkillRepository {
  StaffSkillRepository({required this.staffSkillProvider});
  final IStaffSkillProvider staffSkillProvider;

  Future<StaffSkill> getById(int id, int userId) async {
    return staffSkillProvider.getByIdDecoded(id, userId);
  }

  Future<List<StaffSkill>> getAllByUserId(int id) async {
    return staffSkillProvider.getAllForUser(id);
  }

  Future<List<StaffSkill>> getAll() {
    return staffSkillProvider.getAll();
  }

  Future<StaffSkill> update(StaffSkill skill, int userId) {
    return staffSkillProvider.saveEdited(skill, userId);
  }

  Future<StaffSkill> create(StaffSkill skill, int userId) {
    return staffSkillProvider.saveNew(skill, userId);
  }
}
