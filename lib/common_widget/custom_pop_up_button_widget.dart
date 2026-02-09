import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/colors.gen.dart';

class CustomPopUpButtonWidget extends StatelessWidget {
  final String editButton;
  final VoidCallback editPress;
  final String deleteButton;
  final VoidCallback deletePress;
  const CustomPopUpButtonWidget({
    super.key,
    required this.editButton,
    required this.deleteButton,
    required this.editPress,
    required this.deletePress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.w,
      decoration:
          const BoxDecoration(color: AppColors.c7F7F7F, shape: BoxShape.circle),
      child: Align(
        alignment: Alignment.center,
        child: PopupMenuButton(
          clipBehavior: Clip.none,
          splashRadius: 12.r,
          padding: EdgeInsets.zero,
          iconSize: 18,
          icon: const Icon(Icons.more_vert, size: 18, color: AppColors.cFFFFFF),
          iconColor: AppColors.cFFFFFF,
          color: AppColors.c535353,
          offset: const Offset(0, 40),
          // borderRadius: BorderRadius.circular(8.r),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'Option 1',
              child: InkWell(
                onTap: editPress,
                child: Text(
                  editButton,
                  style: TextFontStyle.headline14w400c0E0E0EPoppins
                      .copyWith(color: AppColors.cBCBCBC),
                ),
              ),
            ),
            PopupMenuItem(
              value: 'Option 2',
              child: InkWell(
                onTap: deletePress,
                child: Text(
                  deleteButton,
                  style: TextFontStyle.headline14w400c0E0E0EPoppins
                      .copyWith(color: AppColors.cBCBCBC),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
