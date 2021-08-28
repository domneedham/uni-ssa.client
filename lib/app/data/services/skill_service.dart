import 'package:ssa_app/app/data/models/skill/skill.dart';
import 'package:ssa_app/app/data/repository/skill_repository.dart';

class SkillService {
  SkillService({
    required this.skillRepository,
  });
  final ISkillRepository skillRepository;

  Future<List<Skill>> searchByName(String name) {
    return skillRepository.searchByName(name);
  }

  Future<Skill> getById(int id) {
    return skillRepository.getById(id);
  }

  Future<Skill> create(Skill skill) {
    return skillRepository.create(skill);
  }

  Future<Skill> update(Skill skill) {
    return skillRepository.update(skill);
  }

  Future<void> delete(int id) {
    return skillRepository.delete(id);
  }
}
