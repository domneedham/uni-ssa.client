import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/staff_overview_controller.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/data/models/user/manager.dart';
import 'package:ssa_app/app/ui/global_widgets/future_state_text.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/global_widgets/user_profile_header.dart';

class StaffOverviewPage extends GetWidget<StaffOverviewController> {
  const StaffOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff Overview"),
      ),
      body: Obx(() {
        if (controller.staff != null) {
          final staff = controller.staff!.value;
          return ListView(
            children: [
              UserProfileHeader(user: staff),
              const Divider(),
              const Padding(
                padding: const EdgeInsets.all(8),
                child: Text("Reports To:"),
              ),
              FutureBuilder(
                future: controller.getManagerById(staff.managerId),
                builder: (BuildContext ctx, AsyncSnapshot<Manager> snapshot) {
                  if (snapshot.hasData) {
                    final user = snapshot.data!;
                    return ListTile(
                      leading: Icon(Icons.person),
                      title: Text(user.name),
                    );
                  }
                  if (snapshot.hasError) {
                    return const ListTile(
                      leading: Icon(Icons.person_off),
                      title: Text("User failed to load"),
                    );
                  }
                  return const ListTile(
                    leading: Icon(Icons.person),
                    title: Text("Loading user..."),
                  );
                },
              ),
              const Divider(),
              const Padding(
                padding: const EdgeInsets.all(8),
                child: Text("Skill List:"),
              ),
              FutureBuilder(
                future: controller.getSkillsByIds(staff.skills),
                builder: (BuildContext ctx,
                    AsyncSnapshot<List<StaffSkill>> snapshot) {
                  if (snapshot.hasData) {
                    final skills = snapshot.data!;
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: skills.length,
                      itemBuilder: (ctx, pos) {
                        final skill = skills[pos];
                        return ListTile(
                          leading: Icon(skill.category.icon),
                          title: Text(skill.name),
                          subtitle: controller.expiryTextWidget(skill),
                        );
                      },
                    );
                  }

                  if (snapshot.hasError) {
                    return FutureStateText(text: "Failed to load skills");
                  }
                  return LoadingIndicator();
                },
              ),
            ],
          );
        }
        if (controller.isError.value) {
          return FutureStateText(text: controller.error.value);
        }
        if (controller.isLoading.value) {
          return const LoadingIndicator();
        }
        return const FutureStateText(text: "Unknown state");
      }),
    );
  }
}
