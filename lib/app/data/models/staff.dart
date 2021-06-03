import 'package:ssa_app/app/data/models/user.dart';

import 'enums/user_role.dart';

class Staff extends User {
  final List<int> skills;

  Staff({
    required int id,
    required String name,
    required this.skills,
  }) : super(id: id, name: name, userRole: UserRole.STAFF);
}
