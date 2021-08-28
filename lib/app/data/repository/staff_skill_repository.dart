import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/providers/staff_skill_provider.dart';

abstract class IStaffSkillRepository {
  Future<StaffSkill> getById(int id, int userId);
  Future<List<StaffSkill>> getAllByUserId(int id);
  Future<List<StaffSkill>> getAll();
  Future<StaffSkill> create(StaffSkill skill, int userId);
  Future<StaffSkill> update(StaffSkill skill, int userId);
}

class StaffSkillRepository implements IStaffSkillRepository {
  StaffSkillRepository({
    required this.staffSkillProvider,
  });
  final IStaffSkillProvider staffSkillProvider;

  @override
  Future<StaffSkill> getById(int id, int userId) async {
    return staffSkillProvider.getById(id, userId);
  }

  @override
  Future<List<StaffSkill>> getAllByUserId(int id) async {
    return staffSkillProvider.getAllForUser(id);
  }

  @override
  Future<List<StaffSkill>> getAll() {
    return staffSkillProvider.getAll();
  }

  @override
  Future<StaffSkill> create(StaffSkill skill, int userId) {
    return staffSkillProvider.create(skill, userId);
  }

  @override
  Future<StaffSkill> update(StaffSkill skill, int userId) {
    return staffSkillProvider.update(skill, userId);
  }
}
