import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';

abstract class IStaffProvider {
  Future<Response<Staff>> getStaffById(int id);
  Future<Response<List<Staff>>> searchStaffByName(String name);
}

class StaffProvider extends GetConnect implements IStaffProvider {
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

  @override
  Future<Response<Staff>> getStaffById(int id) {
    return get('/$id', decoder: (val) => _decodeStaff(val));
  }

  @override
  Future<Response<List<Staff>>> searchStaffByName(String name) {
    return get('/search/$name', decoder: (val) => _decodeStaffList(val));
  }
}
