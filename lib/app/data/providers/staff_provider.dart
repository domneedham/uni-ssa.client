import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';

abstract class IStaffProvider {
  Future<Response> getStaffById(int id);
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

  @override
  Future<Response<Staff>> getStaffById(int id) {
    return get('/$id', decoder: (val) => _decodeStaff(val));
  }
}
