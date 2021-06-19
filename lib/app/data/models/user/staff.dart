import 'package:ssa_app/app/data/models/user/user.dart';

import '../enums/user_role.dart';

class Staff extends User {
  final List<int> skills;
  final int managerId;

  Staff({
    required int id,
    required String firstname,
    required String surname,
    required this.skills,
    required this.managerId,
  }) : super(
          id: id,
          firstname: firstname,
          surname: surname,
          userRole: UserRole.STAFF,
        );
}
