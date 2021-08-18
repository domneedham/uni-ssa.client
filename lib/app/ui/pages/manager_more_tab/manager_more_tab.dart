import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/manager_more_tab_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/more_tab_app_information.dart';
import 'package:ssa_app/app/ui/global_widgets/more_tab_settings.dart';
import 'package:ssa_app/app/ui/global_widgets/user_profile_header.dart';

class ManagerMoreTab extends GetWidget<ManagerMoreTabController> {
  const ManagerMoreTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          UserProfileHeader(user: controller.user),
          const Divider(),
          MoreTabSettings(logout: controller.logout),
          const Divider(),
          const MoreTabAppInformation(),
        ],
      ),
    );
  }
}
