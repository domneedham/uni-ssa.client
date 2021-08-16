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
  static UserRepository get to => Get.find();

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

  final firstLaunch = false.obs;
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
      _staff = staffRes;
      loggedIn.value = true;
      firstLaunch.value = true;
      return staffRes;
    } else if (res.body == UserRole.MANAGER) {
      final managerRes = await managerProvider.getManagerByEmail(email);
      _manager = managerRes;
      loggedIn.value = true;
      firstLaunch.value = true;
      return managerRes;
    } else {
      throw FailedToLoginException("No role for user");
    }
  }

  void logout() {
    _staff = null;
    _manager = null;

    loggedIn.value = false;
  }

  Future<Staff> getStaffById(int id) {
    return staffProvider.getStaffById(id);
  }

  Future<Manager> getManagerById(int id) async {
    final res = await managerProvider.getManagerById(id);

    return res;
  }

  Future<List<Staff>> searchStaffByName(String searchText) async {
    if (searchText.isEmpty) {
      return List.empty();
    }
    return staffProvider.searchStaffByName(searchText);
  }

  Future<List<Manager>> searchManagerByName(String searchText) async {
    if (searchText.isEmpty) {
      return List.empty();
    }
    final res = await managerProvider.searchManagerByName(searchText);
    return res;
  }

  Future<Staff> updateStaffDetails(Staff s) async {
    try {
      await staffProvider.updateDetails(s);
      _staff = s;
      return s;
    } catch (e) {
      throw e;
    }
  }
}
