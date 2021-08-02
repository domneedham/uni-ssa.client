import 'package:ssa_app/app/data/models/enums/user_role.dart';

class User {
  final int id;
  final String firstname;
  final String surname;
  final UserRole userRole;

  User({
    required this.id,
    required this.firstname,
    required this.surname,
    required this.userRole,
  });

  String get name => "$firstname $surname";

  String get userDebugInfo => "$name, $userRole";

  bool get isManager => this.userRole == UserRole.MANAGER;
  bool get isStaff => this.userRole == UserRole.STAFF;

  factory User.fromJson(Map<String, dynamic> json, UserRole userRole) {
    return User(
      id: json["id"] as int,
      firstname: json["firstname"] as String,
      surname: json["surname"] as String,
      userRole: userRole,
    );
  }

  @override
  String toString() {
    return "$name, $userRole";
  }
}
