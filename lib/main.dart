import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ssa_app/app/bindings/app_binding.dart';
import './app/routes/app_pages.dart';
import './app/ui/theme/app_theme.dart';

void main() async {
  // needs to be called before intialisation of the application for use as a
  // dependancy in other services.
  await GetStorage.init();
  runApp(const StaffSkillAuditorApp());
}

class StaffSkillAuditorApp extends StatelessWidget {
  const StaffSkillAuditorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Staff Skill Auditor',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.HOME,
      theme: appThemeData,
      defaultTransition: Transition.fade,
      getPages: pages,
      initialBinding: AppBinding(),
    );
  }
}
