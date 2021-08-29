import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/services/staff_skill_service.dart';
import 'package:ssa_app/app/data/services/user_service.dart';
import 'package:ssa_app/app/routes/app_pages.dart';
import 'package:ssa_app/app/ui/utils/dates.dart';

class StaffSkillTabController extends GetxController {
  final userService = Get.find<UserService>();
  final skillService = Get.find<StaffSkillService>();

  Staff get user => userService.user as Staff;

  final isLoading = true.obs;
  final isError = false.obs;
  final error = ''.obs;

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
      final tempList = await skillService.getAllByUserId(user.id);

      if (tempList.isEmpty) {
        final Map<Category, List<StaffSkill>> emptyMap = {};
        skills = emptyMap.obs;
        isLoading.value = false;
        return;
      }

      // get unique categories from skills
      final List<Category> cats = [];
      for (final element in tempList) {
        final index =
            cats.indexWhere((cat) => cat.name == element.category.name);
        if (index == -1) {
          cats.add(element.category);
        }
      }

      if (cats.isNotEmpty) {
        // sort alphabetically on the categories
        cats.sort((a, b) => a.name[0].compareTo(b.name[0]));
      }

      // for each category, get the skills and insert into the map
      final Map<Category, List<StaffSkill>> list = {};
      for (final cat in cats) {
        final items = tempList
            .where((element) => element.category.name == cat.name)
            .toList();
        if (items.isNotEmpty) {
          final Map<Category, List<StaffSkill>> item = {cat: items};
          list.addAll(item);
        }
      }

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
      return 'No Expiry';
    } else {
      return Dates.formatUI(date);
    }
  }

  void navigateToSkillOverview(StaffSkill skill) {
    final parameters = {
      'id': skill.id.toString(),
      'name': skill.name,
      'edit': 'true',
    };
    Get.toNamed(Routes.STAFF_SKILL_OVERVIEW, parameters: parameters);
  }

  void navigateToAssignSkill() {
    Get.toNamed(Routes.STAFF_ASSIGN_SKILL);
  }
}
