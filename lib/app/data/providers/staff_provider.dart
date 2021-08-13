import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/exceptions/failed_to_update.dart';

abstract class IStaffProvider {
  Future<Response<Staff>> getStaffById(int id);
  Future<Response<List<Staff>>> searchStaffByName(String name);

  Future<Staff> updateDetails(Staff staff);

  Future<Response<Staff>> getStaffByEmail(String email);
}

class StaffProvider extends GetConnect implements IStaffProvider {
  Map<String, String> get headers {
    final token = GetStorage().read('access_token');
    return {'Authorization': "Bearer $token"};
  }

  @override
  void onInit() {
    httpClient.baseUrl = "http://localhost:8080/api/staff";
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
  Future<Response<Staff>> getStaffById(int id) {
    return get('/$id', decoder: (val) => _decodeStaff(val));
  }

  @override
  Future<Response<List<Staff>>> searchStaffByName(String name) {
    return get('/search/$name', decoder: (val) => _decodeStaffList(val));
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
  Future<Response<Staff>> getStaffByEmail(String email) async {
    return get(
      '/email/$email',
      decoder: (val) => _decodeStaff(val),
      headers: headers,
    );
  }
}
