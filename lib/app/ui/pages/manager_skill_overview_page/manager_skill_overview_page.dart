import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/manager_skill_overview_controller.dart';

class ManagerSkillOverviewPage extends GetView<ManagerSkillOverviewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ManagerSkillOverviewPage'),
      ),
      body: SafeArea(
        child: Text('ManagerSkillOverviewController'),
      ),
    );
  }
}
