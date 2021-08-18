import 'dart:convert';

import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/exceptions/failed_to_save.dart';
import 'package:ssa_app/app/exceptions/no_data_found.dart';
import 'package:ssa_app/app/ui/utils/http.dart';

abstract class IStaffSkillProvider {
  Future<StaffSkill> getById(int id, int sid);
  Future<List<StaffSkill>> getAll();
  Future<List<StaffSkill>> getAllForUser(int id);
  Future<StaffSkill> getByIdDecoded(int id, int sid);

  Future<StaffSkill> saveEdited(StaffSkill skill, int sid);
  Future<StaffSkill> saveNew(StaffSkill skill, int sid);
}

class StaffSkillProvider extends GetConnect implements IStaffSkillProvider {
  @override
  void onInit() {
    httpClient.baseUrl = '$baseUrl/skill/staff';
    httpClient.addRequestModifier(addRequestModifier);
    httpClient.addAuthenticator(addAuthenticator);
    httpClient.maxAuthRetries = 3;
  }

  StaffSkill _decodeSkill(Map<String, dynamic>? val) {
    if (val == null) {
      throw NoDataReturned('Skill not found');
    }
    return StaffSkill.fromJson(val);
  }

  List<StaffSkill> _decodeSkillList(List<dynamic> val) {
    return List<StaffSkill>.from(
      val.map(
        (x) => StaffSkill.fromJson(x),
      ),
    );
  }

  String _encodeSkill(StaffSkill skill, int sid) {
    return jsonEncode({
      'skill': {'id': skill.id},
      'staffDetails': {'id': sid},
      'rating': skill.rating,
      'lastUpdated': skill.lastUpdated.toIso8601String(),
      'expires': skill.expires?.toIso8601String(),
    });
  }

  @override
  Future<List<StaffSkill>> getAll() async {
    final res = await get('/');

    if (res.hasError || res.body == null) {
      throw NoDataReturned('No skill found');
    }

    return _decodeSkillList(res.body);
  }

  @override
  Future<StaffSkill> getById(int id, int sid) async {
    final res = await get('/$id/sid/$sid');
    if (res.hasError || res.body == null) {
      throw NoDataReturned('No skill found');
    }

    return _decodeSkill(res.body);
  }

  @override
  Future<List<StaffSkill>> getAllForUser(int id) async {
    final res = await get('/sid/$id');

    if (res.hasError || res.body == null) {
      throw NoDataReturned('Skills not found');
    }

    return _decodeSkillList(res.body);
  }

  @override
  Future<StaffSkill> getByIdDecoded(int id, int sid) async {
    final res = await get('/$id/sid/$sid');
    if (res.hasError || res.body == null) {
      throw NoDataReturned('No skill found');
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
