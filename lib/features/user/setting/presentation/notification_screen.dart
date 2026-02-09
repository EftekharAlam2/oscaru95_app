import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/user/setting/model/my_notification_model.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/networks/api_access.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    notificationRxObj.getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.cFFFFFF),
        title: Text(
          "Notification",
          style: TextFontStyle.headline10w400c6B6B6BPoppins
              .copyWith(color: AppColors.cFFFFFF, fontSize: 18.w),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: notificationRxObj.userProfileStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            NotificationModel model = snapshot.data;

            return model.data!.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: AppColors.c999999,
                      );
                    },
                    itemBuilder: (context, snapshot) {
                      return ListTile(
                        contentPadding: EdgeInsets.all(15.h),
                        leading: ClipOval(
                          child: Image.asset(Assets.images.profile.path),
                        ),
                        title: Text(
                          "Notifiction",
                          style: TextFontStyle.headline10w400c6B6B6BPoppins
                              .copyWith(
                                  color: AppColors.cFFFFFF, fontSize: 16.sp),
                        ),
                        subtitle: Text("subTitle",
                            style: TextFontStyle.headline10w400c6B6B6BPoppins),
                      );
                    },
                    itemCount: 10,
                  )
                : Center(
                    child: Text(
                      model.message.toString(),
                      style: TextFontStyle.headline10w400c6B6B6BPoppins
                          .copyWith(color: AppColors.cFFFFFF, fontSize: 18.sp),
                    ),
                  );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
