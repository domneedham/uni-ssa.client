import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/repository/skill_manager_repository.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';

class ManagerSkillOverviewController extends GetxController {
  final skillRepo = Get.find<SkillManagerRepository>();
  final userRepo = Get.find<UserRepository>();

  var parameters = Get.parameters;

  late Rx<ManagerStaffSkill>? skill;

  Future<ManagerStaffSkill> getSkill() async {
    try {
      int id = int.parse(parameters["id"]!);
      ManagerStaffSkill fetchedSkill =
          await skillRepo.getManagerStaffSkillById(id);
      skill = fetchedSkill.obs;
      return fetchedSkill;
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<Staff> getStaffById(int id) async {
    return userRepo.getStaffById(id);
  }

  void editSkill() {
    if (skill == null) {
      Get.snackbar("Edit!", "Skill is empty");
    } else {
      Get.snackbar("Edit!", "Skill is ${skill!.value.name}");
    }
  }
}
