import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';

abstract class IManagerProvider {
  Future<Response<Manager>> getManagerById(int id);
  Future<Response<List<Manager>>> searchManagerByName(String name);

  Future<Response<Manager>> getManagerByEmail(String email);
}

class ManagerProvider extends GetConnect implements IManagerProvider {
  @override
  void onInit() {
    httpClient.baseUrl = "http://localhost:8080/api/manager";
  }

  Manager _decodeManager(Map<String, dynamic> val) {
    return Manager.fromJson(
      userDetails: val["userDetails"] as Map<String, dynamic>,
      staff: val["staffDetails"],
    );
  }

  List<Manager> _decodeManagerList(List<dynamic> val) {
    return List<Manager>.from((val).map(
      (x) => Manager.fromJson(
        userDetails: x["userDetails"],
        staff: x["staffDetails"],
      ),
    ));
  }

  @override
  Future<Response<Manager>> getManagerById(int id) {
    return get('/$id', decoder: (val) => _decodeManager(val));
  }

  @override
  Future<Response<List<Manager>>> searchManagerByName(String name) {
    return get('/search/$name', decoder: (val) => _decodeManagerList(val));
  }

  @override
  Future<Response<Manager>> getManagerByEmail(String email) {
    return get('/email/$email', decoder: (val) => _decodeManager(val));
  }
}
