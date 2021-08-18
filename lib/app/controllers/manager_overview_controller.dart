import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';

class ManagerOverviewController extends GetxController {
  final userRepo = Get.find<UserRepository>();

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
      final Manager fetchedManager = await userRepo.getManagerById(parsedId);
      manager = fetchedManager.obs;
    } catch (e) {
      isError.value = true;
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<Staff>? getStaffById(int id) async {
    final Staff fetchedStaff = await userRepo.getStaffById(id);
    return fetchedStaff;
  }
}
