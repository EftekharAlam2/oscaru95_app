// ignore_for_file: deprecated_member_use

import 'package:fluttertoast/fluttertoast.dart';

final class ToastUtil {
  ToastUtil._();
  static void showLongToast(String message) {
    String trn = message;
    Fluttertoast.showToast(
      msg: trn,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  // static void showErrorMessage(
  //     {required String message, required BuildContext context, int? duration}) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       duration: Duration(seconds: duration ?? 3),
  //       content: Stack(
  //         clipBehavior: Clip.none,
  //         children: [
  //           Container(
  //             margin: EdgeInsets.only(top: 16.h),
  //             padding: EdgeInsets.all(14.sp),
  //             height: 70.h,
  //             decoration: BoxDecoration(
  //               color: Colors.red,
  //               borderRadius: BorderRadius.circular(20.r),
  //             ),
  //             child: Row(
  //               children: [
  //                 SizedBox(
  //                   width: 48.w,
  //                 ),
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         "Warning !!!",
  //                         style: TextFontStyle.headline16C292D32SatoshiMedium
  //                             .copyWith(color: AppColors.cFFFFFF),
  //                       ),
  //                       const Spacer(),
  //                       Text(
  //                         message,
  //                         style: TextFontStyle.headline14C292D32SatoshiRegular
  //                             .copyWith(color: AppColors.cFFFFFF),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Positioned(
  //             bottom: 0,
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.only(
  //                 bottomLeft: Radius.circular(20.r),
  //               ),
  //               child: SvgPicture.asset(
  //                 Assets.icons.bubbles,
  //                 height: 48.h,
  //                 width: 40.w,
  //                 color: const Color(0xFF801336),
  //               ),
  //             ),
  //           ),
  //           Positioned(
  //             top: -2.h,
  //             right: 0.w,
  //             child: InkWell(
  //               onTap: () {
  //                 ScaffoldMessenger.of(context).hideCurrentSnackBar();

  //                 // Navigator.pop(context);
  //               },
  //               child: Stack(
  //                 alignment: Alignment.center,
  //                 children: [
  //                   SvgPicture.asset(
  //                     Assets.icons.fail,
  //                     height: 38.h,
  //                     // width: 40.w,
  //                     color: const Color(0xFF801336),
  //                   ),
  //                   Positioned(
  //                     top: 9.h,
  //                     child: SvgPicture.asset(
  //                       Assets.icons.close,
  //                       height: 16.h,
  //                       // width: 40.w,
  //                       color: AppColors.cFFFFFF,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //       behavior: SnackBarBehavior.floating,
  //       backgroundColor: Colors.transparent,
  //       elevation: 0,
  //     ),
  //   );
  // }

  // static void showSuccessMessage({
  //   required String message,
  //   required BuildContext context,
  //   int? duration,
  //   String? title,
  // }) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       margin: EdgeInsets.symmetric(horizontal: 0.w),
  //       duration: Duration(seconds: duration ?? 2),
  //       content: Stack(
  //         clipBehavior: Clip.none,
  //         children: [
  //           Container(
  //             margin: EdgeInsets.only(top: 16.h),
  //             padding: EdgeInsets.all(14.sp),
  //             height: 75.h,
  //             decoration: BoxDecoration(
  //               color: const Color(0xFF2D6A50),
  //               borderRadius: BorderRadius.circular(20.r),
  //             ),
  //             child: Row(
  //               children: [
  //                 SizedBox(
  //                   width: 48.w,
  //                 ),
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         title ?? "Successful !!!",
  //                         style: TextFontStyle.headline16C292D32SatoshiMedium
  //                             .copyWith(color: AppColors.cFFFFFF),
  //                       ),
  //                       const Spacer(),
  //                       Text(
  //                         message,
  //                         style: TextFontStyle.headline14C292D32SatoshiRegular
  //                             .copyWith(color: AppColors.cFFFFFF),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Positioned(
  //             bottom: 0,
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.only(
  //                 bottomLeft: Radius.circular(20.r),
  //               ),
  //               child: SvgPicture.asset(
  //                 Assets.icons.bubbles,
  //                 height: 48.h,
  //                 width: 40.w,
  //                 color: const Color(0xFF1E4634),
  //               ),
  //             ),
  //           ),
  //           Positioned(
  //             top: -2.h,
  //             right: 0.w,
  //             child: InkWell(
  //               onTap: () {
  //                 ScaffoldMessenger.of(context).hideCurrentSnackBar();

  //                 // Navigator.pop(context);
  //               },
  //               child: Stack(
  //                 alignment: Alignment.center,
  //                 children: [
  //                   SvgPicture.asset(
  //                     Assets.icons.fail,
  //                     height: 38.h,
  //                     // width: 40.w,
  //                     color: const Color(0xFF1E4634),
  //                   ),
  //                   Positioned(
  //                     top: 9.h,
  //                     child: SvgPicture.asset(
  //                       Assets.icons.close,
  //                       height: 16.h,
  //                       // width: 40.w,
  //                       color: AppColors.cFFFFFF,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //       behavior: SnackBarBehavior.floating,
  //       backgroundColor: Colors.transparent,
  //       elevation: 0,
  //     ),
  //   );
  // }

  static void showShortToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  static void showNoInternetToast() {
    Fluttertoast.showToast(
      msg: "Please check your internet connection",
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  static void showNotLoggedInToast() {
    Fluttertoast.showToast(
      msg: "Please login to perform this operation",
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
