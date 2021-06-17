import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/repository/skill_manager_repository.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';
import 'package:ssa_app/app/routes/app_pages.dart';

class ManagerSkillTabController extends GetxController {
  final UserRepository userRepo = Get.find<UserRepository>();
  final SkillManagerRepository skillRepo = Get.find<SkillManagerRepository>();

  Manager get user => userRepo.manager;

  final isLoading = true.obs;
  final isError = false.obs;
  final error = "".obs;

  RxMap<Category, List<ManagerStaffSkill>>? skills;

  final Map<Category, List<ManagerStaffSkill>> list = {
    Category(id: 1, name: "Code", icon: Icons.code): List.filled(
        1,
        (ManagerStaffSkill(
            id: 1,
            name: "Skill",
            category: Category(id: 1, name: "Code", icon: Icons.code),
            staff: [1])))
  };

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

  void navigateToSkillOverview(int id, String name) {
    final parameters = <String, String>{"id": id.toString(), "name": name};
    Get.toNamed(Routes.MANAGER_SKILL_OVERVIEW, parameters: parameters);
  }

  void createNewSkill() {
    Get.snackbar("Add new skill", "Button clicked");
  }
}
