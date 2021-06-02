import 'package:ssa_app/app/data/models/user.dart';
import 'package:ssa_app/app/data/models/enums/user_role.dart';

class UserRepository {
  final User user = User(name: "Dom Needham", userRole: UserRole.STAFF);
}
