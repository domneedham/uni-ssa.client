import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/models/user/user.dart';
import 'package:ssa_app/app/data/models/enums/user_role.dart';

class UserRepository {
  final User user = User(
      id: 2, firstname: "Dom", surname: "Needham", userRole: UserRole.STAFF);

  final Staff staff = Staff(
    id: 1,
    firstname: "Dom",
    surname: "Needham",
    skills: [1, 2, 3, 4, 5],
    managerId: 2,
  );
  final Staff staff2 = Staff(
    id: 2,
    firstname: "John",
    surname: "Doe",
    skills: [1, 2, 3],
    managerId: 2,
  );

  final Manager manager =
      Manager(id: 2, firstname: "Dom", surname: "Needham", staff: [1, 2]);

  List<Staff> get _staff => [staff, staff2];
  List<Manager> get _manager => [manager];

  Future<Staff> getStaffById(int id) async {
    return Future.delayed(Duration(milliseconds: 500), () {
      return _staff.firstWhere((element) => element.id == id);
    });
  }

  Future<Manager> getManagerById(int id) async {
    return Future.delayed(Duration(seconds: 1), () {
      return _manager.firstWhere((element) => element.id == id);
    });
  }

  Future<List<Staff>> searchStaffByName(String searchText) async {
    return Future.delayed(Duration(milliseconds: 750), () {
      if (searchText.isEmpty) {
        return List.empty();
      }
      return _staff
          .where(
            (element) =>
                element.name.toLowerCase().contains(searchText.toLowerCase()),
          )
          .toList();
    });
  }

  Future<List<Manager>> searchManagerByName(String searchText) async {
    return Future.delayed(Duration(milliseconds: 750), () {
      if (searchText.isEmpty) {
        return List.empty();
      }
      return _manager
          .where(
            (element) =>
                element.name.toLowerCase().contains(searchText.toLowerCase()),
          )
          .toList();
    });
  }
}
