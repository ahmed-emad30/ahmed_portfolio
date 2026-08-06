import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/navigation/section_navigation.dart';
import 'package:portfolio/core/utils/app_constants.dart';
import 'package:portfolio/core/utils/responsive_values.dart';
import 'package:portfolio/core/widgets/theme_toggle_button.dart';
import 'package:portfolio/features/shared/presentation/logic/portfolio_content_cubit.dart';
import 'package:portfolio/gen/assets.gen.dart';

import '../../../../../../core/app_themes/text_style/app_text_style.dart';
import '../../../../../shared/domain/entity/navigator_item_entity.dart';
import 'contact_section.dart';

class HeroBody extends StatelessWidget {
  const HeroBody({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return const _HeroMobileLayout();
    }
    if (context.isTablet) {
      return const _HeroTabletLayout();
    }
    return const _HeroDesktopLayout();
  }
}

class _HeroDesktopLayout extends StatelessWidget {
  const _HeroDesktopLayout();

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return SizedBox(
      width: 1.sw,
      height: 1.sh,
      child: Row(
        children: [
          const ContactSection(),
          Expanded(
            child: Row(
              spacing: 32.w,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: _ProfileImage(theme: theme),
                ),

                Expanded(
                  child: _HeroContent(
                    showThemeToggle: true,
                    navFlex: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroTabletLayout extends StatelessWidget {
  const _HeroTabletLayout();

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 72.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 420.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _ProfileImage(theme: theme, compact: true)),
                24.horizontalSpace,
                Expanded(
                  child: _HeroContent(
                    showThemeToggle: false,
                    navFlex: false,
                  ),
                ),
              ],
            ),
          ),
          24.verticalSpace,
          const ContactSection(horizontal: true),
        ],
      ),
    );
  }
}

class _HeroMobileLayout extends StatelessWidget {
  const _HeroMobileLayout();

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;
    final profile = context.watch<PortfolioContentCubit>().data.profile;


    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 72.h, 0.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            // height: 0.75.sh,
            width: double.infinity,
            child: _ProfileImage(theme: theme, compact: true),
          ),
          24.verticalSpace,
          AutoSizeText(
            profile.displayNameWithBreak,
            maxLines: 2,
            minFontSize: 28,
            style: AppTextStyle.style96ExtraBold.copyWith(
              fontSize: context.responsiveSp(
                mobile: 48,
                tablet: 64,
                desktop: 96,
              ),
              height: 0.8,
              color: theme.primaryAccent,
            ),
          ),
          12.verticalSpace,
          Text(
            profile.title,
            style: AppTextStyle.style36Bold.copyWith(
              fontSize: context.responsiveSp(
                mobile: 22,
                tablet: 28,
                desktop: 36,
              ),
              color: theme.bodyText,
            ),
          ),
          32.verticalSpace,
          const ContactSection(horizontal: true),
        ],
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage({required this.theme, this.compact = false});

  final PortfolioThemeExtension theme;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final image = theme.profileBlendMode == BlendMode.luminosity
        ? ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Colors.grey,
              BlendMode.color,
            ),
            child: Assets.images.photos.frontProfile.image(
              fit: BoxFit.cover,
              height: compact ? null : 1.sh,
              width: double.infinity,
            ),
          )
        : Assets.images.photos.frontProfile.image(
            fit: BoxFit.cover,
            height: compact ? null : 1.sh,
            width: double.infinity,
          );

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border(
          right: compact
              ? BorderSide.none
              : BorderSide(width: 30.w, color: theme.primaryAccent),
        ),
      ),
      child: image,
    );
  }
}

class _HeroContent extends StatelessWidget {
  const _HeroContent({
    required this.showThemeToggle,
    required this.navFlex,
  });

  final bool showThemeToggle;
  final bool navFlex;

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;
    final profile = context.watch<PortfolioContentCubit>().data.profile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showThemeToggle)
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Padding(
              padding: EdgeInsetsDirectional.only(end: 24.w, top: 8.h),
              child: const ThemeToggleButton(),
            ),
          ),
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AutoSizeText(
                  profile.displayNameWithBreak,
                  maxLines: 2,
                  minFontSize: 10,
                  style: AppTextStyle.style96ExtraBold.copyWith(
                    fontSize: context.responsiveSp(
                      mobile: 48,
                      tablet: 72,
                      desktop: 96,
                    ),
                    height: 0.8,
                    color: theme.primaryAccent,
                  ),
                ),
              ),
              Expanded(
                child: AutoSizeText(
                  profile.title,
                  maxLines: 1,
                  minFontSize: 10,
                  style: AppTextStyle.style36Bold.copyWith(
                    color: theme.bodyText,
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              AppConstants.items.length,
              (index) => SideMenuItem(
                item: AppConstants.items[index],
                isActive: index == 0,
                compact: !navFlex,
              ),
            ),
          ),
        ),
        if (navFlex) const Spacer(flex: 1),
      ],
    );
  }
}

class SideMenuItem extends StatelessWidget {
  const SideMenuItem({
    super.key,
    required this.item,
    required this.isActive,
    this.compact = false,
  });

  final NavigatorItemEntity item;
  final bool isActive;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    final content = GestureDetector(
      onTap: () => SectionNavigation.go(context, item.route),
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: compact ? 8 : 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isActive)
              Container(
                width: 5.w,
                height: compact ? 28.h : 50.h,
                margin: EdgeInsetsDirectional.only(end: 15.w),
                decoration: BoxDecoration(
                  color: theme.primaryAccent,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
            AutoSizeText(
              item.title.toUpperCase(),
              maxLines: 1,
              style: AppTextStyle.style32Regular.copyWith(
                fontSize: context.responsiveSp(
                  mobile: 18,
                  tablet: 24,
                  desktop: 32,
                ),
                color: theme.bodyText,
              ),
            ),
          ],
        ),
      ),
    );

    return compact ? content : Expanded(child: content);
  }
}
