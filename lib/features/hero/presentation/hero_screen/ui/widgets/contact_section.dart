import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../gen/assets.gen.dart';
import 'contact_icon.dart';
import 'dashed_line_painter.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key, this.horizontal = false});

  final bool horizontal;

  @override
  Widget build(BuildContext context) {
    final contacts = [
      Assets.images.svg.github,
      Assets.images.svg.linkedIn,
      Assets.images.svg.email,
      Assets.images.svg.whats,
      Assets.images.svg.cv,
    ];

    if (horizontal) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: contacts
            .map(
              (icon) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: ContactIcon(onTap: () {}, child: icon),
              ),
            )
            .toList(),
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
                contacts.length,
                (index) => ContactIcon(
                  onTap: () {},
                  child: contacts[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
