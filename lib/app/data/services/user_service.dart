import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/models/user/user.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';
import 'package:ssa_app/app/data/services/box_service.dart';
import 'package:ssa_app/app/exceptions/failed_to_login.dart';

/// Service for interacting with the [UserRepository]. Also keeps track of the
/// current logged in user.
class UserService {
  UserService({
    required this.boxService,
    required this.userRepository,
  });

  final BoxService boxService;
  final IUserRepository userRepository;

  final box = GetStorage();

  static UserService get to => Get.find();

  Staff? _staff;
  Manager? _manager;

  /// If the app has had its initial launch. Should not be reset after being
  /// set to true.
  final firstLaunch = false.obs;

  /// If the user is currently logged in.
  final loggedIn = false.obs;

  /// Returns the current user of the application in the [User] subclass. The
  /// returned value may be from a manager or staff member, depending on who
  /// is logged in. The return may also be null if no one is logged in.
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

  /// Login the user via email and password. Sets the auth tokens in local
  /// storage if the login was successful.
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

  /// Login the user using their details already stored in local storage.
  Future<User?> initLogin() async {
    final role = box.read(BoxService.USER_ROLE);
    final email = box.read(BoxService.USER_EMAIL);

    if (role == null || email == null) {
      return null;
    }

    return _login(role, email);
  }

  /// Log the user out of the application. Clears all local storage.
  void logout() {
    boxService.clearAll();

    _staff = null;
    _manager = null;

    loggedIn.value = false;
  }

  /// Finds the staff member with the [id] given.
  Future<Staff> getStaffById(int id) {
    return userRepository.getStaffById(id);
  }

  /// Finds the manager with the [id] given.
  Future<Manager> getManagerById(int id) {
    return userRepository.getManagerById(id);
  }

  /// Searches for a staff member by the [name] given. This can be a partial
  /// name and a match will be found.
  Future<List<Staff>> searchStaffByName(String name) async {
    if (name.isEmpty) {
      return List.empty();
    }
    return userRepository.searchStaffByName(name);
  }

  /// Searches for a manager by the [name] given. This can be a partial
  /// name and a match will be found.
  Future<List<Manager>> searchManagerByName(String name) async {
    if (name.isEmpty) {
      return List.empty();
    }
    return userRepository.searchManagerByName(name);
  }

  /// Updates the staff members details. Ensure all updated staff information
  /// is passed to the method in the [staff] class.
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
