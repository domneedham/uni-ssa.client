import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/exceptions/no_data_found.dart';
import 'package:ssa_app/app/ui/utils/http.dart';

abstract class IManagerStaffSkillProvider {
  Future<ManagerStaffSkill> getById(int id);
  Future<List<ManagerStaffSkill>> getAll();
}

class ManagerStaffSkillProvider extends GetConnect
    implements IManagerStaffSkillProvider {
  @override
  void onInit() {
    httpClient.baseUrl = '$baseUrl/skill/manager';
    httpClient.addRequestModifier(addRequestModifier);
    httpClient.addAuthenticator(addAuthenticator);
    httpClient.maxAuthRetries = 3;
  }

  ManagerStaffSkill _decodeSkillManager(Map<String, dynamic> val) {
    return ManagerStaffSkill.fromJson(
      skill: val['skill'] as Map<String, dynamic>,
      staff: val['staffDetails'] as List<dynamic>,
    );
  }

  List<ManagerStaffSkill> _decodeSkillManagerList(List<dynamic> val) {
    return List<ManagerStaffSkill>.from(
      val.map(
        (x) => ManagerStaffSkill.fromJson(
          skill: x['skill'] as Map<String, dynamic>,
          staff: x['staffDetails'] as List<dynamic>,
        ),
      ),
    );
  }

  @override
  Future<List<ManagerStaffSkill>> getAll() async {
    final res = await get('/');

    if (res.hasError || res.body == null) {
      throw NoDataReturned('No skills not found');
    }

    return _decodeSkillManagerList(res.body);
  }

  @override
  Future<ManagerStaffSkill> getById(int id) async {
    final res = await get('/$id');

    if (res.hasError || res.body == null) {
      throw NoDataReturned('Skill not found');
    }

    return _decodeSkillManager(res.body);
  }
}
