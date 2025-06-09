import 'package:flutter/material.dart';
import 'package:portfolio/features/contact/presentation/contact_screen/ui/widgets/contact_body.dart' show ContactBody;

import '../../../../../core/widgets/main_widgets/app_scaffold.dart' show AppScaffold;

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: const ContactBody());
  }
}