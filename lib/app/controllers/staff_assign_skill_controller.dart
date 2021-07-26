import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';
import 'package:ssa_app/app/data/repository/skill_staff_repository.dart';

class StaffAssignSkillController extends GetxController
    with SingleGetTickerProviderMixin {
  TabController? tabController;

  final skillRepo = Get.find<SkillStaffRepository>();

  final isLoading = false.obs;
  final skillList = RxList<Skill>();

  final textController = TextEditingController();
  final searchText = "".obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController!.addListener(_onTabChange);

    textController.addListener(_onTextUpdate);
    debounce(
      searchText,
      (_) => _search(),
      time: Duration(seconds: 1),
    );
  }

  @override
  void onClose() {
    super.onClose();
    if (tabController != null) {
      tabController!.dispose();
    }
    textController.dispose();
  }

  void _onTabChange() {
    textController.clear();
    isLoading.value = false;
  }

  void _onTextUpdate() {
    // if value is unchanged, return
    if (textController.text == searchText.value) {
      return;
    }
    isLoading.value = true;
    searchText.value = textController.text;
  }

  void _search() async {
    isLoading.value = true;

    searchText.value = textController.text;

    // don't search if empty
    if (searchText.value.isEmpty) {
      skillList.clear();
      isLoading.value = false;
      return;
    }

    final tempList = await skillRepo.searchSkillByName(searchText.value);
    skillList.value = tempList;

    isLoading.value = false;
  }

  assignSkill(int id) {}
}
