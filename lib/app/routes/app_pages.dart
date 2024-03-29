import 'package:get/get.dart';
import 'package:ssa_app/app/bindings/home_binding.dart';
import 'package:ssa_app/app/bindings/login_binding.dart';
import 'package:ssa_app/app/bindings/manager_binding.dart';
import 'package:ssa_app/app/bindings/manager_category_form_binding.dart';
import 'package:ssa_app/app/bindings/manager_category_overview_binding.dart';
import 'package:ssa_app/app/bindings/manager_overview_binding.dart';
import 'package:ssa_app/app/bindings/manager_skill_form_binding.dart';
import 'package:ssa_app/app/bindings/manager_skill_overview_binding.dart';
import 'package:ssa_app/app/bindings/staff_assign_skill_binding.dart';
import 'package:ssa_app/app/bindings/staff_binding.dart';
import 'package:ssa_app/app/bindings/staff_edit_details_binding.dart';
import 'package:ssa_app/app/bindings/staff_overview_binding.dart';
import 'package:ssa_app/app/bindings/staff_skill_overview_binding.dart';
import 'package:ssa_app/app/ui/pages/home_page/home_page.dart';
import 'package:ssa_app/app/ui/pages/home_page/manager_home_page.dart';
import 'package:ssa_app/app/ui/pages/home_page/staff_home_page.dart';
import 'package:ssa_app/app/ui/pages/login/login_page.dart';
import 'package:ssa_app/app/ui/pages/manager_category_form_page/manager_category_form_page.dart';
import 'package:ssa_app/app/ui/pages/manager_category_overview_page/manager_category_overview_page.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_form_page/manager_skill_form_page.dart';
import 'package:ssa_app/app/ui/pages/manager_skill_overview_page/manager_skill_overview_page.dart';
import 'package:ssa_app/app/ui/pages/staff_assign_skill_page/staff_assign_skill_page.dart';
import 'package:ssa_app/app/ui/pages/staff_skill_overview_page/staff_skill_overview_page.dart';
import 'package:ssa_app/app/ui/pages/user_overview/manager_overview/manager_overview_page.dart';
import 'package:ssa_app/app/ui/pages/user_overview/staff_overview/staff_overview_page.dart';
import 'package:ssa_app/app/ui/staff_edit_details_page/staff_edit_details_page.dart';
part './app_routes.dart';

final pages = [
  GetPage(
    name: Routes.HOME,
    page: () => const HomePage(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: Routes.LOGIN,
    page: () => const LoginPage(),
    binding: LoginBinding(),
  ),

  // USER OVERVIEW PAGES
  GetPage(
    name: Routes.MANAGER_OVERVIEW,
    page: () => const ManagerOverviewPage(),
    binding: ManagerOverviewBinding(),
  ),
  GetPage(
    name: Routes.STAFF_OVERVIEW,
    page: () => const StaffOverviewPage(),
    binding: StaffOverviewBinding(),
  ),

  // MANAGER PAGES
  GetPage(
    name: Routes.MANAGER_HOME,
    page: () => const ManagerHomePage(),
    binding: ManagerBinding(),
  ),
  GetPage(
    name: Routes.MANAGER_SKILL_OVERVIEW,
    page: () => const ManagerSkillOverviewPage(),
    binding: ManagerSkillOverviewBinding(),
  ),
  GetPage(
    name: Routes.MANAGER_CATEGORY_OVERVIEW,
    page: () => const ManagerCategoryOverviewPage(),
    binding: ManagerCategoryOverviewBinding(),
  ),
  GetPage(
    name: Routes.MANAGER_SKILL_FORM,
    page: () => const ManagerSkillFormPage(),
    binding: ManagerSkillFormBinding(),
  ),
  GetPage(
    name: Routes.MANAGER_CATEGORY_FORM,
    page: () => const ManagerCategoryFormPage(),
    binding: ManagerCategoryFormBinding(),
  ),

  // STAFF PAGES
  GetPage(
    name: Routes.STAFF_HOME,
    page: () => const StaffHomePage(),
    binding: StaffBinding(),
  ),
  GetPage(
    name: Routes.STAFF_ASSIGN_SKILL,
    page: () => const StaffAssignSkillPage(),
    binding: StaffAssignSkillBinding(),
  ),
  GetPage(
    name: Routes.STAFF_SKILL_OVERVIEW,
    page: () => const StaffSkillOverviewPage(),
    binding: StaffSkillOverviewBinding(),
  ),
  GetPage(
    name: Routes.STAFF_EDIT_DETAILS,
    page: () => const StaffEditDetailsPage(),
    binding: StaffEditDetailsBinding(),
  ),
];
