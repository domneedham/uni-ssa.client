import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/providers/staff_skill_provider.dart';

class StaffSkillRepository {
  StaffSkillRepository({required this.staffSkillProvider});
  final IStaffSkillProvider staffSkillProvider;

  Future<StaffSkill> getSkillById(int id) async {
    final res = await staffSkillProvider.getById(id);
    return res.body!;
  }

  Future<List<StaffSkill>> getSkillsForUser(int id) async {
    final res = await staffSkillProvider.getAllForUser(id);
    return res.body!;
  }

  Future<List<StaffSkill>> get skills async {
    final res = await staffSkillProvider.getAll();
    return res.body!;
  }
}
