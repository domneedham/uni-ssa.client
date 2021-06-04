import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ssa_app/app/controllers/home_staff_controller.dart';
import 'package:ssa_app/app/data/models/skill/category.dart';
import 'package:ssa_app/app/data/models/skill/staff_skill.dart';
import 'package:ssa_app/app/ui/pages/home_page/staff/staff_skill_card.dart';
import 'package:ssa_app/app/ui/pages/home_page/user_debug.dart';

class StaffHomePage extends GetWidget<HomeStaffController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView(
        children: [
          UserDebug(user: controller.user),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Your Skills",
              style: Get.textTheme.headline4,
            ),
          ),
          FutureBuilder(
            future: controller.skills,
            builder: (BuildContext ctx,
                AsyncSnapshot<Map<Category, List<StaffSkill>>?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Fetching data and waiting.");
              }
              if (snapshot.hasData) {
                final skills = snapshot.data!;
                if (skills.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("You have no registered skills"),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: skills.length,
                  itemBuilder: (c, p) {
                    final entry = skills.entries.elementAt(p);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(entry.key.icon),
                              SizedBox(width: 8),
                              Text(
                                entry.key.name,
                                style: Get.textTheme.headline5,
                              ),
                            ],
                          ),
                        ),
                        GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: entry.value.length,
                          itemBuilder: (ctx, pos) {
                            final skill = entry.value[pos];
                            return StaffSkillCard(skill: skill);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  },
                );
              }
              if (snapshot.hasError) {
                return Text("Oh no, that didn't work.");
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("You have no registered skills"),
              );
            },
          ),
        ],
      ),
    );
  }
}
