import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/staff_skill_overview_controller.dart';

class StaffSkillOverviewExpiry extends GetView<StaffSkillOverviewController> {
  const StaffSkillOverviewExpiry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListTile(
        title: Text(
          controller.formatDate(controller.expires.value),
          style: const TextStyle(fontSize: 18),
        ),
        trailing: IconButton(
          onPressed: () async => controller.datePicker(),
          icon: const Icon(Icons.calendar_today),
        ),
      );
    });
  }
}
