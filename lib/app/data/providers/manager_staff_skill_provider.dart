import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';

abstract class IManagerStaffSkillProvider {
  Future<Response<ManagerStaffSkill>> getById(int id);
  Future<Response<List<ManagerStaffSkill>>> getAll();
}

class ManagerStaffSkillProvider extends GetConnect
    implements IManagerStaffSkillProvider {
  @override
  void onInit() {
    httpClient.baseUrl = "http://localhost:8080/api/skill/manager";
  }

  ManagerStaffSkill _decodeSkillManager(Map<String, dynamic> val) {
    return ManagerStaffSkill.fromJson(
      skill: val["skill"] as Map<String, dynamic>,
      staff: val["staffDetails"] as List<dynamic>,
    );
  }

  List<ManagerStaffSkill> _decodeSkillManagerList(List<dynamic> val) {
    return List<ManagerStaffSkill>.from(
      (val).map(
        (x) => ManagerStaffSkill.fromJson(
          skill: x["skill"] as Map<String, dynamic>,
          staff: x["staffDetails"] as List<dynamic>,
        ),
      ),
    );
  }

  @override
  Future<Response<List<ManagerStaffSkill>>> getAll() {
    return get('/', decoder: (val) => _decodeSkillManagerList(val));
  }

  @override
  Future<Response<ManagerStaffSkill>> getById(int id) {
    return get('/$id', decoder: (val) => _decodeSkillManager(val));
  }
}
