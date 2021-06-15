import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_more_tab_controller.dart';

import 'manager_more_tab_app_information.dart';
import 'manager_more_tab_settings.dart';

class ManagerMoreTab extends GetWidget<ManagerMoreTabController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Column(
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
              Divider(),
            ],
          ),
          ManagerMoreTabSettings(),
          Divider(),
          ManagerMoreTabAppInformation(),
        ],
      ),
    );
  }
}
