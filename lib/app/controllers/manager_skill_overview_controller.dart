import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/repository/skill_manager_repository.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';

class ManagerSkillOverviewController extends GetxController {
  final skillRepo = Get.find<SkillManagerRepository>();
  final userRepo = Get.find<UserRepository>();

  var parameters = Get.parameters;

  Future<ManagerStaffSkill> getSkill() async {
    try {
      int id = int.parse(parameters["id"]!);
      ManagerStaffSkill fetchedSkill =
          await skillRepo.getManagerStaffSkillById(id);
      // skill.value = fetchedSkill;
      return fetchedSkill;
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<Staff> getStaffById(int id) async {
    return userRepo.getStaffById(id);
  }
}
