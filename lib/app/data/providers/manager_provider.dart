import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/exceptions/no_data_found.dart';
import 'package:ssa_app/app/ui/utils/http.dart';

abstract class IManagerProvider {
  Future<Manager> getManagerById(int id);
  Future<List<Manager>> searchManagerByName(String name);

  Future<Manager> getManagerByEmail(String email);
}

class ManagerProvider extends GetConnect implements IManagerProvider {
  @override
  void onInit() {
    httpClient.baseUrl = '$baseUrl/manager';
    httpClient.addRequestModifier(addRequestModifier);
    httpClient.addAuthenticator(addAuthenticator);
    httpClient.maxAuthRetries = 3;
  }

  Manager _decodeManager(Map<String, dynamic> val) {
    return Manager.fromJson(
      userDetails: val['userDetails'] as Map<String, dynamic>,
      staff: val['staffDetails'],
    );
  }

  List<Manager> _decodeManagerList(List<dynamic> val) {
    return List<Manager>.from(val.map(
      (x) => Manager.fromJson(
        userDetails: x['userDetails'],
        staff: x['staffDetails'],
      ),
    ));
  }

  @override
  Future<Manager> getManagerById(int id) async {
    final res = await get('/$id');

    if (res.hasError || res.body == null) {
      throw NoDataReturned('Manager not found');
    }

    return _decodeManager(res.body);
  }

  @override
  Future<List<Manager>> searchManagerByName(String name) async {
    final res = await get('/search/$name');
    print(res.body);

    if (res.hasError || res.body == null) {
      throw NoDataReturned('No mangers found');
    }

    return _decodeManagerList(res.body);
  }

  @override
  Future<Manager> getManagerByEmail(String email) async {
    final res = await get('/email/$email');

    if (res.hasError || res.body == null) {
      throw NoDataReturned('Manager not found');
    }

    return _decodeManager(res.body);
  }
}
