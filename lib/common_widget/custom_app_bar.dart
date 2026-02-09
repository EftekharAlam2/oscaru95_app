import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../gen/assets.gen.dart';
import '../helpers/navigation_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final TextStyle? style;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
     this.title,
    this.showBackButton = false,
    this.centerTitle = false,
    this.actions,
    this.backgroundColor,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? '', style: style),
      centerTitle: true,
      leading:
          showBackButton
              ? IconButton(
                onPressed: () {
                  NavigationService.goBack;
                },
                icon: SvgPicture.asset(Assets.icons.arrowBackIcon,
                width: 24.w,height: 24.h,fit: BoxFit.none,
                ),
              )
              : null,
      actions: actions,
      backgroundColor: backgroundColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}