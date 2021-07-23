import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/repository/skill_staff_repository.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';
import 'package:ssa_app/app/ui/utils/dates.dart';

class StaffSkillTabController extends GetxController {
  final UserRepository userRepo = Get.find<UserRepository>();
  final SkillStaffRepository skillRepo = Get.find<SkillStaffRepository>();

  Staff get user => userRepo.staff;

  final isLoading = true.obs;
  final isError = false.obs;
  final error = "".obs;

  RxMap<Category, List<StaffSkill>>? skills;

  @override
  void onInit() async {
    super.onInit();
    await getSkills();
  }

  Future<void> getSkills() async {
    try {
      isLoading.value = true;

      // get a list of all of the users skills
      final tempList = await skillRepo.getSkillsByIds(user.skills);

      if (tempList.isEmpty) {
        Map<Category, List<StaffSkill>> emptyMap = {};
        skills = emptyMap.obs;
        isLoading.value = false;
        return;
      }

      // get unique categories from skills
      List<Category> cats = [];
      tempList.forEach((element) {
        final index =
            cats.indexWhere((cat) => cat.name == element.category.name);
        if (index == -1) {
          cats.add(element.category);
        }
      });

      if (cats.isNotEmpty) {
        // sort alphabetically on the categories
        cats.sort((a, b) => a.name[0].compareTo(b.name[0]));
      }

      // for each category, get the skills and insert into the map
      Map<Category, List<StaffSkill>> list = {};
      cats.forEach((cat) {
        final items = tempList
            .where((element) => element.category.name == cat.name)
            .toList();
        if (items.isNotEmpty) {
          Map<Category, List<StaffSkill>> item = {cat: items};
          list.addAll(item);
        }
      });

      skills = list.obs;
    } catch (e) {
      isError.value = true;
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) {
      return "No Expiry";
    } else {
      return Dates.formatUI(date);
    }
  }
}
