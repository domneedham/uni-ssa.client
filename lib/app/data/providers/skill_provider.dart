import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';

abstract class ISkillProvider {
  Future<Response<Skill>> getById(int id);
  Future<Response<List<Skill>>> getAll();
  Future<Response<List<Skill>>> searchByName(String name);
}

class SkillProvider extends GetConnect implements ISkillProvider {
  @override
  void onInit() {
    httpClient.baseUrl = "http://localhost:8080/api/skill";
  }

  Skill _decodeSkill(Map<String, dynamic> val) {
    return Skill.fromJson(val);
  }

  List<Skill> _decodeSkillList(List<dynamic> val) {
    return List<Skill>.from(
      (val).map(
        (x) => Skill.fromJson(x),
      ),
    );
  }

  @override
  Future<Response<List<Skill>>> getAll() {
    return get('/', decoder: (val) => _decodeSkillList(val));
  }

  @override
  Future<Response<Skill>> getById(int id) {
    return get('/$id', decoder: (val) => _decodeSkill(val));
  }

  @override
  Future<Response<List<Skill>>> searchByName(String name) {
    return get('/search/$name', decoder: (val) => _decodeSkillList(val));
  }
}
