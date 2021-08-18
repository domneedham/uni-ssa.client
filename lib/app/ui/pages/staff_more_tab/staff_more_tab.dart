import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/staff_more_tab_controller.dart';
import 'package:ssa_app/app/ui/global_widgets/more_tab_app_information.dart';
import 'package:ssa_app/app/ui/global_widgets/more_tab_settings.dart';
import 'package:ssa_app/app/ui/global_widgets/user_profile_header.dart';
import 'package:ssa_app/app/ui/pages/staff_more_tab/staff_more_tab_user_details.dart';

class StaffMoreTab extends StatelessWidget {
  const StaffMoreTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: GetBuilder<StaffMoreTabController>(
        builder: (controller) {
          return ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              UserProfileHeader(user: controller.user),
              const Divider(),
              const StaffMoreTabUserDetails(),
              const Divider(),
              MoreTabSettings(logout: controller.logout),
              const Divider(),
              const MoreTabAppInformation(),
            ],
          );
        },
      ),
    );
  }
}
