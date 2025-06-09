import 'package:flutter/material.dart' show Canvas, CustomPainter, Offset, Paint, Size;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/app_themes/colors/app_colors.dart' show AppColors;

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 9, dashSpace = 5, startX = 0;
    final paint =
    Paint()
      ..color = AppColors.primary
      ..strokeWidth = 3.w;
    while (startX < 0.24.sh) {
      canvas.drawLine(
        Offset(50.w, startX),
        Offset(50.w, startX + dashWidth),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
