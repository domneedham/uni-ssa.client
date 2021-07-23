part of './app_pages.dart';

abstract class Routes {
  static const INITIAL = '/';
  static const HOME = '/home';

  // USER OVERVIEW
  static const STAFF_OVERVIEW = '/staff-overview';
  static const MANAGER_OVERVIEW = '/manager-overview';

  // MANAGER ROUTES
  static const MANAGER_HOME = '/manager';
  static const MANAGER_SKILL_OVERVIEW = '/manager-skill-overview';
  static const MANAGER_CATEGORY_OVERVIEW = '/manager-category-overview';
  static const MANAGER_SKILL_FORM = '/manager-skill-form';
  static const MANAGER_CATEGORY_FORM = '/manager-category-form';

  // STAFF ROUTES
  static const STAFF_HOME = '/staff';
  static const STAFF_ASSIGN_SKILL = '/staff-assign-skill';
  static const STAFF_SKILL_OVERVIEW = '/staff-skill-overview';
}
