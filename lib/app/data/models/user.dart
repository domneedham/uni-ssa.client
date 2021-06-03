import 'package:ssa_app/app/data/models/enums/user_role.dart';

class User {
  final int id;
  final String name;
  final UserRole userRole;

  User({required this.id, required this.name, required this.userRole});

  String get userDebugInfo => "$name, $userRole";

  @override
  String toString() {
    return "$name, $userRole";
  }
}
