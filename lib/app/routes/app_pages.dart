import 'package:get/get.dart';
import 'package:ssa_app/app/bindings/home_binding.dart';
import 'package:ssa_app/app/bindings/manager_skill_overview_binding.dart';
import 'package:ssa_app/app/ui/pages/home_page/home_page.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_overview_page/managerskilloverview_page.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.MANAGER_SKILL_OVERVIEW,
      page: () => ManagerSkillOverviewPage(),
      binding: ManagerSkillOverviewBinding(),
    ),
  ];
}
