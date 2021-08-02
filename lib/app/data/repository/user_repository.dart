import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/models/user/user.dart';
import 'package:ssa_app/app/data/models/enums/user_role.dart';
import 'package:ssa_app/app/data/providers/manager_provider.dart';
import 'package:ssa_app/app/data/providers/staff_provider.dart';

class UserRepository {
  static UserRepository get to => Get.find<UserRepository>();

  UserRepository({required this.staffProvider, required this.managerProvider});
  final IStaffProvider staffProvider;
  final IManagerProvider managerProvider;

  final User user =
      User(id: 1, firstname: "Test", surname: "User", userRole: UserRole.STAFF);

  final Staff staff = Staff(
    id: 1,
    firstname: "Test",
    surname: "Staff",
    skills: [],
    manager: User(
      id: 2,
      firstname: "Test",
      surname: "Manager",
      userRole: UserRole.MANAGER,
    ),
  );

  final Manager manager = Manager(
    id: 2,
    firstname: "Test",
    surname: "Manager",
    staff: [
      Staff(
        id: 1,
        firstname: "Dom",
        surname: "Needham",
        skills: [],
        manager: User(
          id: 2,
          firstname: "Test",
          surname: "Manager",
          userRole: UserRole.MANAGER,
        ),
      ),
    ],
  );

  Future<Staff> getStaffById(int id) async {
    final res = await staffProvider.getStaffById(id);

    return res.body!;
  }

  Future<Manager> getManagerById(int id) async {
    final res = await managerProvider.getManagerById(id);

    return res.body!;
  }

  Future<List<Staff>> searchStaffByName(String searchText) async {
    if (searchText.isEmpty) {
      return List.empty();
    }
    final res = await staffProvider.searchStaffByName(searchText);
    return res.body!;
  }

  Future<List<Manager>> searchManagerByName(String searchText) async {
    if (searchText.isEmpty) {
      return List.empty();
    }
    final res = await managerProvider.searchManagerByName(searchText);
    return res.body!;
  }
}
