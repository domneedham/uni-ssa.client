import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/staff_skill_tab_controller.dart';
import 'package:ssa_app/app/data/models/skill/skill.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/repository/skill_repository.dart';
import 'package:ssa_app/app/data/repository/staff_skill_repository.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';
import 'package:ssa_app/app/routes/app_route_parameters.dart';
import 'package:ssa_app/app/ui/utils/dates.dart';

class StaffSkillOverviewController extends GetxController {
  final skillRepo = Get.find<SkillRepository>();
  final staffSkillRepo = Get.find<StaffSkillRepository>();
  final userRepo = Get.find<UserRepository>();

  final isLoading = true.obs;
  final isError = false.obs;
  final error = "".obs;

  Rx<StaffSkill>? skill;
  final rating = 0.obs;
  final expires = Rx<DateTime?>(null);
  final isEdited = false.obs;

  final parameters = StaffSkillOverviewParameters.fromMap(Get.parameters);

  @override
  void onInit() async {
    super.onInit();
    if (parameters.edit != AppRouteParameterValues.FALSE) {
      await getStaffSkill(parameters.id);
    }
    if (parameters.assign != AppRouteParameterValues.FALSE) {
      await getSkill(parameters.id);
    }
  }

  Future<void> getStaffSkill(String id) async {
    try {
      isLoading.value = true;
      int parsedId = int.parse(id);
      StaffSkill fetchedSkill = await staffSkillRepo.getSkillById(parsedId);
      skill = fetchedSkill.obs;
      rating.value = fetchedSkill.rating;
      expires.value = fetchedSkill.expires;
    } catch (e) {
      isError.value = true;
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getSkill(String id) async {
    try {
      isLoading.value = true;
      int parsedId = int.parse(id);
      Skill fetchedSkill = await skillRepo.findById(parsedId);
      skill = StaffSkill(
        rating: 0,
        lastUpdated: DateTime.now(),
        id: fetchedSkill.id,
        name: fetchedSkill.name,
        category: fetchedSkill.category,
      ).obs;
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

  Future<void> datePicker() async {
    final firstDate = DateTime.now();
    final initialDate = firstDate;
    // 4 years. Account for leap year
    final lastDate = firstDate.add(Duration(days: (365 * 4) + 1));
    final datePicked = await showDatePicker(
      context: Get.context!,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    expires.value = datePicked;

    setIsEdited(newExpiry: datePicked);
  }

  void incrementRating() {
    int newRating = rating.value + 1;
    if (newRating > 5) newRating = 5;

    rating.value = newRating;
    setIsEdited(newRating: newRating);
  }

  void decrementRating() {
    int newRating = rating.value - 1;
    if (newRating < 0) newRating = 0;

    rating.value = newRating;
    setIsEdited(newRating: newRating);
  }

  void setIsEdited({int? newRating, DateTime? newExpiry}) {
    final initialRating = skill!.value.rating;
    final initialExpiry = skill!.value.expires;
    final currentRating = rating.value;
    final currentExpiry = expires.value;

    bool changed = false;

    if ((newRating != null && newRating != currentRating) ||
        initialRating != currentRating) {
      changed = true;
    } else if ((newExpiry != null && newExpiry != currentExpiry) ||
        initialExpiry != currentExpiry) {
      changed = true;
    }

    isEdited.value = changed;
  }

  Future<void> saveEditedSkill() async {
    if (!isEdited.value) return;

    try {
      final editedSkill = StaffSkill(
        rating: rating.value,
        expires: expires.value,
        lastUpdated: DateTime.now(),
        id: skill!.value.id,
        name: skill!.value.name,
        category: skill!.value.category,
      );

      if (parameters.edit != AppRouteParameterValues.FALSE) {
        await staffSkillRepo.saveEdited(editedSkill);
      }

      if (parameters.assign != AppRouteParameterValues.FALSE) {
        await staffSkillRepo.saveNew(editedSkill);
      }
      Get.snackbar("Success", "Skill saved");
    } catch (e) {
      Get.snackbar("Failed to save", e.toString());
    }
  }

  @override
  void onClose() async {
    // TODO
    // temp fix to deal with UI update on navigating to skill tab
    final skillTabController = Get.find<StaffSkillTabController>();
    await skillTabController.getSkills();
    super.onClose();
  }
}
