import 'package:ssa_app/app/data/models/skill/category.dart';

class Skill {
  Skill({
    required this.id,
    required this.name,
    required this.category,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'] as int,
      name: json['name'] as String,
      category: Category.fromJson(json['category']),
    );
  }

  final int id;
  final String name;
  final Category category;
}
