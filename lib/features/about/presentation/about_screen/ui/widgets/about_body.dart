
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/utils/app_methods.dart';
import 'package:portfolio/core/utils/responsive_values.dart';
import 'package:portfolio/gen/assets.gen.dart';
import 'package:portfolio/core/app_themes/text_style/app_text_style.dart';

class AboutBody extends StatelessWidget {
  const AboutBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    final content = Padding(
      padding: EdgeInsets.only(
        top: context.sectionTopPadding,
        bottom: context.isMobile ? 24.h : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ahmed\nEmad.',
            style: AppTextStyle.style96ExtraBold.merge(
              TextStyle(
                fontSize: context.responsiveSp(
                  mobile: 48,
                  tablet: 72,
                  desktop: 96,
                ),
                height: 0.8,
                letterSpacing: 0,
                foreground: AppMethods.textStroke(color: theme.primaryAccent),
              ),
            ),
          ),
          16.verticalSpace,
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: context.isMobile ? double.infinity : 0.45.sw,
            ),
            child: Text(
              '''Flutter Developer with 2+ years of experience building and publishing 15+ cross-platform mobile apps on the App Store, Google Play, and Huawei AppGallery. Skilled in Dart, Flutter, REST APIs, Firebase, and state management using Cubit. Proven ability to design responsive UIs, implement real-time features, and support localization (Arabic/English). Passionate about clean code, performance optimization, and delivering user-focused mobile experiences''',
              textDirection: TextDirection.ltr,
              style: AppTextStyle.style24Regular.copyWith(
                fontSize: context.responsiveSp(
                  mobile: 16,
                  tablet: 20,
                  desktop: 24,
                ),
                height: context.isMobile ? 1.5 : 26 / 24.spMin,
                letterSpacing: 0,
                color: theme.bodyText,
              ),
            ),
          ),
          if (context.isMobileOrTablet) ...[
            32.verticalSpace,
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Assets.images.photos.sideProfile.image(
                fit: BoxFit.cover,
                width: double.infinity,
                // Keep image below the bio so it never covers copy on mobile.
                height: context.isTablet ? 360.h : 220.h,
              ),
            ),
          ],
        ],
      ),
    );

    if (context.isMobile) {
      return SingleChildScrollView(child: content);
    }
    return content;
  }
}
