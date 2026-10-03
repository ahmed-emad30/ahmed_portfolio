-- This script updates the skills and skill categories in Supabase.
-- It keeps the 'Languages & Frameworks' category and its skills,
-- and replaces the rest of the categories and skills with the new data.

-- First, delete existing skills that DO NOT belong to 'Languages & Frameworks'
DELETE FROM skills
WHERE category_id IN (
    SELECT id FROM skill_categories WHERE title != 'Languages & Frameworks'
);

-- Next, delete the categories themselves (except 'Languages & Frameworks')
DELETE FROM skill_categories
WHERE title != 'Languages & Frameworks';

-- Insert the new categories and their skills
DO $$
DECLARE
    state_mgmt_id UUID := gen_random_uuid();
    backend_id UUID := gen_random_uuid();
    firebase_id UUID := gen_random_uuid();
    local_storage_id UUID := gen_random_uuid();
    cicd_id UUID := gen_random_uuid();
    publishing_id UUID := gen_random_uuid();
    testing_id UUID := gen_random_uuid();
    tools_id UUID := gen_random_uuid();
    automation_id UUID := gen_random_uuid();
    dev_practices_id UUID := gen_random_uuid();
BEGIN
    -- 1. State Management
    INSERT INTO skill_categories (id, title, sort_order) VALUES (state_mgmt_id, 'State Management', 2);
    INSERT INTO skills (category_id, name, proficiency, color_hex, sort_order) VALUES
        (state_mgmt_id, 'BLoC (Cubit)', 95, '#B6FF85', 1),
        (state_mgmt_id, 'Provider', 90, '#85E3FF', 2),
        (state_mgmt_id, 'Riverpod', 90, '#FFE885', 3),
        (state_mgmt_id, 'GetX', 85, '#FF8585', 4);

    -- 2. Backend Integration
    INSERT INTO skill_categories (id, title, sort_order) VALUES (backend_id, 'Backend Integration', 3);
    INSERT INTO skills (category_id, name, proficiency, color_hex, sort_order) VALUES
        (backend_id, 'RESTful APIs', 95, '#FFE885', 1),
        (backend_id, 'Dio', 95, '#85E3FF', 2),
        (backend_id, 'HTTP', 90, '#B6FF85', 3),
        (backend_id, 'JSON Serialization', 90, '#FF8585', 4),
        (backend_id, 'WebSockets', 85, '#FFE885', 5);

    -- 3. Firebase
    INSERT INTO skill_categories (id, title, sort_order) VALUES (firebase_id, 'Firebase', 4);
    INSERT INTO skills (category_id, name, proficiency, color_hex, sort_order) VALUES
        (firebase_id, 'Authentication', 95, '#B6FF85', 1),
        (firebase_id, 'Cloud Firestore', 90, '#85E3FF', 2),
        (firebase_id, 'Cloud Messaging (FCM)', 90, '#FFE885', 3),
        (firebase_id, 'Crashlytics', 85, '#FF8585', 4),
        (firebase_id, 'Analytics', 85, '#B6FF85', 5),
        (firebase_id, 'Firebase hosting', 85, '#85E3FF', 6),
        (firebase_id, 'Firebase Database (real time database)', 85, '#FFE885', 7),
        (firebase_id, 'Firebase Dynamics', 80, '#FF8585', 8);

    -- 4. Local Storage
    INSERT INTO skill_categories (id, title, sort_order) VALUES (local_storage_id, 'Local Storage', 5);
    INSERT INTO skills (category_id, name, proficiency, color_hex, sort_order) VALUES
        (local_storage_id, 'Hive', 95, '#B6FF85', 1),
        (local_storage_id, 'SharedPreferences', 95, '#85E3FF', 2),
        (local_storage_id, 'Secure Storage', 90, '#FFE885', 3),
        (local_storage_id, 'SQLite', 85, '#FF8585', 4);

    -- 5. CI/CD & DevOps
    INSERT INTO skill_categories (id, title, sort_order) VALUES (cicd_id, 'CI/CD & DevOps', 6);
    INSERT INTO skills (category_id, name, proficiency, color_hex, sort_order) VALUES
        (cicd_id, 'GitHub Actions', 90, '#85E3FF', 1),
        (cicd_id, 'Codemagic', 90, '#B6FF85', 2),
        (cicd_id, 'Shorebird', 85, '#FFE885', 3),
        (cicd_id, 'Fastlane', 85, '#FF8585', 4),
        (cicd_id, 'Flutter Flavors', 90, '#85E3FF', 5),
        (cicd_id, 'App Distribution', 85, '#B6FF85', 6);

    -- 6. Publishing
    INSERT INTO skill_categories (id, title, sort_order) VALUES (publishing_id, 'Publishing', 7);
    INSERT INTO skills (category_id, name, proficiency, color_hex, sort_order) VALUES
        (publishing_id, 'Google Play Console', 95, '#B6FF85', 1),
        (publishing_id, 'Apple App Store Connect', 90, '#85E3FF', 2),
        (publishing_id, 'Huawei AppGallery', 90, '#FFE885', 3);

    -- 7. Testing & Debugging
    INSERT INTO skill_categories (id, title, sort_order) VALUES (testing_id, 'Testing & Debugging', 8);
    INSERT INTO skills (category_id, name, proficiency, color_hex, sort_order) VALUES
        (testing_id, 'Unit Testing', 85, '#B6FF85', 1),
        (testing_id, 'Widget Testing', 85, '#85E3FF', 2),
        (testing_id, 'Integration Testing', 80, '#FFE885', 3),
        (testing_id, 'E2E testing', 80, '#FF8585', 4),
        (testing_id, 'Performance Optimization', 85, '#B6FF85', 5),
        (testing_id, 'Memory Leak Analysis', 80, '#85E3FF', 6);

    -- 8. Tools
    INSERT INTO skill_categories (id, title, sort_order) VALUES (tools_id, 'Tools', 9);
    INSERT INTO skills (category_id, name, proficiency, color_hex, sort_order) VALUES
        (tools_id, 'Git', 95, '#B6FF85', 1),
        (tools_id, 'Android Studio', 95, '#85E3FF', 2),
        (tools_id, 'Xcode', 90, '#FFE885', 3),
        (tools_id, 'VS Code', 95, '#FF8585', 4),
        (tools_id, 'Postman', 90, '#B6FF85', 5),
        (tools_id, 'Figma', 85, '#85E3FF', 6),
        (tools_id, 'Jira', 85, '#FFE885', 7),
        (tools_id, 'Firebase Console', 90, '#FF8585', 8);

    -- 9. Automation & Scripting
    INSERT INTO skill_categories (id, title, sort_order) VALUES (automation_id, 'Automation & Scripting', 10);
    INSERT INTO skills (category_id, name, proficiency, color_hex, sort_order) VALUES
        (automation_id, 'Bash', 85, '#B6FF85', 1),
        (automation_id, 'Dart Scripts', 90, '#85E3FF', 2),
        (automation_id, 'Build Automation', 85, '#FFE885', 3),
        (automation_id, 'Rebranding Automation', 85, '#FF8585', 4),
        (automation_id, 'Codemagic', 90, '#B6FF85', 5),
        (automation_id, 'Fastlane', 85, '#85E3FF', 6),
        (automation_id, 'CI/CD', 90, '#FFE885', 7);

    -- 10. Development Practices
    INSERT INTO skill_categories (id, title, sort_order) VALUES (dev_practices_id, 'Development Practices', 11);
    INSERT INTO skills (category_id, name, proficiency, color_hex, sort_order) VALUES
        (dev_practices_id, 'Agile (Scrum)', 95, '#B6FF85', 1),
        (dev_practices_id, 'Code Review', 95, '#85E3FF', 2),
        (dev_practices_id, 'Technical Documentation', 90, '#FFE885', 3),
        (dev_practices_id, 'SDLC', 90, '#FF8585', 4);

END $$;
