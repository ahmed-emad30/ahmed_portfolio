import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/widgets/theme_toggle_button.dart' show ThemeToggleButton;
import 'package:portfolio/core/widgets/top_app_navigator.dart' show TopAppNavigator;

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 1.sh,
      padding: EdgeInsetsDirectional.only(start: 60.w,),
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopAppNavigator(),

          ThemeToggleButton(),

        ],
      ),
    );
  }
}



