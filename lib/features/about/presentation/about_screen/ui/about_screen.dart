import 'package:flutter/material.dart';
import 'package:portfolio/features/about/presentation/about_screen/ui/widgets/about_body.dart' show AboutBody;

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const AboutBody());
  }
}