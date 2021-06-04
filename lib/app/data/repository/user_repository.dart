import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/models/user/user.dart';
import 'package:ssa_app/app/data/models/enums/user_role.dart';

class UserRepository {
  final User user =
      User(id: 2, name: "Dom Needham", userRole: UserRole.MANAGER);

  final Staff staff =
      Staff(id: 1, name: "Dom Needham", skills: [1, 2, 3, 4, 5]);

  final Manager manager = Manager(id: 2, name: "Dom Needham", staff: [1]);
}
