import 'package:flutter/material.dart';
import 'package:portfolio/features/services/presentation/services_screen/ui/widgets/services_body.dart' show ServicesBody;

import '../../../../../core/widgets/main_widgets/app_scaffold.dart' show AppScaffold;

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: const ServicesBody());
  }
}