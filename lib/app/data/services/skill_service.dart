import 'package:ssa_app/app/data/models/skill/skill.dart';
import 'package:ssa_app/app/data/repository/skill_repository.dart';

/// Service for interacting with the [SkillRepository].
class SkillService {
  SkillService({
    required this.skillRepository,
  });
  final ISkillRepository skillRepository;

  /// Finds all skills that match an exact or extended version of [name].
  Future<List<Skill>> searchByName(String name) {
    return skillRepository.searchByName(name);
  }

  /// Finds the skill with the [id] given.
  Future<Skill> getById(int id) {
    return skillRepository.getById(id);
  }

  /// Creates a new skill.
  Future<Skill> create(Skill skill) {
    return skillRepository.create(skill);
  }

  /// Updates an existing skill. All updated information should be present
  /// in the [skill].
  Future<Skill> update(Skill skill) {
    return skillRepository.update(skill);
  }

  /// Deletes the skill with the [id] given. This will also delete all
  /// staff-skills that are associated with the skill.
  Future<void> delete(int id) {
    return skillRepository.delete(id);
  }
}
