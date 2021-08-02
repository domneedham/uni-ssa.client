import 'package:flutter/material.dart';

class Category {
  final int id;
  final String name;
  final IconData icon;

  Category({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"] as int,
      name: json["name"] as String,
      icon: IconData(json["icon"] as int, fontFamily: 'MaterialIcons'),
    );
  }
}
