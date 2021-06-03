import 'skill.dart';
import 'category.dart';

class StaffSkill extends Skill {
  final double rating;
  final DateTime lastUpdated;

  StaffSkill({
    required this.rating,
    required this.lastUpdated,
    required int id,
    required String name,
    required Category category,
  }) : super(id: id, name: name, category: category);
}
