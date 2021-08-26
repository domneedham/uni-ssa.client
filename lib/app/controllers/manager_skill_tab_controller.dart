import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/services/manager_staff_skill_service.dart';
import 'package:ssa_app/app/data/services/user_service.dart';
import 'package:ssa_app/app/routes/app_pages.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_list.dart';

class ManagerSkillTabController extends GetxController {
  static ManagerSkillTabController get to => Get.find();

  final userService = Get.find<UserService>();
  final skillService = Get.find<ManagerStaffSkillService>();

  Manager get user => userService.user as Manager;

  final viewType = SkillListViewType.LIST.obs;

  final isLoading = true.obs;
  final isError = false.obs;
  final error = ''.obs;

  RxMap<Category, List<ManagerStaffSkill>>? skills;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getSkills();
  }

  Future<void> getSkills() async {
    try {
      isLoading.value = true;

      final repoSkills = await skillService.skills;

      // get unique categories from skills
      final List<Category> cats = [];
      for (final element in repoSkills) {
        final index =
            cats.indexWhere((cat) => cat.name == element.category.name);
        if (index == -1) {
          cats.add(element.category);
        }
      }

      // sort alphabetically on the categories
      if (cats.isNotEmpty) {
        cats.sort((a, b) => a.name[0].compareTo(b.name[0]));
      }

      // for each category, get the skills and insert into the map
      final Map<Category, List<ManagerStaffSkill>> list = {};
      for (final cat in cats) {
        final items = repoSkills
            .where((element) => element.category.name == cat.name)
            .toList();
        if (items.isNotEmpty) {
          final Map<Category, List<ManagerStaffSkill>> item = {cat: items};
          list.addAll(item);
        }
      }

      if (skills != null) {
        skills!.value = list.obs;
      } else {
        skills = list.obs;
      }
    } catch (e) {
      isError.value = true;
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void changeViewType(SkillListViewType type) {
    viewType.value = type;
  }

  void navigateToSkillOverview(int id, String name) {
    final parameters = <String, String>{'id': id.toString(), 'name': name};
    Get.toNamed(Routes.MANAGER_SKILL_OVERVIEW, parameters: parameters);
  }

  void createNewSkill() {
    final parameters = {'mode': 'add'};
    Get.toNamed(Routes.MANAGER_SKILL_FORM, parameters: parameters);
  }

  @override
  Future<void> refresh() async {
    await getSkills();
  }
}
