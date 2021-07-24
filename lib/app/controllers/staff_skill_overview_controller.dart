import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/repository/skill_staff_repository.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';
import 'package:ssa_app/app/ui/utils/dates.dart';

class StaffSkillOverviewController extends GetxController {
  final skillRepo = Get.find<SkillStaffRepository>();
  final userRepo = Get.find<UserRepository>();

  final isLoading = true.obs;
  final isError = false.obs;
  final error = "".obs;

  Rx<StaffSkill>? skill;
  final rating = 0.0.obs;
  final expires = Rx<DateTime?>(null);
  final isEdited = false.obs;

  final parameters = Get.parameters;

  @override
  void onInit() async {
    super.onInit();
    await getSkill(parameters["id"]!);
  }

  Future<void> getSkill(String id) async {
    try {
      isLoading.value = true;
      int parsedId = int.parse(id);
      StaffSkill fetchedSkill = await skillRepo.getSkillById(parsedId);
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
    double newRating = rating.value + 1;
    if (newRating > 5) newRating = 5;

    rating.value = newRating;
    setIsEdited(newRating: newRating);
  }

  void decrementRating() {
    double newRating = rating.value - 1;
    if (newRating < 0) newRating = 0;

    rating.value = newRating;
    setIsEdited(newRating: newRating);
  }

  void setIsEdited({double? newRating, DateTime? newExpiry}) {
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
  }
}
