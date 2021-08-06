import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/data/repository/manager_staff_skill_repository.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';
import 'package:ssa_app/app/routes/app_pages.dart';

class ManagerSkillOverviewController extends GetxController {
  static ManagerSkillOverviewController get to => Get.find();

  final skillRepo = Get.find<ManagerStaffSkillRepository>();
  final userRepo = Get.find<UserRepository>();

  final isLoading = true.obs;
  final isError = false.obs;
  final error = "".obs;
  Rx<ManagerStaffSkill>? skill;

  final _skillName = "Skill Overview".obs;
  String get skillName => _skillName.value;

  final parameters = Get.parameters;

  @override
  void onInit() async {
    super.onInit();
    if (parameters["name"] != null) {
      _skillName.value = parameters["name"]!;
    }
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

  void deleteSkill() {
    if (skill == null) {
      Get.snackbar("Delete!", "Skill is empty");
    } else {
      Get.snackbar("Delete", "Skill would be deleted now");
    }
  }

  Future<void> refresh() async {
    await getSkill(skill!.value.id.toString());
    _skillName.value = skill!.value.name;
  }
}
