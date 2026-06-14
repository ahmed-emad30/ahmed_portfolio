# Gemini CLI Context: Portfolio Flutter Project

This project is a personal portfolio application built with Flutter, following a modular and clean architecture pattern.

## Project Overview

- **Purpose:** Personal portfolio showcasing projects, skills, and experience.
- **Main Technologies:**
  - **Framework:** Flutter (SDK ^3.7.0)
  - **State Management:** [flutter_bloc](https://pub.dev/packages/flutter_bloc) (Bloc/Cubit)
  - **Routing:** [go_router](https://pub.dev/packages/go_router)
  - **Dependency Injection:** [get_it](https://pub.dev/packages/get_it) & [injectable](https://pub.dev/packages/injectable)
  - **Networking:** [dio](https://pub.dev/packages/dio) with [talker_dio_logger](https://pub.dev/packages/talker_dio_logger)
  - **UI/UX:** [flutter_screenutil](https://pub.dev/packages/flutter_screenutil), [flutter_svg](https://pub.dev/packages/flutter_svg), [skeletonizer](https://pub.dev/packages/skeletonizer)
  - **Code Generation:** [build_runner](https://pub.dev/packages/build_runner), [freezed](https://pub.dev/packages/freezed), [flutter_gen](https://pub.dev/packages/flutter_gen)

## Architecture

The project follows a feature-based architecture:
- **`lib/core/`**: Contains cross-cutting concerns, shared widgets, theme logic, and global utilities.
  - `api/`: Networking and API consumption logic.
  - `app/`: Main application widget and configuration.
  - `app_routes/`: Navigation configuration using GoRouter.
  - `app_themes/`: Theme data and logic (Cubit).
  - `helpers/`: Utilities like localization, validations, and observers.
  - `utils/`: Constants, extensions, and service locator.
  - `widgets/`: Reusable UI components.
- **`lib/features/`**: Contains domain-specific features (e.g., about, contact, portfolio, skills).
  - Each feature typically follows a `data`, `domain`, and `presentation` structure.
- **`lib/gen/`**: Auto-generated assets and fonts.

## Building and Running

### Prerequisites
- Flutter SDK installed and configured.
- `build_runner` for code generation.

### Key Commands
- **Run Application:** `flutter run`
- **Build Web:** `flutter build web`
- **Generate Code (Freezed, Injectable, etc.):** `flutter pub run build_runner build --delete-conflicting-outputs`
- **Watch Code Changes for Generation:** `flutter pub run build_runner watch --delete-conflicting-outputs`
- **Linting:** `flutter analyze`

## Development Conventions

- **State Management:** Use Cubits for simple state and Blocs for more complex event-driven logic.
- **Dependency Injection:** Register new services and repositories in `lib/core/utils/service_locator.dart`.
- **UI Responsiveness:** Use `ScreenUtil` for scaling dimensions (w, h, r, sp) based on the design size (1280x843).
- **Assets:** Add assets to `assets/` and run `build_runner` to update `lib/gen/assets.gen.dart`. Use `Assets.path.to.image.image()` to reference them.
- **Navigation:** Define new routes in `Routes` strings and add them to `AppRouter` or `PortfolioApp` router configuration.
- **Clean Code:** Adhere to `package:flutter_lints` rules. Prefer surgical edits and maintain existing architectural patterns.
