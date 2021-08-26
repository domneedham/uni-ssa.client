import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/models/user/user.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';
import 'package:ssa_app/app/data/services/box_service.dart';
import 'package:ssa_app/app/exceptions/failed_to_login.dart';

class UserService {
  UserService({
    required this.boxService,
    required this.userRepository,
  });

  final BoxService boxService;
  final UserRepository userRepository;

  final box = GetStorage();

  static UserService get to => Get.find();

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

  Future<Staff> _loginStaff(String email) async {
    final staffRes = await userRepository.loginStaff(email);
    _staff = staffRes;
    loggedIn.value = true;
    firstLaunch.value = true;
    return staffRes;
  }

  Future<Manager> _loginManager(String email) async {
    final managerRes = await userRepository.loginManager(email);
    _manager = managerRes;
    loggedIn.value = true;
    firstLaunch.value = true;
    return managerRes;
  }

  Future<User> _login(String? role, String email) async {
    User user;

    if (role == 'STAFF') {
      user = await _loginStaff(email);
    } else if (role == 'MANAGER') {
      user = await _loginManager(email);
    } else {
      boxService.clearAll();
      throw FailedToLoginException('Not a recognised user');
    }

    loggedIn.value = true;
    firstLaunch.value = true;

    return user;
  }

  Future<User> loginEmailPassword(String email, String password) async {
    final res = await userRepository.loginEmailPassword(email, password);

    if (res['access_token'] != null &&
        res['refresh_token'] != null &&
        res['role'] != null) {
      boxService.writeAuthTokens(res['access_token'], res['refresh_token']);
      boxService.writeUserDetails(res['role'], email);
    }

    return _login(res['role'], email);
  }

  Future<User?> initLogin() async {
    final role = box.read(BoxService.USER_ROLE);
    final email = box.read(BoxService.USER_EMAIL);

    if (role == null || email == null) {
      return null;
    }

    return _login(role, email);
  }

  void logout() {
    boxService.clearAll();

    _staff = null;
    _manager = null;

    loggedIn.value = false;
  }

  Future<Staff> getStaffById(int id) {
    return userRepository.getStaffById(id);
  }

  Future<Manager> getManagerById(int id) async {
    final res = await userRepository.getManagerById(id);

    return res;
  }

  Future<List<Staff>> searchStaffByName(String searchText) async {
    if (searchText.isEmpty) {
      return List.empty();
    }
    return userRepository.searchStaffByName(searchText);
  }

  Future<List<Manager>> searchManagerByName(String searchText) async {
    if (searchText.isEmpty) {
      return List.empty();
    }
    final res = await userRepository.searchManagerByName(searchText);
    return res;
  }

  Future<Staff> updateStaffDetails(Staff s) async {
    try {
      await userRepository.updateStaffDetails(s);
      _staff = s;
      return s;
    } catch (e) {
      rethrow;
    }
  }
}
