import 'dart:convert';

import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/exceptions/failed_to_update.dart';
import 'package:ssa_app/app/exceptions/no_data_found.dart';
import 'package:ssa_app/app/ui/utils/http.dart';

abstract class IStaffProvider {
  Future<Staff> getStaffById(int id);
  Future<List<Staff>> searchStaffByName(String name);
  Future<Staff> updateDetails(Staff staff);
  Future<Staff> getStaffByEmail(String email);
}

class StaffProvider extends GetConnect implements IStaffProvider {
  @override
  void onInit() {
    httpClient.baseUrl = "${SsaHttp.baseUrl}/staff";
    httpClient.addRequestModifier(SsaHttp.addRequestModifier);
    httpClient.addAuthenticator(SsaHttp.addAuthenticator);
    httpClient.maxAuthRetries = 3;
  }

  Staff _decodeStaff(Map<String, dynamic> val) {
    return Staff.fromJson(
      userDetails: val["userDetails"] as Map<String, dynamic>,
      managerDetails: val["managerDetails"] as Map<String, dynamic>,
      skills: val["skills"] as List<dynamic>,
    );
  }

  List<Staff> _decodeStaffList(List<dynamic> val) {
    return List<Staff>.from(
      (val).map(
        (x) => Staff.fromJson(
            userDetails: x["userDetails"],
            managerDetails: x["managerDetails"],
            skills: x["skills"]),
      ),
    );
  }

  String _encodeStaff(Staff staff) {
    return jsonEncode({
      "id": staff.id,
      "userDetails": {"firstname": staff.firstname, "surname": staff.surname}
    });
  }

  @override
  Future<Staff> getStaffById(int id) async {
    final res = await get('/$id');

    if (res.hasError || res.body == null) {
      throw NoDataReturned("Staff not found with that id");
    }

    return _decodeStaff(res.body);
  }

  @override
  Future<List<Staff>> searchStaffByName(String name) async {
    final res = await get('/search/$name');

    if (res.hasError || res.body == null) {
      throw NoDataReturned("Staff not found with that id");
    }

    return _decodeStaffList(res.body);
  }

  @override
  Future<Staff> updateDetails(Staff staff) async {
    final encodedStaff = _encodeStaff(staff);
    final res = await put('/update', encodedStaff);

    if (res.hasError) {
      throw FailedToUpdateUserException("Unable to update user");
    }

    return staff;
  }

  @override
  Future<Staff> getStaffByEmail(String email) async {
    final res = await get('/email/$email');

    if (res.hasError || res.body == null) {
      throw NoDataReturned("Staff not found with that id");
    }

    return _decodeStaff(res.body);
  }
}
