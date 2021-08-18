import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/models/user/user.dart';

import '../enums/user_role.dart';

class Staff extends User {
  Staff({
    required int id,
    required String firstname,
    required String surname,
    required this.skills,
    required this.manager,
  }) : super(
          id: id,
          firstname: firstname,
          surname: surname,
          userRole: UserRole.STAFF,
        );

  factory Staff.fromJson({
    required Map<String, dynamic> userDetails,
    required Map<String, dynamic> managerDetails,
    required List<dynamic> skills,
  }) {
    return Staff(
      id: userDetails['id'] as int,
      firstname: userDetails['firstname'] as String,
      surname: userDetails['surname'] as String,
      skills: List<StaffSkill>.from(skills.map(
        (x) => StaffSkill.fromJson(x as Map<String, dynamic>),
      )),
      manager: User.fromJson(managerDetails, UserRole.MANAGER),
    );
  }

  final List<StaffSkill> skills;
  final User manager;
}
