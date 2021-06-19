import 'package:ssa_app/app/data/models/enums/user_role.dart';
import 'package:ssa_app/app/data/models/user/user.dart';

class Manager extends User {
  final List<int> staff;

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
}
