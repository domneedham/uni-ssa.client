import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/services/user_service.dart';

class ManagerOverviewController extends GetxController {
  final userService = Get.find<UserService>();

  final parameters = Get.parameters;
  final arguments = Get.arguments;

  final isLoading = true.obs;
  final isError = false.obs;
  final error = ''.obs;

  Rx<Manager>? manager;

  @override
  void onInit() async {
    super.onInit();
    await getUser(parameters['id']!);
  }

  Future<void> getUser(String id) async {
    try {
      isLoading.value = true;
      final int parsedId = int.parse(id);
      final Manager fetchedManager = await userService.getManagerById(parsedId);
      manager = fetchedManager.obs;
    } catch (e) {
      isError.value = true;
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<Staff>? getStaffById(int id) async {
    final Staff fetchedStaff = await userService.getStaffById(id);
    return fetchedStaff;
  }
}
