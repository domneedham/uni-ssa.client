import 'package:ssa_app/app/data/models/enums/user_role.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';
import 'package:ssa_app/app/data/models/user/user.dart';

class ManagerStaffSkill extends Skill {
  final List<User> staff;

  ManagerStaffSkill({
    required int id,
    required String name,
    required Category category,
    required this.staff,
  }) : super(id: id, name: name, category: category);

  factory ManagerStaffSkill.fromJson({
    required Map<String, dynamic> skill,
    required List<dynamic> staff,
  }) {
    return ManagerStaffSkill(
      id: skill["id"] as int,
      name: skill["name"] as String,
      category: Category.fromJson(skill["category"]),
      staff: List<User>.from((staff).map(
        (e) => User.fromJson(e, UserRole.STAFF),
      )),
    );
  }
}
