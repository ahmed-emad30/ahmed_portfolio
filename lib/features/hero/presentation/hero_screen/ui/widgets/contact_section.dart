import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/utils/url_launcher_helper.dart';
import 'package:portfolio/features/shared/presentation/logic/portfolio_content_cubit.dart';
import 'package:portfolio/gen/assets.gen.dart';

import 'contact_icon.dart';
import 'dashed_line_painter.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key, this.horizontal = false});

  final bool horizontal;

  static const _keys = ['github', 'linkedin', 'email', 'whatsapp', 'cv'];

  @override
  Widget build(BuildContext context) {
    final icons = [
      Assets.images.svg.github,
      Assets.images.svg.linkedIn,
      Assets.images.svg.email,
      Assets.images.svg.whats,
      Assets.images.svg.cv,
    ];

    Future<void> openAt(int index) async {
      final data = context.read<PortfolioContentCubit>().data;
      final url = data.resolveLinkUrl(_keys[index]);
      await UrlLauncherHelper.open(url);
    }

    if (horizontal) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          icons.length,
          (index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: ContactIcon(
              onTap: () => openAt(index),
              child: icons[index],
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: 75.w,
      height: 1.sh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomPaint(
            painter: DashedLinePainter(),
            size: Size(35.w, 0.24.sh),
          ),
          10.h.verticalSpace,
          Padding(
            padding: EdgeInsetsDirectional.only(start: 35.w),
            child: Column(
              children: List.generate(
                icons.length,
                (index) => ContactIcon(
                  onTap: () => openAt(index),
                  child: icons[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
