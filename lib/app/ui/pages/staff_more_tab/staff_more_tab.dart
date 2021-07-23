import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/staff_more_tab_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/more_tab_app_information.dart';
import 'package:ssa_app/app/ui/global_widgets/user_profile_header.dart';

class StaffMoreTab extends GetWidget<StaffMoreTabController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          UserProfileHeader(user: controller.user),
          Divider(),
          MoreTabAppInformation(),
        ],
      ),
    );
  }
}
