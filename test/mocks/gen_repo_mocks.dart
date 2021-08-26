import 'package:mockito/annotations.dart';
import 'package:ssa_app/app/data/providers/category_provider.dart';
import 'package:ssa_app/app/data/providers/manager_provider.dart';
import 'package:ssa_app/app/data/providers/manager_staff_skill_provider.dart';
import 'package:ssa_app/app/data/providers/skill_provider.dart';
import 'package:ssa_app/app/data/providers/staff_provider.dart';
import 'package:ssa_app/app/data/providers/staff_skill_provider.dart';
import 'package:ssa_app/app/data/repository/category_repository.dart';
import 'package:ssa_app/app/data/repository/manager_staff_skill_repository.dart';
import 'package:ssa_app/app/data/repository/skill_repository.dart';
import 'package:ssa_app/app/data/repository/staff_skill_repository.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';
import 'package:ssa_app/app/data/services/category_service.dart';
import 'package:ssa_app/app/data/services/manager_staff_skill_service.dart';
import 'package:ssa_app/app/data/services/skill_service.dart';
import 'package:ssa_app/app/data/services/staff_skill_service.dart';
import 'package:ssa_app/app/data/services/user_service.dart';

@GenerateMocks([
  // repositories
  UserRepository,
  StaffSkillRepository,
  ManagerStaffSkillRepository,
  CategoryRepository,
  SkillRepository,
  // services
  UserService,
  StaffSkillService,
  ManagerStaffSkillService,
  CategoryService,
  SkillService,
  // providers
  CategoryProvider,
  ManagerProvider,
  ManagerStaffSkillProvider,
  SkillProvider,
  StaffProvider,
  StaffSkillProvider,
])
void main() {}
