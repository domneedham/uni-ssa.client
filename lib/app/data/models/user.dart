import 'package:ssa_app/app/data/models/enums/user_role.dart';

class User {
  User({required this.name, required this.userRole});

  final String name;
  final UserRole userRole;

  @override
  String toString() {
    return "$name, $userRole";
  }
}
