import 'package:ssa_app/app/data/models/skill/skill.dart';
import 'package:ssa_app/app/data/providers/skill_provider.dart';

class SkillRepository {
  SkillRepository({required this.skillProvider});
  final ISkillProvider skillProvider;

  Future<List<Skill>> searchByName(String name) async {
    final res = await skillProvider.searchByName(name);
    return res.body!;
  }

  Future<Skill> findById(int id) async {
    return skillProvider.getById(id);
  }
}
