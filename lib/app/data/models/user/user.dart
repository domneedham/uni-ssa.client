import 'package:ssa_app/app/data/models/enums/user_role.dart';

class User {
  User({
    required this.id,
    required this.firstname,
    required this.surname,
    required this.userRole,
  });

  factory User.fromJson(Map<String, dynamic> json, UserRole userRole) {
    return User(
      id: json['id'] as int,
      firstname: json['firstname'] as String,
      surname: json['surname'] as String,
      userRole: userRole,
    );
  }

  final int id;
  final String firstname;
  final String surname;
  final UserRole userRole;

  String get name => '$firstname $surname';

  String get userDebugInfo => '$name, $userRole';

  bool get isManager => userRole == UserRole.MANAGER;
  bool get isStaff => userRole == UserRole.STAFF;

  @override
  String toString() {
    return '$name, $userRole';
  }
}
