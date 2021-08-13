import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/models/user/user.dart';
import 'package:ssa_app/app/data/models/enums/user_role.dart';
import 'package:ssa_app/app/data/providers/auth_provider.dart';
import 'package:ssa_app/app/data/providers/manager_provider.dart';
import 'package:ssa_app/app/data/providers/staff_provider.dart';
import 'package:ssa_app/app/exceptions/failed_to_login.dart';

class UserRepository {
  static UserRepository get to => Get.find<UserRepository>();

  UserRepository({
    required this.staffProvider,
    required this.managerProvider,
    required this.authProvider,
  });
  final IStaffProvider staffProvider;
  final IManagerProvider managerProvider;
  final IAuthProvider authProvider;

  Staff? _staff;
  Manager? _manager;
  final loggedIn = false.obs;
  User? get user {
    if (_staff != null) {
      return _staff;
    } else if (_manager != null) {
      return _manager;
    } else {
      return null;
    }
  }

  Future<User> login(String email, String password) async {
    final res = await authProvider.login(email, password);

    if (res.body == UserRole.STAFF) {
      final staffRes = await staffProvider.getStaffByEmail(email);
      _staff = staffRes.body!;
      loggedIn.value = true;
      return staffRes.body!;
    } else if (res.body == UserRole.MANAGER) {
      final managerRes = await managerProvider.getManagerByEmail(email);
      _manager = managerRes.body!;
      loggedIn.value = true;
      return managerRes.body!;
    } else {
      throw FailedToLoginException("No role for user");
    }
  }

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

  Future<Staff> updateStaffDetails(Staff s) async {
    try {
      await staffProvider.updateDetails(s);
      return s;
    } catch (e) {
      throw e;
    }
  }
}
