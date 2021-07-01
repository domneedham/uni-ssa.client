import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_skill_form_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/future_state_text.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_form_page/manager_skill_form.dart';

class ManagerSkillFormPage extends GetWidget<ManagerSkillFormController> {
  const ManagerSkillFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Skill"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: controller.save,
          )
        ],
      ),
      body: Obx(() {
        if (controller.isError.value) {
          return FutureStateText(text: controller.error.value);
        }
        if (controller.isLoading.value) {
          return LoadingIndicator();
        }
        if (controller.categories.isNotEmpty) {
          return ManagerSkillForm();
        }
        if (controller.categories.isEmpty) {
          return FutureStateText(text: "You must create a category first");
        }
        return FutureStateText(text: "Unknown state");
      }),
    );
  }
}
