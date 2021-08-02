import 'package:ssa_app/app/data/models/enums/user_role.dart';
import 'package:ssa_app/app/data/models/user/user.dart';

class Manager extends User {
  final List<User> staff;

  Manager({
    required int id,
    required String firstname,
    required String surname,
    required this.staff,
  }) : super(
          id: id,
          firstname: firstname,
          surname: surname,
          userRole: UserRole.MANAGER,
        );

  factory Manager.fromJson(
      {required Map<String, dynamic> userDetails,
      required List<dynamic> staff}) {
    return Manager(
      id: userDetails["id"] as int,
      firstname: userDetails["firstname"] as String,
      surname: userDetails["surname"] as String,
      staff: List<User>.from((staff).map(
        (e) => User.fromJson(e as Map<String, dynamic>, UserRole.STAFF),
      )),
    );
  }
}
