import 'package:ssa_app/app/data/models/skill/skill.dart';
import 'package:ssa_app/app/data/providers/skill_provider.dart';

abstract class ISkillRepository {
  Future<List<Skill>> searchByName(String name);
  Future<Skill> getById(int id);
  Future<Skill> create(Skill skill);
  Future<Skill> update(Skill skill);
  Future<void> delete(int id);
}

class SkillRepository implements ISkillRepository {
  SkillRepository({
    required this.skillProvider,
  });
  final ISkillProvider skillProvider;

  @override
  Future<List<Skill>> searchByName(String name) {
    return skillProvider.searchByName(name);
  }

  @override
  Future<Skill> getById(int id) {
    return skillProvider.getById(id);
  }

  @override
  Future<Skill> create(Skill skill) {
    return skillProvider.create(skill);
  }

  @override
  Future<Skill> update(Skill skill) {
    return skillProvider.update(skill);
  }

  @override
  Future<void> delete(int id) {
    return skillProvider.deleteSkill(id);
  }
}
