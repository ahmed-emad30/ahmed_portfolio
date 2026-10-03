-- FALLBACK ONLY: rebuilds portfolio content from what is in this repo
-- (PortfolioContent.fallback + supabase/migrations/20260807_*.sql).
--
-- Use this only if the old project (tptaqfbmqifzewewnudg) cannot be restored.
-- If you have old_data.sql from the old project, load that instead
-- (see docs/SUPABASE_AND_DEPLOY.md → "Migrating data from the old project").
--
-- What is lost on this path:
--   * contact_messages history (never stored in the repo)
--   * resume / project image URLs that pointed at the old Storage bucket
--   * any edits made in the Table Editor that never made it back into the repo
--
-- Run after 20261003_portfolio_schema.sql. Re-running replaces all content
-- rows (contact_messages is never touched).

begin;

truncate
  portfolio.skills,
  portfolio.skill_categories,
  portfolio.profile,
  portfolio.social_links,
  portfolio.services,
  portfolio.experiences,
  portfolio.projects;

-- Profile ------------------------------------------------------------------

insert into portfolio.profile (
  display_name, title, about, ae_studio_label, ae_studio_url, resume_url, skills_subtitle
) values (
  'Ahmed Emad.',
  'Flutter Developer',
  'Flutter Developer with 2+ years of experience building and publishing 15+ cross-platform mobile apps on the App Store, Google Play, and Huawei AppGallery. Skilled in Dart, Flutter, REST APIs, Firebase, and state management using Cubit. Proven ability to design responsive UIs, implement real-time features, and support localization (Arabic/English). Passionate about clean code, performance optimization, and delivering user-focused mobile experiences',
  'AE Studio',
  'https://www.abdelrhman-elnhas.com',
  '',
  'Technologies I work with daily to build polished mobile experiences.'
);

-- Social links ---------------------------------------------------------------

insert into portfolio.social_links (key, url, sort_order, is_enabled) values
  ('github', 'https://github.com/ahmed-emad30', 1, true),
  ('linkedin', 'https://www.linkedin.com/in/ahmed-emad-lotfy/', 2, true),
  ('email', 'mailto:ahmedemad0173@gmail.com', 3, true),
  ('whatsapp', 'https://wa.me/+201007344288', 4, true),
  ('cv', '', 5, true),
  ('x', 'https://x.com/Ahmed_Emad30', 6, true);

-- Services -------------------------------------------------------------------

insert into portfolio.services (title, description, sort_order) values
  ('Mobile App Development', 'Cross-platform Flutter apps tailored to product goals and user needs.', 1),
  ('Mobile App Deployment', 'Store-ready builds for App Store, Google Play, and Huawei AppGallery.', 2),
  ('Refactor & Optimisation', 'Performance tuning, clean architecture, and maintainable codebases.', 3),
  ('Reskin & Redesign', 'UI refreshes that preserve brand identity while improving usability.', 4);

-- Skills ---------------------------------------------------------------------

insert into portfolio.skill_categories (title, sort_order) values
  ('Languages & Frameworks', 1),
  ('State Management', 2),
  ('Backend Integration', 3),
  ('Firebase', 4),
  ('Local Storage', 5),
  ('CI/CD & DevOps', 6),
  ('Publishing', 7),
  ('Testing & Debugging', 8),
  ('Tools', 9),
  ('Automation & Scripting', 10),
  ('Development Practices', 11);

insert into portfolio.skills (category_id, name, proficiency, color_hex, sort_order)
select c.id, s.name, s.proficiency, s.color_hex, s.sort_order
from (values
  ('Languages & Frameworks', 'Flutter', 95, '#B6FF85', 1),
  ('Languages & Frameworks', 'Dart', 90, '#85E3FF', 2),

  ('State Management', 'BLoC (Cubit)', 95, '#B6FF85', 1),
  ('State Management', 'Provider', 90, '#85E3FF', 2),
  ('State Management', 'Riverpod', 90, '#FFE885', 3),
  ('State Management', 'GetX', 85, '#FF8585', 4),

  ('Backend Integration', 'RESTful APIs', 95, '#FFE885', 1),
  ('Backend Integration', 'Dio', 95, '#85E3FF', 2),
  ('Backend Integration', 'HTTP', 90, '#B6FF85', 3),
  ('Backend Integration', 'JSON Serialization', 90, '#FF8585', 4),
  ('Backend Integration', 'WebSockets', 85, '#FFE885', 5),

  ('Firebase', 'Authentication', 95, '#B6FF85', 1),
  ('Firebase', 'Cloud Firestore', 90, '#85E3FF', 2),
  ('Firebase', 'Cloud Messaging (FCM)', 90, '#FFE885', 3),
  ('Firebase', 'Crashlytics', 85, '#FF8585', 4),
  ('Firebase', 'Analytics', 85, '#B6FF85', 5),
  ('Firebase', 'Firebase hosting', 85, '#85E3FF', 6),
  ('Firebase', 'Firebase Database (real time database)', 85, '#FFE885', 7),
  ('Firebase', 'Firebase Dynamics', 80, '#FF8585', 8),

  ('Local Storage', 'Hive', 95, '#B6FF85', 1),
  ('Local Storage', 'SharedPreferences', 95, '#85E3FF', 2),
  ('Local Storage', 'Secure Storage', 90, '#FFE885', 3),
  ('Local Storage', 'SQLite', 85, '#FF8585', 4),

  ('CI/CD & DevOps', 'GitHub Actions', 90, '#85E3FF', 1),
  ('CI/CD & DevOps', 'Codemagic', 90, '#B6FF85', 2),
  ('CI/CD & DevOps', 'Shorebird', 85, '#FFE885', 3),
  ('CI/CD & DevOps', 'Fastlane', 85, '#FF8585', 4),
  ('CI/CD & DevOps', 'Flutter Flavors', 90, '#85E3FF', 5),
  ('CI/CD & DevOps', 'App Distribution', 85, '#B6FF85', 6),

  ('Publishing', 'Google Play Console', 95, '#B6FF85', 1),
  ('Publishing', 'Apple App Store Connect', 90, '#85E3FF', 2),
  ('Publishing', 'Huawei AppGallery', 90, '#FFE885', 3),

  ('Testing & Debugging', 'Unit Testing', 85, '#B6FF85', 1),
  ('Testing & Debugging', 'Widget Testing', 85, '#85E3FF', 2),
  ('Testing & Debugging', 'Integration Testing', 80, '#FFE885', 3),
  ('Testing & Debugging', 'E2E testing', 80, '#FF8585', 4),
  ('Testing & Debugging', 'Performance Optimization', 85, '#B6FF85', 5),
  ('Testing & Debugging', 'Memory Leak Analysis', 80, '#85E3FF', 6),

  ('Tools', 'Git', 95, '#B6FF85', 1),
  ('Tools', 'Android Studio', 95, '#85E3FF', 2),
  ('Tools', 'Xcode', 90, '#FFE885', 3),
  ('Tools', 'VS Code', 95, '#FF8585', 4),
  ('Tools', 'Postman', 90, '#B6FF85', 5),
  ('Tools', 'Figma', 85, '#85E3FF', 6),
  ('Tools', 'Jira', 85, '#FFE885', 7),
  ('Tools', 'Firebase Console', 90, '#FF8585', 8),

  ('Automation & Scripting', 'Bash', 85, '#B6FF85', 1),
  ('Automation & Scripting', 'Dart Scripts', 90, '#85E3FF', 2),
  ('Automation & Scripting', 'Build Automation', 85, '#FFE885', 3),
  ('Automation & Scripting', 'Rebranding Automation', 85, '#FF8585', 4),
  ('Automation & Scripting', 'Codemagic', 90, '#B6FF85', 5),
  ('Automation & Scripting', 'Fastlane', 85, '#85E3FF', 6),
  ('Automation & Scripting', 'CI/CD', 90, '#FFE885', 7),

  ('Development Practices', 'Agile (Scrum)', 95, '#B6FF85', 1),
  ('Development Practices', 'Code Review', 95, '#85E3FF', 2),
  ('Development Practices', 'Technical Documentation', 90, '#FFE885', 3),
  ('Development Practices', 'SDLC', 90, '#FF8585', 4)
) as s (category, name, proficiency, color_hex, sort_order)
join portfolio.skill_categories c on c.title = s.category;

-- Experiences ----------------------------------------------------------------

insert into portfolio.experiences (role, company, period, context, bullets, tech_tags, sort_order) values
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

-- Projects -------------------------------------------------------------------
-- Store/source links were only ever stored in the old database. Fill them in
-- from the Table Editor afterwards if the old project is gone for good.

insert into portfolio.projects (
  slug, title, short_description, full_description, image_url, image_key,
  tech_stack, features, role, sort_order
) values
(
  'taggz',
  'Taggz',
  'An iOS and Android social tagging app with real-time discovery, profile flows, and polished cross-platform UI.',
  'Taggz is an event photo-sharing platform that leverages facial recognition and QR technology to simplify event check-in and provide attendees with instant access to their event photos.',
  '',
  'taggz',
  array['Flutter', 'Dart', 'Cubit', 'Dio', 'REST APIs', 'Firebase', 'QR Code Integration', 'Face Recognition APIs', 'Cloud Storage'],
  array['Face recognition-based photo discovery.', 'QR code event check-in.', 'Secure photo upload and download.', 'High-resolution media management.', 'Role-based access control.', 'Photo sharing.', 'Authentication and user management.', 'Cross-platform deployment for Android and iOS.'],
  'Flutter Developer',
  1
),
(
  'iconcierge',
  'iConcierge',
  'An iOS and Android concierge platform with service booking, notifications, and localized user journeys.',
  'iConcierge is a luxury concierge platform designed for El Gouna, providing premium lifestyle services such as yacht bookings, restaurant reservations, spa experiences, private jet charters, and real-time customer communication.',
  '',
  'iconcierge',
  array['Flutter', 'Dart', 'Cubit', 'Firebase', 'REST APIs', 'Dio', 'Google Maps', 'Localization', 'Firebase Cloud Messaging'],
  array['Luxury service booking and reservation management.', 'Real-time chat and customer support.', 'Secure online payments.', 'Push notifications.', 'Responsive cross-platform experience.', 'Multi-language support.', 'Real-time service availability.', 'User profile and booking history.'],
  'Flutter Developer',
  2
),
(
  'wepick',
  'Wepick',
  'An iOS and Android selection platform with curated content, dynamic lists, and engaging mobile interactions.',
  'WePick is a localized event planning marketplace that enables users to discover, book, and purchase services for various occasions through a seamless and bilingual mobile experience.',
  '',
  'wepick',
  array['Flutter', 'Dart', 'Cubit', 'Dio', 'REST APIs', 'Telr Payment Gateway', 'Firebase', 'Social Login (Google, Apple, Twitter)', 'PDF Generation', 'Localization (EN/AR)'],
  array['Product catalog with advanced search and filtering.', 'Shopping cart, coupons, and secure checkout.', 'Telr payment gateway integration.', 'Social authentication (Google, Apple, Twitter).', 'Invoice generation and PDF download.', 'Order management and payment tracking.', 'Arabic & English localization.', 'Responsive UI for different screen sizes.'],
  'Flutter Developer',
  3
),
(
  'all-traders',
  'All Traders',
  'An iOS and Android trading companion app with market views, account flows, and secure data handling.',
  'AllTraders is a multi-role e-commerce platform that connects traders, customers, and delivery agents, enabling product management, order processing, and delivery tracking within a unified mobile application.',
  '',
  'alltraders',
  array['Flutter', 'Dart', 'Cubit', 'Dio', 'REST APIs', 'Shared Preferences', 'Localization (EN/AR)', 'Responsive UI'],
  array['Multi-role authentication (Trader, Customer, Delivery).', 'Product catalog and inventory management.', 'Custom Store management.', 'Shopping cart and order processing.', 'Order tracking.', 'Dark & Light theme support.', 'Arabic & English localization.', 'Persistent user sessions.'],
  'Flutter Developer',
  4
);

commit;
