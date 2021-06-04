import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/repository/skill_staff_repository.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';

class HomeStaffController extends GetxController {
  final UserRepository userRepo = Get.find<UserRepository>();
  final SkillRepository skillRepo = Get.find<SkillRepository>();

  Staff get user => userRepo.staff;

  Future<Map<Category, List<StaffSkill>>> get skills async {
    // get a list of all of the users skills
    // List<StaffSkill> tempList = [];
    final tempList = await skillRepo.getSkillsByIds(user.skills);
    // user.skills.forEach((element) {
    //   final skill = skillRepo.getStaffSkillById(element);
    //   if (skill != null) {
    //     tempList.add(skill);
    //   }
    // });

    // get unique categories from skills
    List<Category> cats = [];
    tempList.forEach((element) {
      final index = cats.indexWhere((cat) => cat.name == element.category.name);
      if (index == -1) {
        cats.add(element.category);
      }
    });

    // sort alphabetically on the categories
    cats.sort((a, b) => a.name[0].compareTo(b.name[0]));

    // for each category, get the skills and insert into the map
    Map<Category, List<StaffSkill>> list = {};
    cats.forEach((cat) {
      final items = tempList
          .where((element) => element.category.name == cat.name)
          .toList();
      Map<Category, List<StaffSkill>> item = {cat: items};
      list.addAll(item);
    });

    return list;
  }
}
