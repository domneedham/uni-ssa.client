import 'package:flutter/material.dart';

class ManagerSkillFormPage extends StatelessWidget {
  const ManagerSkillFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Skill"),
      ),
      body: Center(
        child: Text("Add/Edit Skill"),
      ),
    );
  }
}
