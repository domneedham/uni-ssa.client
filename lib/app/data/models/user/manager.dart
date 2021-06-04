import 'package:ssa_app/app/data/models/enums/user_role.dart';
import 'package:ssa_app/app/data/models/user/user.dart';

class Manager extends User {
  final List<int> staff;

  Manager({
    required this.staff,
    required int id,
    required String name,
  }) : super(id: id, name: name, userRole: UserRole.MANAGER);
}
