import 'package:flutter/material.dart';
import 'package:oscaru95/common_widget/title.dart';
import 'package:oscaru95/gen/colors.gen.dart';

class RegistraionSuccessScreen extends StatelessWidget {
  const RegistraionSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TitleWidget(
              title: "Thank you for\n registering!",
              titleFontSize: 28,
              subtitle:
                  "Our team is currently reviewing your information. You’ll\n receive a confirmation email from us once your account\n                                               has been approved.",
              subTitleFontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
