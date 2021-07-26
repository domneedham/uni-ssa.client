import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/staff_edit_details_controller.dart';

class StaffEditDetailsPage extends GetView<StaffEditDetailsController> {
  const StaffEditDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Details'),
        actions: [
          IconButton(
            onPressed: controller.save,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: controller.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Firstname"),
                validator: controller.validateName,
                controller: controller.firstnameController,
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: "Surname"),
                validator: controller.validateName,
                controller: controller.surnameController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
