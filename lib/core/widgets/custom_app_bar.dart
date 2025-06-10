import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, SliverAppBar;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/widgets/theme_toggle_button.dart' show ThemeToggleButton;
import 'package:portfolio/core/widgets/top_app_navigator.dart' show TopAppNavigator;

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
/*      floating: true,
      pinned: false,
      snap: true,*/
      flexibleSpace: Container(
        height: 1.sh,
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopAppNavigator(),

            ThemeToggleButton(),

          ],
        ),
      ),
    );
  }
}



