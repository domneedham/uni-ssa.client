import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/ui/pages/home_page/manager_home_page.dart';
import 'package:ssa_app/app/ui/pages/home_page/staff_home_page.dart';
import 'package:ssa_app/app/ui/pages/login/login_page.dart';
import '../../../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // if (controller.loggedIn.value && controller.user != null) {
        //   if (controller.user!.isStaff) {
        //     return StaffHomePage();
        //   }
        //   if (controller.user!.isManager) {
        //     return ManagerHomePage();
        //   }
        // }

        // return LoginPage();

        return Center(
          child: FlutterLogo(
            size: controller.size.value,
            duration: Duration(seconds: 1, milliseconds: 500),
          ),
        );
      }),
    );
  }
}
