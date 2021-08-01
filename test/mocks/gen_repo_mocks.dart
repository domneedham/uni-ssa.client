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

@GenerateMocks([
  // repositories
  UserRepository,
  StaffSkillRepository,
  ManagerStaffSkillRepository,
  CategoryRepository,
  SkillRepository,
  // providers
  CategoryProvider,
  ManagerProvider,
  ManagerStaffSkillProvider,
  SkillProvider,
  StaffProvider,
  StaffSkillProvider,
])
void main() {}
