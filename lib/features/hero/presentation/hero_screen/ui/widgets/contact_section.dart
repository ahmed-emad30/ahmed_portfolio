import 'package:flutter/material.dart' show BuildContext, Column, CrossAxisAlignment, CustomPaint, EdgeInsetsDirectional, Padding, Size, SizedBox, StatelessWidget, Widget;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../gen/assets.gen.dart' show $AssetsImagesSvgGen;
import 'contact_icon.dart' show ContactIcon;
import 'dashed_line_painter.dart' show DashedLinePainter;

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final contacts = [
      $AssetsImagesSvgGen().github,
      $AssetsImagesSvgGen().linkedIn,
      $AssetsImagesSvgGen().email,
      $AssetsImagesSvgGen().whats,
      $AssetsImagesSvgGen().cv,
    ];
    return SizedBox(
      width: 75.w,
      height: 1.sh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomPaint(painter: DashedLinePainter(), size: Size(35.w, 0.24.sh)),
          10.h.verticalSpace,
          Padding(
            padding: EdgeInsetsDirectional.only(start: 35.w),

            child: Column(
              children: List<Widget>.generate(
                contacts.length,
                    (index) => ContactIcon(onTap: () {}, child: contacts[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
