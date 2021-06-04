import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/data/models/enums/user_role.dart';
import 'package:ssa_app/app/ui/pages/home_page/manager/manager_home.dart';
import 'package:ssa_app/app/ui/pages/home_page/staff/staff_home.dart';
import '../../../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return controller.user.userRole == UserRole.STAFF
        ? StaffHomePage()
        : ManagerHomePage();
  }
}
