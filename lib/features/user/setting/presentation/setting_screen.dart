import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/loading_helper.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';
import 'package:oscaru95/provider/offer_provider.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isSwitched1 = true;
  bool isSwitched2 = false;
  @override
  void initState() {
    statusRxObj.getStatus().then((res) {
      if (res.data?.notification == 1) {
        setState(() {
          isSwitched1 = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OfferProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.cFFFFFF),
        centerTitle: true,
        title: Text(
          "Setting",
          style: TextFontStyle.headline10w400c6B6B6BPoppins.copyWith(
            color: AppColors.cFFFFFF,
            fontSize: 24.sp,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: StreamBuilder(
            stream: statusRxObj.userProfileStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF282828),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Column(
                        children: [
                          customSetting(
                              title: "Notification",
                              value: isSwitched1,
                              onChanged: (value) {
                                postStatusRxObj
                                    .postSatus(id: '1')
                                    .waitingForSucess()
                                    .then((success) {
                                  isSwitched1 = value;
                                  statusRxObj.getStatus();
                                });
                              }),
                        ],
                      ),
                    ),
                    UIHelper.verticalSpace(16.w),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF282828),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Column(
                        children: [
                          customSetting(
                              title: "Location",
                              value: provider.location!,
                              onChanged: provider.updateLocation),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }

  Widget customSetting({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextFontStyle.headline12w400C999999notoSansOldItalic.copyWith(
            color: AppColors.cFFFFFF,
            fontSize: 16.sp,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2C),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFFF97342),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFF444444),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }
}
