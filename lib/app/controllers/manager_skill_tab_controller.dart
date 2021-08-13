import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/repository/manager_staff_skill_repository.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';
import 'package:ssa_app/app/routes/app_pages.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_list.dart';

class ManagerSkillTabController extends GetxController {
  static ManagerSkillTabController get to => Get.find();

  final UserRepository userRepo = Get.find<UserRepository>();
  final ManagerStaffSkillRepository skillRepo =
      Get.find<ManagerStaffSkillRepository>();

  Manager get user => userRepo.user as Manager;

  final viewType = SkillListViewType.LIST.obs;

  final isLoading = true.obs;
  final isError = false.obs;
  final error = "".obs;

  RxMap<Category, List<ManagerStaffSkill>>? skills;

  @override
  onInit() async {
    super.onInit();
    await getSkills();
  }

  Future<void> getSkills() async {
    try {
      isLoading.value = true;

      final repoSkills = await skillRepo.skills;

      // get unique categories from skills
      List<Category> cats = [];
      repoSkills.forEach((element) {
        final index =
            cats.indexWhere((cat) => cat.name == element.category.name);
        if (index == -1) {
          cats.add(element.category);
        }
      });

      // sort alphabetically on the categories
      if (cats.isNotEmpty) {
        cats.sort((a, b) => a.name[0].compareTo(b.name[0]));
      }

      // for each category, get the skills and insert into the map
      Map<Category, List<ManagerStaffSkill>> list = {};
      cats.forEach((cat) {
        final items = repoSkills
            .where((element) => element.category.name == cat.name)
            .toList();
        if (items.isNotEmpty) {
          Map<Category, List<ManagerStaffSkill>> item = {cat: items};
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

  void changeViewType(SkillListViewType type) {
    viewType.value = type;
  }

  void navigateToSkillOverview(int id, String name) {
    final parameters = <String, String>{"id": id.toString(), "name": name};
    Get.toNamed(Routes.MANAGER_SKILL_OVERVIEW, parameters: parameters);
  }

  void createNewSkill() {
    final parameters = {"mode": "add"};
    Get.toNamed(Routes.MANAGER_SKILL_FORM, parameters: parameters);
  }

  void refresh() async {
    await getSkills();
  }
}
