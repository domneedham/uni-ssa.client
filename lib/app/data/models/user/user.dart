import 'package:ssa_app/app/data/models/enums/user_role.dart';

class User {
  final int id;
  final String name;
  final UserRole userRole;

  User({required this.id, required this.name, required this.userRole});

  String get userDebugInfo => "$name, $userRole";

  bool get isManager => this.userRole == UserRole.MANAGER;
  bool get isStaff => this.userRole == UserRole.STAFF;

  @override
  String toString() {
    return "$name, $userRole";
  }
}
