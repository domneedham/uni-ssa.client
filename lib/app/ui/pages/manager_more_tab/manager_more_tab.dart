import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_more_tab_controller.dart';

import 'manager_more_tab_app_information.dart';
import 'manager_more_tab_profile_header.dart';
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
          ManagerMoreTabProfileHeader(),
          Divider(),
          ManagerMoreTabSettings(),
          Divider(),
          ManagerMoreTabAppInformation(),
        ],
      ),
    );
  }
}
