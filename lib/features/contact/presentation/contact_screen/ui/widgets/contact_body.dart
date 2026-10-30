import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portfolio/core/app_themes/colors/app_colors.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/app_themes/text_style/app_text_style.dart';
import 'package:portfolio/core/utils/responsive_values.dart';
import 'package:portfolio/core/utils/url_launcher_helper.dart';
import 'package:portfolio/features/contact/presentation/contact_screen/logic/contact_cubit.dart';
import 'package:portfolio/features/shared/presentation/logic/portfolio_content_cubit.dart';
import 'package:portfolio/gen/assets.gen.dart';

class ContactBody extends StatelessWidget {
  const ContactBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
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
    );
  }
}

class ContactFormSection extends StatefulWidget {
  const ContactFormSection({super.key});

  @override
  State<ContactFormSection> createState() => _ContactFormSectionState();
}

class _ContactFormSectionState extends State<ContactFormSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    await context.read<ContactCubit>().submit(
          name: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          message: _messageController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactCubit, ContactState>(
      listener: (context, state) {
        if (state is ContactSuccessState) {
          _nameController.clear();
          _emailController.clear();
          _phoneController.clear();
          _messageController.clear();
          Fluttertoast.showToast(msg: 'Message sent successfully');
          context.read<ContactCubit>().reset();
        } else if (state is ContactFailureState) {
          Fluttertoast.showToast(msg: 'Failed to send message. Try again.');
          context.read<ContactCubit>().reset();
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 20.h,
          children: [
            16.verticalSpace,
            ContactInputField(
              hint: 'Your Name',
              controller: _nameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
            ),
            ContactInputField(
              hint: 'Email',
              controller: _emailController,
              inputType: TextInputType.emailAddress,
              validator: (value) {
                final email = value?.trim() ?? '';
                if (email.isEmpty) return 'Email is required';
                if (!email.contains('@')) return 'Enter a valid email';
                return null;
              },
            ),
            ContactInputField(
              hint: 'Phone Number',
              controller: _phoneController,
              inputType: TextInputType.phone,
            ),
            ContactInputField(
              hint: 'How can I help?',
              controller: _messageController,
              maxLines: 7,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Message is required';
                }
                return null;
              },
            ),
            SendMessageButton(onSend: _submit),
            const ContactSocialsRow(),
            8.verticalSpace
          ],
        ),
      ),
    );
  }
}

class ContactSocialsRow extends StatelessWidget {
  const ContactSocialsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<PortfolioContentCubit>().data;

    final actions = [
      WhatsAppButton(
        tooltip: 'WhatsApp',
        onTap: () => UrlLauncherHelper.open(data.resolveLinkUrl('whatsapp')),
      ),
      DashedIconButton(
        icon: Assets.images.svg.email,
        tooltip: 'Email',
        onTap: () => UrlLauncherHelper.open(data.resolveLinkUrl('email')),
      ),
      DashedIconButton(
        icon: Assets.images.svg.linkedIn,
        tooltip: 'LinkedIn',
        onTap: () => UrlLauncherHelper.open(data.resolveLinkUrl('linkedin')),
      ),
      DashedIconButton(
        icon: Assets.images.svg.x,
        tooltip: 'X (Twitter)',
        onTap: () => UrlLauncherHelper.open(data.resolveLinkUrl('x')),
      ),
    ];

/*    if (context.isMobileOrTablet) {
      return Wrap(
        spacing: 12.w,
        runSpacing: 12.h,
        alignment: WrapAlignment.center,
        // runAlignment: WrapAlignment.center,
        // children: actions,
      );
    }*/

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 12.w,
      children: actions,
    );
  }
}

class SendMessageButton extends StatelessWidget {
  const SendMessageButton({super.key, required this.onSend});

  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final isSubmitting =
        context.watch<ContactCubit>().state is ContactSubmittingState;

    return GestureDetector(
      onTap: isSubmitting ? null : onSend,
      child: Container(
        width: double.infinity,
        height: 48,
        padding: EdgeInsets.symmetric(horizontal: 17.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: isSubmitting
            ? SizedBox(
                width: 20.dm,
                height: 20.dm,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.white,
                ),
              )
            : Text(
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
  const WhatsAppButton({super.key, this.onTap, required this.tooltip});

  final VoidCallback? onTap;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return _LabeledTapTarget(
      tooltip: tooltip,
      onTap: onTap,
      child: Container(
        width: 35.dm,
        height: 35.dm,
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
    required this.tooltip,
    this.onTap,
  });

  final SvgGenImage icon;
  final String tooltip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _LabeledTapTarget(
      tooltip: tooltip,
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
          width: 35.dm,
          height: 35.dm,
          alignment: Alignment.center,
          child: icon.svg(width: 20.dm, height: 20.dm),
        ),
      ),
    );
  }
}

/// Icon-only button: adds a tooltip, a screen reader label and a 48px
/// minimum hit area around the 35px visual.
class _LabeledTapTarget extends StatelessWidget {
  const _LabeledTapTarget({
    required this.tooltip,
    required this.onTap,
    required this.child,
  });

  final String tooltip;
  final VoidCallback? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        label: tooltip,
        excludeSemantics: true,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              child: Center(widthFactor: 1, heightFactor: 1, child: child),
            ),
          ),
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
    this.controller,
    this.maxLines,
    required this.hint,
  });

  final TextInputType inputType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
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
      controller: controller,
      keyboardType: inputType,
      cursorColor: theme.primaryAccent,
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
      style: AppTextStyle.style16Medium.copyWith(
        color: theme.bodyText,
        height: 1.25,
      ),
      validator: validator,
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
        errorBorder: border,
        focusedErrorBorder: border,
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
          // A phone can't scan its own screen; the WhatsApp/email buttons
          // under the form cover the same need there.
          if (!context.isMobile) ...[
            Assets.images.photos.scanQr.image(),
            16.verticalSpace,
          ],
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
            desktop: 100,
          ),
          // Outline-only text is too thin to read on small screens.
          foreground: Paint()
            ..style =
                context.isMobile ? PaintingStyle.fill : PaintingStyle.stroke
            ..strokeWidth = 2,
        ),
      ),
    );
  }
}
