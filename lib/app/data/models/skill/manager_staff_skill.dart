import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';

class ManagerStaffSkill extends Skill {
  final List<int> staff;

  ManagerStaffSkill({
    required int id,
    required String name,
    required Category category,
    required this.staff,
  }) : super(id: id, name: name, category: category);
}
