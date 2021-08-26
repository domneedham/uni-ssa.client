import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/providers/auth_provider.dart';
import 'package:ssa_app/app/data/providers/manager_provider.dart';
import 'package:ssa_app/app/data/providers/staff_provider.dart';

class UserRepository {
  UserRepository({
    required this.staffProvider,
    required this.managerProvider,
    required this.authProvider,
  });

  final IStaffProvider staffProvider;
  final IManagerProvider managerProvider;
  final IAuthProvider authProvider;

  static UserRepository get to => Get.find();

  Future<Staff> loginStaff(String email) async {
    return staffProvider.getStaffByEmail(email);
  }

  Future<Manager> loginManager(String email) async {
    return managerProvider.getManagerByEmail(email);
  }

  Future<Map<String, String>> loginEmailPassword(
      String email, String password) {
    return authProvider.login(email, password);
  }

  Future<Staff> getStaffById(int id) {
    return staffProvider.getStaffById(id);
  }

  Future<Manager> getManagerById(int id) async {
    return managerProvider.getManagerById(id);
  }

  Future<List<Staff>> searchStaffByName(String searchText) async {
    return staffProvider.searchStaffByName(searchText);
  }

  Future<List<Manager>> searchManagerByName(String searchText) async {
    return managerProvider.searchManagerByName(searchText);
  }

  Future<Staff> updateStaffDetails(Staff s) async {
    return staffProvider.updateDetails(s);
  }
}
