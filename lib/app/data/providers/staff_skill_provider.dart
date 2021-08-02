import 'dart:convert';

import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/exceptions/failed_to_save.dart';
import 'package:ssa_app/app/exceptions/no_data_found.dart';

abstract class IStaffSkillProvider {
  Future<Response<StaffSkill>> getById(int id, int sid);
  Future<Response<List<StaffSkill>>> getAll();
  Future<Response<List<StaffSkill>>> getAllForUser(int id);
  Future<StaffSkill> getByIdDecoded(int id, int sid);

  Future<StaffSkill> saveEdited(StaffSkill skill, int sid);
  Future<StaffSkill> saveNew(StaffSkill skill, int sid);
}

class StaffSkillProvider extends GetConnect implements IStaffSkillProvider {
  @override
  void onInit() {
    httpClient.baseUrl = "http://localhost:8080/api/skill/staff";
  }

  StaffSkill _decodeSkill(Map<String, dynamic>? val) {
    if (val == null) {
      throw NoDataReturned("Skill not found");
    }
    return StaffSkill.fromJson(val);
  }

  List<StaffSkill> _decodeSkillList(List<dynamic> val) {
    return List<StaffSkill>.from(
      (val).map(
        (x) => StaffSkill.fromJson(x),
      ),
    );
  }

  String _encodeSkill(StaffSkill skill, int sid) {
    return jsonEncode({
      "skill": {"id": skill.id},
      "staffDetails": {"id": sid},
      "rating": skill.rating,
      "lastUpdated": skill.lastUpdated.toIso8601String(),
      "expires": skill.expires?.toIso8601String(),
    });
  }

  @override
  Future<Response<List<StaffSkill>>> getAll() {
    return get('/', decoder: (val) => _decodeSkillList(val));
  }

  @override
  Future<Response<StaffSkill>> getById(int id, int sid) {
    return get('/$id/sid/$sid', decoder: (val) => _decodeSkill(val));
  }

  @override
  Future<Response<List<StaffSkill>>> getAllForUser(int id) {
    return get('/sid/$id', decoder: (val) => _decodeSkillList(val));
  }

  @override
  Future<StaffSkill> getByIdDecoded(int id, int sid) async {
    final res = await get('/$id/sid/$sid');
    if (res.hasError || res.body == null) {
      throw NoDataReturned("No skill found");
    }

    return _decodeSkill(res.body);
  }

  @override
  Future<StaffSkill> saveEdited(StaffSkill skill, int sid) async {
    final encodedSkill = _encodeSkill(skill, sid);
    final res = await put('/update', encodedSkill);
    if (res.hasError) {
      throw FailedToSaveException(res.body.toString());
    }

    return skill;
  }

  @override
  Future<StaffSkill> saveNew(StaffSkill skill, int sid) async {
    final encodedSkill = _encodeSkill(skill, sid);
    final res = await post('/assign', encodedSkill);
    if (res.hasError) {
      throw FailedToSaveException(res.body.toString());
    }

    return skill;
  }
}
