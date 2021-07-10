import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import 'package:ssa_app/app/data/repository/skill_staff_repository.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';

class StaffOverviewController extends GetxController {
  final userRepo = Get.find<UserRepository>();
  final skillRepo = Get.find<SkillStaffRepository>();

  final parameters = Get.parameters;
  final arguments = Get.arguments;

  final isLoading = true.obs;
  final isError = false.obs;
  final error = "".obs;

  Rx<Staff>? staff;

  @override
  void onInit() async {
    super.onInit();
    await getUser(parameters["id"]!);
  }

  Future<void> getUser(String id) async {
    try {
      isLoading.value = true;
      int parsedId = int.parse(id);
      Staff fetchedStaff = await userRepo.getStaffById(parsedId);
      staff = fetchedStaff.obs;
    } catch (e) {
      isError.value = true;
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<Manager>? getManagerById(int id) async {
    Manager fetchedManager = await userRepo.getManagerById(id);
    return fetchedManager;
  }

  Future<StaffSkill>? getSkillById(int id) async {
    StaffSkill fetchedSkill = await skillRepo.getSkillByIdAsync(id);
    return fetchedSkill;
  }

  Future<List<StaffSkill>> getSkillsByIds(List<int> ids) async {
    List<StaffSkill> fetchedSkills = await skillRepo.getSkillsByIds(ids);
    return fetchedSkills;
  }

  String expiryText(StaffSkill skill) {
    if (skill.hasExpiry) {
      if (skill.isExpired) {
        return "Expired";
      } else {
        return "Not Expired";
      }
    } else {
      return "No Expiry";
    }
  }

  Text expiryTextWidget(StaffSkill skill) {
    if (skill.hasExpiry) {
      final date = DateFormat.yMMMd().format(skill.expires!);
      if (skill.isExpired) {
        return Text(
          "Expired on: $date",
          style: TextStyle(color: Colors.red),
        );
      } else {
        return Text(
          "Expires on: $date",
          style: TextStyle(color: Colors.green),
        );
      }
    } else {
      return Text("No Expiry");
    }
  }
}
