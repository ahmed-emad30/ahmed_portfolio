import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/app_colors.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/app_themes/text_style/app_text_style.dart';
import 'package:portfolio/core/utils/responsive_values.dart';
import 'package:portfolio/gen/assets.gen.dart';

class ContactBody extends StatelessWidget {
  const ContactBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
/*      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,*/
        children: [
          32.verticalSpace,
          const GradientStrokeText(),
          if (context.isMobileOrTablet)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24.h,
              children: const [
                ScanQrCode(),
                ContactFormSection(),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 32.w,
              children: const [
                Flexible(child: ScanQrCode()),
                Expanded(child: ContactFormSection()),
              ],
            ),
        ],
      // ),
    );
  }
}

class ContactFormSection extends StatelessWidget {
  const ContactFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 20.h,
      children: const [
        ContactInputField(hint: 'Your Name'),
        ContactInputField(hint: 'Email'),
        ContactInputField(hint: 'Phone Number'),
        ContactInputField(hint: 'How can I help?', maxLines: 7),
        ContactActionsRow(),
      ],
    );
  }
}

class ContactActionsRow extends StatelessWidget {
  const ContactActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.isMobileOrTablet) {
      return Wrap(
        spacing: 12.w,
        runSpacing: 12.h,
        children: [
          SendMessageButton(),
          WhatsAppButton(),
          DashedIconButton(icon: Assets.images.svg.email),
          DashedIconButton(icon: Assets.images.svg.linkedIn),
          DashedIconButton(icon: Assets.images.svg.x),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SendMessageButton(),
        WhatsAppButton(),
        DashedIconButton(icon: Assets.images.svg.email),
        DashedIconButton(icon: Assets.images.svg.linkedIn),
        DashedIconButton(icon: Assets.images.svg.x),
      ],
    );
  }
}

class SendMessageButton extends StatelessWidget {
  const SendMessageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 56.dm,
        padding: EdgeInsets.symmetric(horizontal: 33.w, vertical: 18.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          'Send Message',
          style: AppTextStyle.style16Medium.copyWith(
            color: AppColors.whiteText,
            height: 1.25,
            letterSpacing: -0.32,
          ),
        ),
      ),
    );
  }
}

class WhatsAppButton extends StatelessWidget {
  const WhatsAppButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 56.dm,
        height: 56.dm,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Assets.images.svg.whats.svg(
          colorFilter: const ColorFilter.mode(
            AppColors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class DashedIconButton extends StatelessWidget {
  const DashedIconButton({
    super.key,
    required this.icon,
    this.onTap,
  });

  final SvgGenImage icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        color: AppColors.primary,
        strokeWidth: 2,
        dashPattern: const [6, 3],
        borderType: BorderType.RRect,
        radius: Radius.circular(10.r),
        padding: EdgeInsets.zero,
        borderPadding: EdgeInsets.zero,
        child: Container(
          width: 56.dm,
          height: 56.dm,
          alignment: Alignment.center,
          child: icon.svg(width: 20.dm, height: 20.dm),
        ),
      ),
    );
  }
}

class ContactInputField extends StatelessWidget {
  const ContactInputField({
    super.key,
    this.inputType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.maxLines,
    required this.hint,
  });

  final TextInputType inputType;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final int? maxLines;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.r),
      borderSide: BorderSide(color: theme.primaryAccent, width: 1.4.dm),
    );

    return TextFormField(
      keyboardType: inputType,
      cursorColor: theme.primaryAccent,
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
      style: AppTextStyle.style16Medium.copyWith(
        color: theme.bodyText,
        height: 1.25,
      ),
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyle.style16Medium.copyWith(
          color: theme.bodyText.withValues(alpha: 0.7),
          height: 1.25,
        ),
        contentPadding: REdgeInsets.symmetric(horizontal: 24, vertical: 18),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }
}

class ScanQrCode extends StatelessWidget {
  const ScanQrCode({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return SizedBox(
      width: context.isMobile ? double.infinity : 0.36.sw,
      child: Column(
        children: [
          Assets.images.photos.scanQr.image(),
          16.verticalSpace,
          Text(
            'I seek to push the limits of creativity to create high-engaging, user-friendly, and memorable interactive experiences.',
            textAlign: TextAlign.center,
            style: AppTextStyle.style16Medium.copyWith(
              color: theme.bodyText,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class GradientStrokeText extends StatelessWidget {
  const GradientStrokeText({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: Text(
        "Let's Connect!",
        style: AppTextStyle.style154ExtraBold.copyWith(
          fontSize: context.responsiveSp(
            mobile: 48,
            tablet: 96,
            desktop: 154,
          ),
          height: 0.8,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2,
        ),
      ),
    );
  }
}
