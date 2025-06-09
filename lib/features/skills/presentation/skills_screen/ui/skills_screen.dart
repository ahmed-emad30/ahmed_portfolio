import 'package:flutter/material.dart';
import 'package:portfolio/features/skills/presentation/skills_screen/ui/widgets/skills_body.dart' show SkillsBody;

import '../../../../../core/widgets/main_widgets/app_scaffold.dart' show AppScaffold;

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: const SkillsBody());
  }
}