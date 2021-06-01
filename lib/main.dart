import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/bindings/home_binding.dart';
import './app/routes/app_pages.dart';
import './app/ui/theme/app_theme.dart';

void main() {
  runApp(StaffSkillAuditorApp());
}

class StaffSkillAuditorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Staff Skill Auditor',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.HOME,
      theme: appThemeData,
      defaultTransition: Transition.fade,
      getPages: AppPages.pages,
      initialBinding: HomeBinding(),
    );
  }
}
