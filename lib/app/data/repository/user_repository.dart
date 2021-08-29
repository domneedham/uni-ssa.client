import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/providers/auth_provider.dart';
import 'package:ssa_app/app/data/providers/manager_provider.dart';
import 'package:ssa_app/app/data/providers/staff_provider.dart';

abstract class IUserRepository {
  Future<Staff> loginStaff(String email);
  Future<Manager> loginManager(String email);
  Future<Map<String, String>> loginEmailPassword(String email, String password);
  Future<Staff> getStaffById(int id);
  Future<Manager> getManagerById(int id);
  Future<List<Staff>> searchStaffByName(String name);
  Future<List<Manager>> searchManagerByName(String name);
  Future<Staff> updateStaffDetails(Staff staff);
}

class UserRepository implements IUserRepository {
  UserRepository({
    required this.staffProvider,
    required this.managerProvider,
    required this.authProvider,
  });

  final IStaffProvider staffProvider;
  final IManagerProvider managerProvider;
  final IAuthProvider authProvider;

  static IUserRepository get to => Get.find();

  @override
  Future<Staff> loginStaff(String email) async {
    return staffProvider.getStaffByEmail(email);
  }

  @override
  Future<Manager> loginManager(String email) async {
    return managerProvider.getManagerByEmail(email);
  }

  @override
  Future<Map<String, String>> loginEmailPassword(
      String email, String password) {
    return authProvider.login(email, password);
  }

  @override
  Future<Staff> getStaffById(int id) {
    return staffProvider.getStaffById(id);
  }

  @override
  Future<Manager> getManagerById(int id) async {
    return managerProvider.getManagerById(id);
  }

  @override
  Future<List<Staff>> searchStaffByName(String name) async {
    return staffProvider.searchStaffByName(name);
  }

  @override
  Future<List<Manager>> searchManagerByName(String name) async {
    return managerProvider.searchManagerByName(name);
  }

  @override
  Future<Staff> updateStaffDetails(Staff s) async {
    return staffProvider.updateDetails(s);
  }
}
