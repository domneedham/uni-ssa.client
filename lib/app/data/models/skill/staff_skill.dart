import 'skill.dart';
import 'category.dart';

class StaffSkill extends Skill {
  final double rating;
  final DateTime lastUpdated;
  final DateTime? expires;

  StaffSkill({
    required this.rating,
    required this.lastUpdated,
    this.expires,
    required int id,
    required String name,
    required Category category,
  }) : super(id: id, name: name, category: category);
}
