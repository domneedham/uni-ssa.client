import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/data/models/user/staff.dart';
import '../../../controllers/manager_skill_overview_controller.dart';

class ManagerSkillOverviewPage extends GetView<ManagerSkillOverviewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skill Overview'),
        actions: [
          IconButton(
            onPressed: controller.editSkill,
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: FutureBuilder(
        future: controller.getSkill(),
        builder: (BuildContext ctx, AsyncSnapshot<ManagerStaffSkill> snapshot) {
          if (snapshot.hasData) {
            final skill = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(16.0),
              physics: ClampingScrollPhysics(),
              children: [
                Text(skill.name, style: Get.textTheme.headline4),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(skill.category.icon),
                    SizedBox(width: 8),
                    Text(
                      skill.category.name,
                      style: Get.textTheme.headline5,
                    )
                  ],
                ),
                SizedBox(height: 32),
                Text(
                  "Staff Assigned:",
                  style: Get.textTheme.subtitle1,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: skill.staff.length,
                  itemBuilder: (c, pos) {
                    final staffId = skill.staff[pos];
                    return FutureBuilder(
                      future: controller.getStaffById(staffId),
                      builder:
                          (BuildContext ctx, AsyncSnapshot<Staff> snapshot) {
                        if (snapshot.hasData) {
                          final user = snapshot.data!;
                          return ListTile(
                            // overwrite left padding used in ListTile
                            contentPadding: const EdgeInsets.only(right: 16),
                            leading: Icon(Icons.person),
                            title: Text(user.name),
                          );
                        }
                        if (snapshot.hasError) {
                          return Text("User failed to load");
                        }
                        return Text("Waiting");
                      },
                    );
                  },
                ),
              ],
            );
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: Text("Waiting"));
        },
      ),
    );
  }
}
