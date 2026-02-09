import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/merchant/widget/dynamic_drink_form.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/provider/offer_provider.dart';
import 'package:provider/provider.dart';

class EditDrinkSpecialScreen extends StatefulWidget {
  const EditDrinkSpecialScreen({
    super.key,
  });

  @override
  State<EditDrinkSpecialScreen> createState() => _EditDrinkSpecialScreenState();
}

class _EditDrinkSpecialScreenState extends State<EditDrinkSpecialScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<OfferProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar:
          // AppBar(
          //         backgroundColor: AppColors.scaffoldColor,
          //         // actions: [
          //         //   GestureDetector(
          //         //     onTap: () {
          //         //       NavigationService.navigateToReplacement(
          //         //           Routes.merchantNavigation);
          //         //     },
          //         //     child: Padding(
          //         //       padding: EdgeInsets.only(right: 31.w),
          //         //       child: Text(
          //         //         "Skip",
          //         //         style: TextFontStyle.headline10w400c6B6B6BPoppins
          //         //             .copyWith(
          //         //                 color: AppColors.allPrimaryColor,
          //         //                 fontSize: 18.sp),
          //         //       ),
          //         //     ),
          //         //   ),
          //         // ],
          //         title: ,
          //       )
          //     :
          AppBar(
        backgroundColor: AppColors.scaffoldColor,
        automaticallyImplyLeading: true,
        foregroundColor: AppColors.cFFFFFF,
        title: Text(
          "Edit Drink Specials",
          style: TextFontStyle.headline10w400c6B6B6BPoppins
              .copyWith(color: AppColors.cFFFFFF, fontSize: 24.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // widget.status == true
            //     ? TitleWidget(
            //         title: "Drink Specials",
            //         titleFontSize: 24.sp,
            //         subtitle: "Please enter your details to create an account.",
            //         subTitleFontSize: 12.sp,
            //       )
            //     : const SizedBox.shrink(),
            DynamicDrinkForm(
              onAddDrink: provider.addNewForm1,
              availability: const [],
              onSelectAvailability: (int, bool) {},
              onFromTimeChanged: (int, TimeOfDay) {},
              onToTimeChanged: (int, TimeOfDay) {},
            ),
            Padding(
              padding: EdgeInsets.all(30.w),
              child: CustomButton(
                onTap: () {
                  // if (widget.status == true) {
                  //   NavigationService.navigateToWithArgs(
                  //       Routes.foodScreen, {"status": true});
                  // }
                  // if (widget.status == false) {
                  //   NavigationService.navigateTo(Routes.merchantDashBorad);
                  // }
                },
                btnName: "Update",
                textStaus: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
