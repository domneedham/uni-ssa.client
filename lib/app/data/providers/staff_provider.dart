import 'dart:convert';

import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/exceptions/failed_to_update.dart';
import 'package:ssa_app/app/exceptions/no_data_found.dart';
import 'package:ssa_app/app/ui/utils/http.dart';

abstract class IStaffProvider {
  /// Finds the staff member with the [id] given.
  Future<Staff> getStaffById(int id);

  /// Searches for a staff member by the [name] given. This can be a partial
  /// name and a match will be found.
  Future<List<Staff>> searchStaffByName(String name);

  /// Updates the staff members details. Ensure all updated staff information
  /// is passed to the method in the [staff] class.
  Future<Staff> updateDetails(Staff staff);

  /// Finds the staff member with the [email] given.
  Future<Staff> getStaffByEmail(String email);
}

class StaffProvider extends GetConnect implements IStaffProvider {
  @override
  void onInit() {
    httpClient.baseUrl = '$baseUrl/staff';
    httpClient.addRequestModifier(addRequestModifier);
    httpClient.addAuthenticator(addAuthenticator);
    httpClient.maxAuthRetries = 3;
  }

  Staff _decodeStaff(Map<String, dynamic> val) {
    return Staff.fromJson(
      userDetails: val['userDetails'] as Map<String, dynamic>,
      managerDetails: val['managerDetails'] as Map<String, dynamic>,
      skills: val['skills'] as List<dynamic>,
    );
  }

  List<Staff> _decodeStaffList(List<dynamic> val) {
    return List<Staff>.from(
      val.map(
        (x) => Staff.fromJson(
            userDetails: x['userDetails'],
            managerDetails: x['managerDetails'],
            skills: x['skills']),
      ),
    );
  }

  String _encodeStaff(Staff staff) {
    return jsonEncode({
      'id': staff.id,
      'userDetails': {'firstname': staff.firstname, 'surname': staff.surname}
    });
  }

  @override
  Future<Staff> getStaffById(int id) async {
    final res = await get('/$id');

    if (res.hasError || res.body == null) {
      throw NoDataReturned('Staff not found with that id');
    }

    return _decodeStaff(res.body);
  }

  @override
  Future<List<Staff>> searchStaffByName(String name) async {
    final res = await get('/search/$name');

    if (res.hasError || res.body == null) {
      throw NoDataReturned('Staff not found with that id');
    }

    return _decodeStaffList(res.body);
  }

  @override
  Future<Staff> updateDetails(Staff staff) async {
    final encodedStaff = _encodeStaff(staff);
    final res = await put('/update', encodedStaff);

    if (res.hasError) {
      throw FailedToUpdateUserException('Unable to update user');
    }

    return staff;
  }

  @override
  Future<Staff> getStaffByEmail(String email) async {
    final res = await get('/email/$email');

    if (res.hasError || res.body == null) {
      throw NoDataReturned('Staff not found with that id');
    }

    return _decodeStaff(res.body);
  }
}
