-- Targets the `portfolio` schema (run after 20261003_portfolio_schema.sql).
-- Already included in supabase/seed/portfolio_seed_from_repo.sql; kept as a re-runnable content update.

-- Experience revamp: company + tech tags, resume content

alter table portfolio.experiences
  add column if not exists company text not null default '',
  add column if not exists tech_tags text[] not null default '{}';

delete from portfolio.experiences;

insert into portfolio.experiences (
  role,
  company,
  period,
  context,
  bullets,
  tech_tags,
  sort_order
) values
(
  'Senior Flutter Developer',
  'Codebase',
  'Aug 2025 – Present',
  'Onsite · Mansoura',
  array[
    'Led the Flutter team through technical guidance, code reviews, and coding standards.',
    'Profiled and refactored workout, video playback, and WebView flows to improve performance and maintainability.',
    'Built a CI/CD pipeline with Flutter Flavors to automate builds, deployments, and release workflows, streamlining QA and releases.',
    'Delivered New Home, New Workout Experience, and real-time chat features.',
    'Managed Google Play and Apple App Store releases and production deployments.',
    'Used Hive for local storage and caching in key app flows.',
    'Integrated Google Maps API where location features were required.'
  ],
  array['Flutter', 'CI/CD', 'Flavors', 'Hive', 'Google Maps', 'WebView'],
  1
),
(
  'Flutter Engineer',
  'Artzone',
  'Feb 2025 – Apr 2025',
  'Remote',
  array[
    'Added two Taggz features, contributing to a 26% increase in downloads after release.',
    'Integrated the PayMob payment gateway in Taggz for secure in-app transactions.',
    'Implemented Google Maps API for location-based functionality in Taggz.',
    'Used Hive for local storage and offline data handling in Taggz.',
    'Refactored and optimized the app to improve stability and performance.'
  ],
  array['Flutter', 'PayMob', 'Google Maps', 'Hive'],
  2
),
(
  'Flutter Engineer',
  'Ultra Progress',
  'Jan 2024 – Jan 2025',
  'Remote',
  array[
    'Built, extended, and refactored 10+ Flutter apps for client requirements using GetX and Provider to deliver stable, scalable solutions.',
    'Implemented PayTabs payment flows for iConcierge and other client projects.',
    'Integrated Pusher in iConcierge to support real-time messaging and notifications.',
    'Integrated Google Maps API in select client apps to support location-based features.',
    'Used Notion to organize requirements, documentation, and release handoff across projects.',
    'Managed app releases on Google Play, App Store, and Huawei AppGallery.'
  ],
  array['Flutter', 'GetX', 'Provider', 'PayTabs', 'Pusher', 'Google Maps'],
  3
),
(
  'Flutter Engineer',
  'Creen',
  'Jul 2021 – Dec 2023',
  'Remote',
  array[
    'Developed AllTraders independently, covering UI, business logic, and API integration.',
    'Enhanced Creen with new features, UI fixes, and MyFatoorah payment integration.',
    'Integrated Agora in Creen for real-time communication features.',
    'Ramped up quickly on new requirements through self-learning and delivered features independently.',
    'Contributed to positioning Creen among the top 3 social and super apps in Saudi Arabia.'
  ],
  array['Flutter', 'MyFatoorah', 'Agora'],
  4
);
