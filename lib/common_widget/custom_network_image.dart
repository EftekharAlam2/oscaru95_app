import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../gen/assets.gen.dart';

class CustomNetworkImageWidget extends StatelessWidget {
  final String urls;
  final double? width;
  final double? height;
  bool? status;
  bool? menu;
  CustomNetworkImageWidget({
    super.key,
    required this.urls,
    this.width,
    this.status = false,
    this.menu = false,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return status == false
        ? ClipOval(
            child: CachedNetworkImage(
              // imageUrl: "$imageUrl/$urls",
              imageUrl: urls,
              width: width ?? 90.w,
              height: height ?? 70.h,
              fit: BoxFit.cover,
              placeholder: (context, url) => ClipOval(
                child: Image.asset(
                  Assets.images.placeholderImage.path,
                  fit: BoxFit.fill,
                ),
              ),
              errorWidget: (context, string, url) => ClipOval(
                child: Image.asset(
                  Assets.images.placeholderImage.path,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        : CachedNetworkImage(
            imageUrl: urls,
            width: width ?? 90.w,
            height: height ?? 70.h,
            fit: menu == true ? BoxFit.contain : BoxFit.fitWidth,
            placeholder: (context, url) => Image.asset(
              Assets.images.placeholderImage.path,
            ),
            errorWidget: (context, string, url) => Image.asset(
              Assets.images.placeholderImage.path,
              fit: menu == true ? BoxFit.contain : BoxFit.fitWidth,
            ),
          );
  }
}
