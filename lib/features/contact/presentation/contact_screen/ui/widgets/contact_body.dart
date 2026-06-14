import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/app_colors.dart';
import 'package:portfolio/core/app_themes/text_style/app_text_style.dart';

import '../../../../../../gen/assets.gen.dart' show Assets, SvgGenImage;

class ContactBody extends StatelessWidget {
  const ContactBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        32.verticalSpace,
        GradientStrokeText(),
        SizedBox(
          width: 0.8.sw,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            spacing: 20.w,
            children: [
              ScanQrCode(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 20.h,
                children: [
                  ContactInputField(hint: 'Your Name',),
                  ContactInputField(hint: 'Email',),
                  ContactInputField(hint: 'Phone Number',),
                  ContactInputField(hint: 'How can I help?',maxLines: 7,),
                  SizedBox(
                    width: 425.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // spacing: 24.w,
                      children: [
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        height: 56.dm,

                        padding: EdgeInsets.symmetric(horizontal: 33.w,vertical: 18.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text('Send Message',style: AppTextStyle.style16Medium.copyWith(
                            color: AppColors.whiteText,
                          height: 1.25,        // 20 / 16 = 1.25
                          letterSpacing: -0.32, // -2% of 16 = -0.32

                        ),),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        width: 56.dm,
                        height: 56.dm,
                        // padding: EdgeInsets.symmetric(horizontal: 33.w,vertical: 18.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Assets.images.svg.whats.svg(
                          colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    DashedIconButton(icon: Assets.images.svg.email,),
                    DashedIconButton(icon: Assets.images.svg.linkedIn,),
                    DashedIconButton(icon: Assets.images.svg.x,),
                      ],
                    ),
                  )
                ],
              )

            ],
          ),
        )
      ],
    );
  }
}

class DashedIconButton extends StatelessWidget {
  const DashedIconButton({
    super.key, required this.icon, this.onTap,
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
        dashPattern: [6, 3],
        borderType: BorderType.RRect,
        radius: Radius.circular(10.r),
        // Optional: for rounded corners
    padding: EdgeInsets.zero,
        borderPadding: EdgeInsets.zero,
        child: Container(
          width: 56.dm,
          height: 56.dm,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          alignment: Alignment.center,

          child: icon.svg(
            width: 20.dm,
            height: 20.dm,
          ),
        ),
      ),
    );
  }
}

class ContactInputField extends StatelessWidget {
  const ContactInputField({
    super.key, this.inputType= TextInputType.text, this.validator, this.onChanged, this.maxLines, required this.hint,
  });
// final TextEditingController controller = TextEditingController();
final TextInputType inputType ;
final String? Function(String?)? validator;
final String? Function(String?)? onChanged;
final int? maxLines;
final String hint;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.r),
      borderSide: BorderSide(color: AppColors.primary,width: 1.4.dm),
    );
    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.r),
      borderSide: BorderSide(color: AppColors.red,width: 1.4.dm),
    );
    return Padding(
      padding:  REdgeInsetsDirectional.only(end: 13),
      child: TextFormField(
        // controller: controller,
        keyboardType: inputType,
        cursorColor: AppColors.primary,
        maxLines: maxLines,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.top,
        style:
        AppTextStyle.style16Medium.copyWith(
          color: AppColors.black,
          height: 1.25,           // 20 / 16 = 1.25
          letterSpacing: -0.32,
        ),
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyle.style16Medium.copyWith(
            color: AppColors.secondary,
            height: 1.25,           // 20 / 16 = 1.25
            letterSpacing: -0.32,
          ),
          contentPadding: REdgeInsets.symmetric(horizontal: 24,vertical: 18),
          border: border,
          enabledBorder: border,
          disabledBorder: border,
          focusedBorder: border,
          errorBorder: errorBorder,
          focusedErrorBorder: errorBorder,
          constraints: BoxConstraints(
            maxWidth: 425.w
          )
        ),
      ),
    );
  }
}

class ScanQrCode extends StatelessWidget {
  const ScanQrCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.36.sw,
      height: 0.63.sh,
      child: Column(
        children: [
          Expanded(child: Assets.images.photos.scanQr.image(/*height: 520.h*/)),
          16.verticalSpace,
          Text('I seek to push the limits of creativity to create high-engaging,\nuser-friendly, and memorable interactive experiences.',textAlign: TextAlign.center,maxLines: 2,style: AppTextStyle.style16Medium.copyWith(
            color: AppColors.fillColor,
            height: 1.5,
            letterSpacing: 0.32,
          ))
        ],
      ),
    );
  }
}

class GradientStrokeText extends StatelessWidget {
  const GradientStrokeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [
            AppColors.primary,AppColors.secondary],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: Text(
        "Let’s Connect!",
        style: AppTextStyle.style154ExtraBold.copyWith(
          fontSize: 154,
          height: 0.8,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2, // Adjust stroke thickness
          // The shader will apply here
        ),
      ),
    );
  }
}