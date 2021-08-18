import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ssa_app/app/controllers/manager_skill_tab_controller.dart';
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart';
import 'package:ssa_app/app/ui/global_widgets/future_state_text.dart';
import 'package:ssa_app/app/ui/global_widgets/loading_indicator.dart';
import 'package:ssa_app/app/ui/global_widgets/skill_list.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_tab/manager_skill_card.dart';

import 'manager_skill_list_tile.dart';

class ManagerSkillTab extends GetWidget<ManagerSkillTabController> {
  const ManagerSkillTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skills'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.view_agenda_outlined),
            onSelected: (SkillListViewType type) =>
                controller.changeViewType(type),
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  child: Text('List'),
                  value: SkillListViewType.LIST,
                ),
                const PopupMenuItem(
                  child: Text('Grid'),
                  value: SkillListViewType.GRID,
                ),
              ];
            },
          ),
          IconButton(
            onPressed: controller.createNewSkill,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.skills != null) {
          final skills = controller.skills!;
          if (skills.isEmpty) {
            return const FutureStateText(text: 'No skills loaded.');
          }
          return SkillList(
            gridChildAspectRatio: 2.5,
            viewType: controller.viewType.value,
            skills: skills,
            cardBuilder: (skill) {
              if (controller.viewType.value == SkillListViewType.LIST) {
                return ManagerSkillListTile(skill: skill as ManagerStaffSkill);
              } else {
                return ManagerSkillCard(skill: skill as ManagerStaffSkill);
              }
            },
          );
        }
        if (controller.isError.value) {
          return FutureStateText(text: controller.error.value);
        }
        if (controller.isLoading.value) {
          return const LoadingIndicator();
        }
        return const FutureStateText(text: 'Unknown state');
      }),
    );
  }
}
