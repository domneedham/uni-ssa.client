import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_more_tab_controller.dart';

class ManagerMoreTabProfileHeader extends GetView<ManagerMoreTabController> {
  const ManagerMoreTabProfileHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: CircleAvatar(
            child: Text(
              controller.user.name[0],
              style: TextStyle(fontSize: 36),
            ),
            radius: 48,
          ),
        ),
        Text(
          controller.user.name,
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}
