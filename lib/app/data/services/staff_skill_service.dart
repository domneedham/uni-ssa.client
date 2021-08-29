import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/repository/staff_skill_repository.dart';
import 'package:ssa_app/app/data/services/user_service.dart';

class StaffSkillService {
  StaffSkillService({
    required this.staffSkillRepository,
  });
  final IStaffSkillRepository staffSkillRepository;

  /// Finds the staff skill with the [id] given, providing it matches with the
  /// current logged in user.
  Future<StaffSkill> getById(int id) {
    return staffSkillRepository.getById(id, UserService.to.user!.id);
  }

  /// Finds all staff skills are associated with the [id] of the staff given.
  Future<List<StaffSkill>> getAllByUserId(int id) {
    return staffSkillRepository.getAllByUserId(id);
  }

  /// Finds all staff skills.
  Future<List<StaffSkill>> getAll() {
    return staffSkillRepository.getAll();
  }

  /// Creates a new staff skill.
  Future<StaffSkill> create(StaffSkill skill) {
    return staffSkillRepository.create(skill, UserService.to.user!.id);
  }

  /// Updates the staff skill. All information should be present in the [skill].
  Future<StaffSkill> update(StaffSkill skill) {
    return staffSkillRepository.update(skill, UserService.to.user!.id);
  }
}
