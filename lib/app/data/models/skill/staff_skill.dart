import 'skill.dart';
import 'category.dart';

class StaffSkill extends Skill {
  final int rating;
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

  bool get hasExpiry => expires != null;

  bool get isExpired {
    if (expires == null) {
      return false;
    }

    if (expires!.isAfter(DateTime.now())) {
      return false;
    } else {
      return true;
    }
  }

  factory StaffSkill.fromJson(Map<String, dynamic> json) {
    return StaffSkill(
      rating: json["rating"] as int,
      lastUpdated: DateTime.parse(json["lastUpdated"]),
      id: json["skill"]["id"] as int,
      name: json["skill"]["name"] as String,
      // expires can be null, so tryParse with date or "" to keep null
      expires: DateTime.tryParse(json["expires"] ?? ""),
      category:
          Category.fromJson(json["skill"]["category"] as Map<String, dynamic>),
    );
  }
}
