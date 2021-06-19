import 'package:ssa_app/app/data/models/skill/category.dart';

class Skill {
  final int id;
  final String name;
  final Category category;

  Skill({
    required this.id,
    required this.name,
    required this.category,
  });
}
