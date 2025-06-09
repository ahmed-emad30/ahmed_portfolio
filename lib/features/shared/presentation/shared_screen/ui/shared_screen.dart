import 'package:portfolio/features/shared/presentation/shared_screen/ui/widgets/shared_body.dart' show SharedBody;
import 'package:flutter/material.dart';

import '../../../../../core/widgets/main_widgets/app_scaffold.dart' show AppScaffold;

class SharedScreen extends StatelessWidget {
  const SharedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: const SharedBody());
  }
}