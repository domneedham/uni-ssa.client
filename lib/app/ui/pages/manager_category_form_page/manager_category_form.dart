import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_category_form_controller.dart';

class ManagerCategoryForm extends GetView<ManagerCategoryFormController> {
  const ManagerCategoryForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Name"),
              validator: controller.validateName,
              initialValue: controller.editCategory?.name,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  return Icon(
                    controller.selectedIcon,
                    size: 36,
                  );
                }),
                ElevatedButton(
                  onPressed: controller.pickIcon,
                  child: Text("Pick Icon"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
