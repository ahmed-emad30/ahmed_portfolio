import 'package:flutter/material.dart';

class SkillEntity {
  const SkillEntity({
    required this.name,
    required this.proficiency,
    required this.color,
  });

  final String name;
  final int proficiency;
  final Color color;
}

class SkillCategoryEntity {
  const SkillCategoryEntity({
    required this.title,
    required this.skills,
  });

  final String title;
  final List<SkillEntity> skills;
}
