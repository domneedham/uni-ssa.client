import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_skill_tab_controller.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/data/services/manager_staff_skill_service.dart';
import 'package:ssa_app/app/data/services/skill_service.dart';
import 'package:ssa_app/app/data/services/user_service.dart';
import 'package:ssa_app/app/routes/app_pages.dart';

class ManagerSkillOverviewController extends GetxController {
  static ManagerSkillOverviewController get to => Get.find();

  final managerStaffSkillService = Get.find<ManagerStaffSkillService>();
  final skillService = Get.find<SkillService>();
  final userService = Get.find<UserService>();

  final isLoading = true.obs;
  final isError = false.obs;
  final error = ''.obs;
  Rx<ManagerStaffSkill>? skill;

  final _skillName = 'Skill Overview'.obs;
  String get skillName => _skillName.value;

  final parameters = Get.parameters;

  @override
  void onInit() async {
    super.onInit();
    if (parameters['name'] != null) {
      _skillName.value = parameters['name']!;
    }
    await getSkill(parameters['id']!);
  }

  @override
  void onClose() async {
    super.onClose();
    ManagerSkillTabController.to.refresh();
  }

  Future<void> getSkill(String id) async {
    try {
      isLoading.value = true;
      final int parsedId = int.parse(id);
      final ManagerStaffSkill fetchedSkill =
          await managerStaffSkillService.getManagerStaffSkillById(parsedId);
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
      Get.snackbar('Edit!', 'Skill is empty');
    } else {
      final parameters = {'mode': 'edit'};
      final arguments = {'skill': skill!.value};
      Get.toNamed(Routes.MANAGER_SKILL_FORM,
          parameters: parameters, arguments: arguments);
    }
  }

  Future<void> deleteSkill() async {
    try {
      await skillService.delete(skill!.value.id);
      Get.back();
    } catch (e) {
      Get.snackbar('Delete failed', e.toString());
    }
  }

  @override
  Future<void> refresh() async {
    await getSkill(skill!.value.id.toString());
    _skillName.value = skill!.value.name;
  }
}
