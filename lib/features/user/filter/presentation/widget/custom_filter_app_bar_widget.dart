import 'package:flutter/material.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/colors.gen.dart';

class CustomFilterAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback pressNav;
  final VoidCallback pressClear;
  final String titile;
  final String action;
  const CustomFilterAppBarWidget({
    super.key,
    required this.titile,
    required this.action,
    required this.pressNav,
    required this.pressClear,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.scaffoldColor,
      leading: GestureDetector(
        onTap: pressNav,
        child: const Icon(
          Icons.close,
          color: AppColors.cFFFFFF,
        ),
      ),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              titile,
              style: TextFontStyle.headline18w600CFFFFFFPoppins,
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: pressClear,
            child: Text(
              action,
              style: TextFontStyle.headline14w500CFF7A01Poppins
                  .copyWith(color: AppColors.cFE5401),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}