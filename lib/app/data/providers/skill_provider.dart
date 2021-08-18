import 'dart:convert';

import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';
import 'package:ssa_app/app/exceptions/no_data_found.dart';
import 'package:ssa_app/app/ui/utils/http.dart';

abstract class ISkillProvider {
  Future<Skill> getById(int id);
  Future<List<Skill>> getAll();
  Future<List<Skill>> searchByName(String name);
  Future<Skill> create(Skill skill);
  Future<Skill> update(Skill skill);
  Future<void> deleteSkill(int id);
}

class SkillProvider extends GetConnect implements ISkillProvider {
  @override
  void onInit() {
    httpClient.baseUrl = '$baseUrl/skill';
    httpClient.addRequestModifier(addRequestModifier);
    httpClient.addAuthenticator(addAuthenticator);
    httpClient.maxAuthRetries = 3;
  }

  Skill _decodeSkill(Map<String, dynamic> val) {
    return Skill.fromJson(val);
  }

  List<Skill> _decodeSkillList(List<dynamic> val) {
    return List<Skill>.from(
      val.map(
        (x) => Skill.fromJson(x),
      ),
    );
  }

  String _encodeNewSkill(Skill val) {
    return jsonEncode({
      'name': val.name,
      'category': {
        'id': val.category.id,
        'name': val.category.name,
        'icon': val.category.icon.codePoint,
      }
    });
  }

  String _encodeEditSkill(Skill val) {
    return jsonEncode({
      'id': val.id,
      'name': val.name,
      'category': {
        'id': val.category.id,
        'name': val.category.name,
        'icon': val.category.icon.codePoint,
      }
    });
  }

  @override
  Future<List<Skill>> getAll() async {
    final res = await get('/');

    if (res.hasError || res.body == null) {
      throw NoDataReturned('Not skills found');
    }

    return _decodeSkillList(res.body);
  }

  @override
  Future<Skill> getById(int id) async {
    final res = await get('/$id');
    if (res.hasError || res.body == null) {
      throw NoDataReturned('No skill found');
    }
    return _decodeSkill(res.body);
  }

  @override
  Future<List<Skill>> searchByName(String name) async {
    final res = await get('/search/$name');

    if (res.hasError || res.body == null) {
      throw NoDataReturned('Not skills found');
    }

    return _decodeSkillList(res.body);
  }

  @override
  Future<Skill> create(Skill skill) async {
    final encodedSkill = _encodeNewSkill(skill);
    final res = await post('/create', encodedSkill);
    return _decodeSkill(res.body);
  }

  @override
  Future<Skill> update(Skill skill) async {
    final encodedSkill = _encodeEditSkill(skill);
    final res = await put('/update', encodedSkill);
    return _decodeSkill(res.body);
  }

  @override
  Future<void> deleteSkill(int id) async {
    final res = await delete('/delete/$id');
    return res.body;
  }
}
