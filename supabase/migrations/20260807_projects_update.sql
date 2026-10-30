-- Targets the `portfolio` schema (run after 20261003_portfolio_schema.sql).
-- Already included in supabase/seed/portfolio_seed_from_repo.sql; kept as a re-runnable content update.

-- This script updates the full_description, tech_stack, and features for projects in Supabase.

-- Taggz
UPDATE portfolio.projects
SET full_description = 'Taggz is an event photo-sharing platform that leverages facial recognition and QR technology to simplify event check-in and provide attendees with instant access to their event photos.',
    tech_stack = ARRAY['Flutter', 'Dart', 'Cubit', 'Dio', 'REST APIs', 'Firebase', 'QR Code Integration', 'Face Recognition APIs', 'Cloud Storage'],
    features = ARRAY['Face recognition-based photo discovery.', 'QR code event check-in.', 'Secure photo upload and download.', 'High-resolution media management.', 'Role-based access control.', 'Photo sharing.', 'Authentication and user management.', 'Cross-platform deployment for Android and iOS.']
WHERE slug = 'taggz';

-- iConcierge
UPDATE portfolio.projects
SET full_description = 'iConcierge is a luxury concierge platform designed for El Gouna, providing premium lifestyle services such as yacht bookings, restaurant reservations, spa experiences, private jet charters, and real-time customer communication.',
    tech_stack = ARRAY['Flutter', 'Dart', 'Cubit', 'Firebase', 'REST APIs', 'Dio', 'Google Maps', 'Localization', 'Firebase Cloud Messaging'],
    features = ARRAY['Luxury service booking and reservation management.', 'Real-time chat and customer support.', 'Secure online payments.', 'Push notifications.', 'Responsive cross-platform experience.', 'Multi-language support.', 'Real-time service availability.', 'User profile and booking history.']
WHERE slug = 'iconcierge';

-- WePick
UPDATE portfolio.projects
SET full_description = 'WePick is a localized event planning marketplace that enables users to discover, book, and purchase services for various occasions through a seamless and bilingual mobile experience.',
    tech_stack = ARRAY['Flutter', 'Dart', 'Cubit', 'Dio', 'REST APIs', 'Telr Payment Gateway', 'Firebase', 'Social Login (Google, Apple, Twitter)', 'PDF Generation', 'Localization (EN/AR)'],
    features = ARRAY['Product catalog with advanced search and filtering.', 'Shopping cart, coupons, and secure checkout.', 'Telr payment gateway integration.', 'Social authentication (Google, Apple, Twitter).', 'Invoice generation and PDF download.', 'Order management and payment tracking.', 'Arabic & English localization.', 'Responsive UI for different screen sizes.']
WHERE slug = 'wepick';

-- All Traders
UPDATE portfolio.projects
SET full_description = 'AllTraders is a multi-role e-commerce platform that connects traders, customers, and delivery agents, enabling product management, order processing, and delivery tracking within a unified mobile application.',
    tech_stack = ARRAY['Flutter', 'Dart', 'Cubit', 'Dio', 'REST APIs', 'Shared Preferences', 'Localization (EN/AR)', 'Responsive UI'],
    features = ARRAY['Multi-role authentication (Trader, Customer, Delivery).', 'Product catalog and inventory management.', 'Custom Store management.', 'Shopping cart and order processing.', 'Order tracking.', 'Dark & Light theme support.', 'Arabic & English localization.', 'Persistent user sessions.']
WHERE slug = 'all-traders';
