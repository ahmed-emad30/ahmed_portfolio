import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/app_themes/colors/app_colors.dart';

import '../../../../../../core/app_themes/text_style/app_text_style.dart';
import '../../../../../../core/utils/app_constants.dart' show AppConstants;
import '../../../../../../core/widgets/theme_toggle_button.dart' show ThemeToggleButton;
import '../../../../../../gen/assets.gen.dart';
import '../../../../../shared/domain/entity/navigator_item_entity.dart' show NavigatorItemEntity;
import 'contact_section.dart' show ContactSection;

class HeroBody extends StatelessWidget {
  const HeroBody({super.key});

  @override
  Widget build(BuildContext context) {

    int activeItem = 0;

    return SizedBox(
      width: 1.sw,
      height: 1.sh,

      child: Row(
        children: [
          ContactSection(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Expanded(
                  flex: 1,
                  child: Container(
                    height: 1.sh,
                    padding: EdgeInsets.zero,
                    margin: EdgeInsetsDirectional.only(end: 20.w),
                    clipBehavior: Clip.hardEdge,
                    alignment: AlignmentDirectional.centerEnd,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 30.w,

                          color: AppColors.primary,
                        )
                      ),

                    ),
                    child: $AssetsImagesPhotosGen().frontProfile.image(
                      fit: BoxFit.fitHeight,
                      height: 1.sh,
                    ),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ThemeToggleButton(),

                            Expanded(
                              child: AutoSizeText(
                                'Ahmed\nEmad.',
                                maxLines: 2,
                                minFontSize: 10,
                                style: AppTextStyle.style96ExtraBold.copyWith(
                                  fontSize: MediaQuery.textScalerOf(context).scale(96),
                                  height: 0.8,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),

                            Expanded(
                              child: AutoSizeText(
                                'Flutter Developer',
                                maxLines: 1,
                                minFontSize: 10,
                                style: AppTextStyle.style36Bold.copyWith(
                                  color: AppColors.secondary,
                                  letterSpacing: 0,
                                  height: 1
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
                          children: List<Widget>.generate(
                            AppConstants.items.length,
                            (index) => SideMenuItem( item: AppConstants.items[index], isActive:index==activeItem,  ),
                          ),
                        ),
                      ),
                      Spacer(flex: 1),
                    ],
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

class SideMenuItem extends StatelessWidget {
  const SideMenuItem({
    super.key,
    required this.item, required this.isActive,
  });
final NavigatorItemEntity item;
final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.go(item.route);
        },
    
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isActive)
              Container(
                width: 5.w,
                height: 50.h,
                margin: EdgeInsetsDirectional.only(
                  end: 15.w,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
    
            AutoSizeText(
              item.title.toUpperCase(),
              maxLines:1,
              style: AppTextStyle.style32Regular.copyWith(
                // fontSize: MediaQuery.textScalerOf(context).scale(32),
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}




/*style: AppTextStyle.style154ExtraBold.copyWith(
        // fontSize: 48,
        // Use a Paint to draw only the stroke:
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4
          ..color = Colors.black,
      )*/

