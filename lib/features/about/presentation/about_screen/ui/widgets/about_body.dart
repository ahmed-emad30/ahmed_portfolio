
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/app_themes/text_style/app_text_style.dart';

import '../../../../../../core/utils/app_methods.dart' show AppMethods;
import '../../../../../../gen/assets.gen.dart' show Assets;

class AboutBody extends StatelessWidget {
  const AboutBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return Padding(
      padding: EdgeInsets.only(top: 120.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Ahmed\nEmad.',

            style: AppTextStyle.style96ExtraBold.copyWith(
              height: 0.8,
              letterSpacing: 0,
              foreground:
              AppMethods.textStroke(color: theme.primaryAccent),
            ),
          ),
          16.verticalSpace,
          SizedBox(
            width: 0.35.sw,
            child: Text(
              '''Flutter Developer with 2+ years of experience building and publishing 15+ cross-platform mobile apps on the App Store, Google Play, and Huawei AppGallery. Skilled in Dart, Flutter, REST APIs, Firebase, and state management using Cubit. Proven ability to design responsive UIs, implement real-time features, and support localization (Arabic/English). Passionate about clean code, performance optimization, and delivering user-focused mobile experiences
    ''',
              textDirection: TextDirection.ltr,

              style: AppTextStyle.style24Regular.copyWith(
                height: 26 / 24.spMin,
                letterSpacing: 0,
                color: theme.bodyText,
              ),
            ),
          ),
        ],
      ),
    );
  }


}
