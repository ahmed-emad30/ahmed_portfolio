import 'package:flutter/material.dart';
import 'package:portfolio/features/experience/domain/entity/experience_entity.dart';
import 'package:portfolio/features/portfolio/domain/entity/project_entity.dart';
import 'package:portfolio/features/shared/domain/entity/portfolio_data_entity.dart';
import 'package:portfolio/features/shared/domain/entity/profile_entity.dart';
import 'package:portfolio/features/shared/domain/entity/service_entity.dart';
import 'package:portfolio/features/shared/domain/entity/social_link_entity.dart';
import 'package:portfolio/features/skills/domain/entity/skill_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SharedRemoteDataSource {
  Future<PortfolioDataEntity> fetchPortfolioData();
}

class SharedRemoteDataSourceImp implements SharedRemoteDataSource {
  SharedRemoteDataSourceImp(this._client);

  final SupabaseClient _client;

  @override
  Future<PortfolioDataEntity> fetchPortfolioData() async {
    final results = await Future.wait([
      _client.from('profile').select().limit(1).maybeSingle(),
      _client.from('social_links').select().order('sort_order'),
      _client.from('services').select().order('sort_order'),
      _client.from('skill_categories').select().order('sort_order'),
      _client.from('skills').select().order('sort_order'),
      _client.from('experiences').select().order('sort_order'),
      _client.from('projects').select().order('sort_order',ascending: true),
    ]);

    final profileRow = results[0] as Map<String, dynamic>?;
    if (profileRow == null) {
      throw StateError('No profile row found in Supabase');
    }

    final socialRows = (results[1] as List).cast<Map<String, dynamic>>();
    final serviceRows = (results[2] as List).cast<Map<String, dynamic>>();
    final categoryRows = (results[3] as List).cast<Map<String, dynamic>>();
    final skillRows = (results[4] as List).cast<Map<String, dynamic>>();
    final experienceRows = (results[5] as List).cast<Map<String, dynamic>>();
    final projectRows = (results[6] as List).cast<Map<String, dynamic>>();

    final skillsByCategory = <String, List<SkillEntity>>{};
    for (final skill in skillRows) {
      final categoryId = skill['category_id'] as String;
      skillsByCategory.putIfAbsent(categoryId, () => []).add(
            SkillEntity(
              name: skill['name'] as String,
              proficiency: skill['proficiency'] as int,
              color: _parseColor(skill['color_hex'] as String?),
            ),
          );
    }

    return PortfolioDataEntity(
      profile: ProfileEntity(
        displayName: profileRow['display_name'] as String,
        title: profileRow['title'] as String,
        about: profileRow['about'] as String,
        aeStudioLabel: profileRow['ae_studio_label'] as String? ?? 'AE Studio',
        aeStudioUrl: profileRow['ae_studio_url'] as String? ?? '',
        resumeUrl: profileRow['resume_url'] as String? ?? '',
        skillsSubtitle: profileRow['skills_subtitle'] as String? ?? '',
      ),
      socialLinks: socialRows
          .map(
            (row) => SocialLinkEntity(
              key: row['key'] as String,
              url: row['url'] as String? ?? '',
              sortOrder: row['sort_order'] as int? ?? 0,
              isEnabled: row['is_enabled'] as bool? ?? true,
            ),
          )
          .toList(),
      services: serviceRows
          .map(
            (row) => ServiceEntity(
              title: row['title'] as String,
              description: row['description'] as String,
              sortOrder: row['sort_order'] as int? ?? 0,
            ),
          )
          .toList(),
      skillCategories: categoryRows
          .map(
            (row) => SkillCategoryEntity(
              title: row['title'] as String,
              skills: skillsByCategory[row['id'] as String] ?? const [],
            ),
          )
          .toList(),
      experiences: experienceRows
          .map(
            (row) => ExperienceEntity(
              role: row['role'] as String,
              period: row['period'] as String,
              context: row['context'] as String,
              bullets: (row['bullets'] as List?)?.cast<String>() ?? const [],
            ),
          )
          .toList(),
      projects: projectRows
          .map(
            (row) => ProjectEntity(
              id: row['slug'] as String,
              title: row['title'] as String,
              shortDescription: row['short_description'] as String,
              fullDescription: row['full_description'] as String,
              imageUrl: _text(row['image_url']),
              imageKey: _text(row['image_key']),
              techStack: (row['tech_stack'] as List?)?.cast<String>() ?? const [],
              features: (row['features'] as List?)?.cast<String>() ?? const [],
              role: row['role'] as String,
              googlePlayUrl: _text(row['google_play_url']),
              appStoreUrl: _text(row['app_store_url']),
              videoUrl: _text(row['video_url']),
              githubUrl: _text(row['github_url']),
              apkUrl: _text(row['apk_url']),
              webUrl: _text(row['web_url']),
              supportsWindows: row['supports_windows'] as bool? ?? false,
              previewImage1Url: _text(row['preview_image_1_url']),
              previewImage1Key: _text(row['preview_image_1_key']),
              previewImage2Url: _text(row['preview_image_2_url']),
              previewImage2Key: _text(row['preview_image_2_key']),
            ),
          )
          .toList(),
    );
  }

  Color _parseColor(String? hex) {
    if (hex == null || hex.isEmpty) return const Color(0xffB6FF85);
    var value = hex.replaceFirst('#', '');
    if (value.length == 6) value = 'ff$value';
    return Color(int.parse(value, radix: 16));
  }

  String _text(dynamic value) {
    if (value == null) return '';
    final text = value.toString().trim();
    if (text.isEmpty || text.toLowerCase() == 'null') return '';
    return text;
  }
}
