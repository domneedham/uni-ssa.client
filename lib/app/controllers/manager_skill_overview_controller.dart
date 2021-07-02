import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/repository/skill_manager_repository.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';
import 'package:ssa_app/app/routes/app_pages.dart';

class ManagerSkillOverviewController extends GetxController {
  final skillRepo = Get.find<SkillManagerRepository>();
  final userRepo = Get.find<UserRepository>();

  final isLoading = true.obs;
  final isError = false.obs;
  final error = "".obs;
  Rx<ManagerStaffSkill>? skill;

  final parameters = Get.parameters;

  @override
  void onInit() async {
    super.onInit();
    await getSkill(parameters["id"]!);
  }

  Future<void> getSkill(String id) async {
    try {
      isLoading.value = true;
      int parsedId = int.parse(id);
      ManagerStaffSkill fetchedSkill =
          await skillRepo.getManagerStaffSkillById(parsedId);
      skill = fetchedSkill.obs;
    } catch (e) {
      isError.value = true;
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<Staff> getStaffById(int id) async {
    return userRepo.getStaffById(id);
  }

  void editSkill() {
    if (skill == null) {
      Get.snackbar("Edit!", "Skill is empty");
    } else {
      final parameters = {"mode": "edit"};
      final arguments = {"skill": skill!.value};
      Get.toNamed(Routes.MANAGER_SKILL_FORM,
          parameters: parameters, arguments: arguments);
    }
  }
}
