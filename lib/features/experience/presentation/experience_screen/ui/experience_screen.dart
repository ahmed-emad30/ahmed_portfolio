import 'package:flutter/material.dart';
import 'package:portfolio/features/experience/presentation/experience_screen/ui/widgets/experience_body.dart' show ExperienceBody;

import '../../../../../core/widgets/main_widgets/app_scaffold.dart' show AppScaffold;

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: const ExperienceBody());
  }
}