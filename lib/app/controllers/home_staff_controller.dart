import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/staff.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/repository/skill_repository.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';

class HomeStaffController extends GetxController {
  final UserRepository userRepo = Get.find<UserRepository>();
  final SkillRepository skillRepo = Get.find<SkillRepository>();

  Staff get user => userRepo.staff;

  List<StaffSkill> get skills {
    List<StaffSkill> tempList = [];
    user.skills.forEach((element) {
      final skill = skillRepo.getStaffSkillById(element);
      if (skill != null) {
        tempList.add(skill);
      }
    });
    if (tempList.isNotEmpty) {
      // sort alphabetically
      tempList.sort((a, b) => a.category.name[0].compareTo(b.category.name[0]));
    }

    return tempList;
  }
}
