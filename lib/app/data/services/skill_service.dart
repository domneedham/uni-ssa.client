import 'package:ssa_app/app/data/models/skill/skill.dart';
import 'package:ssa_app/app/data/repository/skill_repository.dart';

class SkillService {
  SkillService({required this.skillRepository});
  final SkillRepository skillRepository;

  Future<List<Skill>> searchByName(String name) async {
    return skillRepository.searchByName(name);
  }

  Future<Skill> findById(int id) async {
    return skillRepository.findById(id);
  }

  Future<Skill> create(Skill skill) async {
    return skillRepository.create(skill);
  }

  Future<Skill> update(Skill skill) async {
    return skillRepository.update(skill);
  }

  Future<void> delete(int id) async {
    return skillRepository.delete(id);
  }
}
