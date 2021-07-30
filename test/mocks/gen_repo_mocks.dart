import 'package:mockito/annotations.dart';
import 'package:ssa_app/app/data/repository/category_repository.dart';
import 'package:ssa_app/app/data/repository/manager_staff_skill_repository.dart';
import 'package:ssa_app/app/data/repository/skill_staff_repository.dart';
import 'package:ssa_app/app/data/repository/user_repository.dart';

@GenerateMocks([
  UserRepository,
  SkillStaffRepository,
  SkillManagerRepository,
  CategoryRepository
])
void main() {}
