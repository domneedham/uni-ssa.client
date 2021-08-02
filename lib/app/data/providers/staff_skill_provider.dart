import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';

abstract class IStaffSkillProvider {
  Future<Response<StaffSkill>> getById(int id);
  Future<Response<List<StaffSkill>>> getAll();
  Future<Response<List<StaffSkill>>> getAllForUser(int id);
}

class StaffSkillProvider extends GetConnect implements IStaffSkillProvider {
  @override
  void onInit() {
    httpClient.baseUrl = "http://localhost:8080/api/skill/staff";
  }

  StaffSkill _decodeSkill(Map<String, dynamic> val) {
    return StaffSkill.fromJson(val);
  }

  List<StaffSkill> _decodeSkillList(List<dynamic> val) {
    return List<StaffSkill>.from(
      (val).map(
        (x) => StaffSkill.fromJson(x),
      ),
    );
  }

  @override
  Future<Response<List<StaffSkill>>> getAll() {
    return get('/', decoder: (val) => _decodeSkillList(val));
  }

  @override
  Future<Response<StaffSkill>> getById(int id) {
    return get('/$id', decoder: (val) => _decodeSkill(val));
  }

  @override
  Future<Response<List<StaffSkill>>> getAllForUser(int id) {
    return get('/sid/$id', decoder: (val) => _decodeSkillList(val));
  }
}
