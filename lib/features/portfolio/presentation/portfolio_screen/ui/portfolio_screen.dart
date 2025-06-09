import 'package:flutter/material.dart';
import 'package:portfolio/features/portfolio/presentation/portfolio_screen/ui/widgets/portfolio_body.dart' show PortfolioBody;

import '../../../../../core/widgets/main_widgets/app_scaffold.dart' show AppScaffold;

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: const PortfolioBody());
  }
}