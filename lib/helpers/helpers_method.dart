import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:oscaru95/constants/app_constants.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/helpers/di.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/toast.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

import '../common_widget/custom_button.dart';

void showMaterialDialog(
  BuildContext context,
) {
  showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: const Text(
        "Do you want to exit the app?",
        textAlign: TextAlign.center,
        // style: TextFontStyle.headline14StylePoppins,
      ),
      actions: <Widget>[
        CustomButton(
          btnName: "No",
          onTap: () {
            Navigator.of(context).pop(false);
          },
        ),
        CustomButton(
          btnName: "Yes",
          onTap: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    ),
  );
}

void showCustomDialog({
  required BuildContext context,
  required String title,
  required VoidCallback onTapYes,
  required VoidCallback onTapNo,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextFontStyle.headline12w400C999999Poppins,
            textAlign: TextAlign.center,
          ),
          UIHelper.verticalSpace(20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                // width: 110.w,
                // height: 40.h,
                onTap: onTapYes,
                btnName: "Yes".tr,
                // fontSize: 14.sp,
              ),
              UIHelper.horizontalSpaceMedium,
              CustomButton(
                // width: 110.w,
                // height: 40.h,
                onTap: onTapNo,
                btnName: "No".tr,
                // fontSize: 14.sp,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Future<dynamic> customSuccessDilaog(
  BuildContext context, {
  required String title,
  required String message,
  VoidCallback? onTap,
  String? btnName,
}) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextFontStyle.headline14w600CFF7A01Poppins,
          ),
          UIHelper.verticalSpace(8.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextFontStyle.headline14w400c666666Poppins,
          ),
          UIHelper.verticalSpace(12.h),
          CustomButton(
            // width: 140.w,
            // height: 42.h,
            // borderRadius: 30.r,
            // fontSize: 14.sp,
            onTap: onTap!,
            btnName: btnName ?? "Back",
          ),
        ],
      ),
    ),
  );
}

Future<dynamic> showImagePickerDialog({
  required BuildContext context,
  required VoidCallback onTapCamera,
  required VoidCallback onTapGallery,
}) {
  return showCupertinoModalPopup(
    context: context,
    builder: (_) => CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          onPressed: onTapCamera,
          child: const Text('Take a Photo'),
        ),
        CupertinoActionSheetAction(
          onPressed: onTapGallery,
          child: const Text('Choose from Gallery'),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Cancel'),
      ),
    ),
  );
}

// Future<File> resizeImage(File file) async {
//   // Decode the image file into an image object
//   final img.Image? originalImage = img.decodeImage(await file.readAsBytes());
//   if (originalImage == null) return file; // Return original if decoding fails

//   // Set the target width (e.g., 1024 pixels)
//   const int targetWidth = 1024;
//   final img.Image resizedImage = img.copyResize(
//     originalImage,
//     width: targetWidth,
//   );

//   // Encode the resized image back to bytes
//   Uint8List resizedBytes =
//       Uint8List.fromList(img.encodeJpg(resizedImage, quality: 85));

//   // Keep resizing if the file size is still greater than 2 MB
//   while (resizedBytes.lengthInBytes > 2 * 1024 * 1024) {
//     final img.Image furtherResized = img.copyResize(
//       img.decodeImage(resizedBytes)!,
//       width: (resizedImage.width * 0.8).toInt(), // Reduce size by 20%
//     );
//     resizedBytes =
//         Uint8List.fromList(img.encodeJpg(furtherResized, quality: 85));
//   }

//   // Save the resized image to a new file
//   final String resizedPath = '${file.path}_resized.jpg';
//   final File resizedFile = File(resizedPath);
//   await resizedFile.writeAsBytes(resizedBytes);

//   return resizedFile;
// }

// Future<File> resizeImageWithAspectRatio(File file) async {
//   // Decode the image file into an image object
//   final img.Image? originalImage = img.decodeImage(await file.readAsBytes());
//   if (originalImage == null) return file; // Return original if decoding fails

//   // Target aspect ratio (3:4)
//   const double targetAspectRatio = 3 / 4;

//   // Calculate the crop dimensions to match the target aspect ratio
//   int cropWidth = originalImage.width;
//   int cropHeight = originalImage.height;

//   // Adjust dimensions to match the target aspect ratio
//   if (originalImage.width / originalImage.height > targetAspectRatio) {
//     cropWidth = (originalImage.height * targetAspectRatio).toInt();
//   } else {
//     cropHeight = (originalImage.width / targetAspectRatio).toInt();
//   }

//   // Crop the image
//   final img.Image croppedImage = img.copyCrop(
//     originalImage,
//     x: (originalImage.width - cropWidth) ~/ 2,
//     y: (originalImage.height - cropHeight) ~/ 2,
//     width: cropWidth,
//     height: cropHeight,
//   );

//   // Set the target width (e.g., 1024 pixels)
//   const int targetWidth = 1024;
//   final img.Image resizedImage = img.copyResize(
//     croppedImage,
//     width: targetWidth,
//   );

//   // Encode the resized image back to bytes
//   Uint8List resizedBytes =
//       Uint8List.fromList(img.encodeJpg(resizedImage, quality: 85));

//   // Keep resizing if the file size is still greater than 2 MB
//   while (resizedBytes.lengthInBytes > 2 * 1024 * 1024) {
//     final img.Image furtherResized = img.copyResize(
//       img.decodeImage(resizedBytes)!,
//       width: (resizedImage.width * 0.8).toInt(), // Reduce size by 20%
//     );
//     resizedBytes =
//         Uint8List.fromList(img.encodeJpg(furtherResized, quality: 85));
//   }

//   // Save the resized and cropped image to a new file
//   final String resizedPath = '${file.path}_resized_3x4.jpg';
//   final File resizedFile = File(resizedPath);
//   await resizedFile.writeAsBytes(resizedBytes);

//   return resizedFile;
// }

String formatTimeOfDay(TimeOfDay time) {
  final hour = time.hourOfPeriod == 0
      ? 12
      : time.hourOfPeriod; // Convert 0 to 12 for AM/PM format
  final period = time.period == DayPeriod.am ? "AM" : "PM";
  final minute = time.minute
      .toString()
      .padLeft(2, '0'); // Add leading zero to minutes if needed
  return "$hour:$minute $period";
}

Future<String?> pickDate({
  required BuildContext context,
  required DateTime startDate,
  required DateTime endDate,
  String dateFormat = "yyyy-MM-dd",
}) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: startDate,
    firstDate: startDate,
    lastDate: endDate,
  );

  if (pickedDate != null) {
    return DateFormat(dateFormat).format(pickedDate);
  }
  return null;
}

Future<void> showCustomDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  required Function(DateTime) onDatePicked,
}) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
  );

  if (pickedDate != null) {
    onDatePicked(pickedDate);
  }
}

String formatDate(DateTime date) {
  return DateFormat('MM/dd/yyyy').format(date);
}

String formatDateYear(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String dashFormatDate(DateTime date) {
  return DateFormat('MM-dd-yyyy').format(date);
}

DateTime formatStringIntoDate(String date) {
  return DateFormat("MM/dd/yyyy").parse(date);
}

Future<void> showCustomTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
  required Function(TimeOfDay) onTimePicked,
}) async {
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: initialTime,
  );

  if (pickedTime != null) {
    onTimePicked(pickedTime);
  }
}

String formatClockTime(TimeOfDay time) {
  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}

String formatTime(TimeOfDay time, BuildContext context) {
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
  return TimeOfDay.fromDateTime(dt).format(context);
}

TimeOfDay convertToTimeOfDay(String? timeString) {
  if (timeString == null || timeString.isEmpty) {
    return const TimeOfDay(hour: 0, minute: 0);
  }

  final parts = timeString.split(':');
  final hour = int.tryParse(parts[0]) ?? 0;
  final minute = int.tryParse(parts[1]) ?? 0;

  return TimeOfDay(hour: hour, minute: minute);
}

String formatedTime(TimeOfDay time) {
  final hour = time.hourOfPeriod == 0
      ? 12
      : time.hourOfPeriod; // Adjusts for 12-hour format
  final minute = time.minute
      .toString()
      .padLeft(2, '0'); // Pads minutes with a leading zero if needed
  final period = time.period == DayPeriod.am ? 'AM' : 'PM';

  return '$hour:$minute $period';
}

String formatTimeOfDay24Hour(TimeOfDay time) {
  final int hour = time.hour;
  final int minute = time.minute;
  return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}

// TimeOfDay convertToTimeOfDay(String timeString) {
//   DateFormat dateFormat = DateFormat("hh:mm a");
//   DateTime dateTime = dateFormat.parse(timeString);
//   return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
// }

TimeOfDay formatStringToTime(String timeString) {
  try {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  } catch (e) {
    throw FormatException("Invalid time format: $timeString");
  }
}

Future<void> initInternetChecker() async {
  InternetConnectionChecker.createInstance(
    checkInterval: const Duration(seconds: 2),
  ).onStatusChange.listen((status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        ToastUtil.showShortToast('Data connection is available.');
        break;
      case InternetConnectionStatus.disconnected:
        ToastUtil.showNoInternetToast();
        break;
      case InternetConnectionStatus.slow:
        ToastUtil.showShortToast('Your internet connection is slow.');
        break;
    }
  });
}

Future<void> pickImage(
  ValueNotifier<File?> imageNotifier,
  ImageSource source,
) async {
  final ImagePicker picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source);

  if (pickedFile != null) {
    imageNotifier.value = File(pickedFile.path); // Update the ValueNotifier
  }
}

imagePickerDialog(BuildContext context, ValueNotifier<File?> imageNotifier) {
  return showModalBottomSheet(
    showDragHandle: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.r),
      ),
    ),
    context: context,
    builder: (_) => Container(
      height: 180.h,
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
              pickImage(imageNotifier, ImageSource.camera);
            },
            child: Row(
              children: [
                SvgPicture.asset(Assets.icons.imageUpload),
                UIHelper.horizontalSpaceSmall,
                Text(
                  "Take a Photo".tr,
                  style: TextFontStyle.headline10w400c6B6B6BPoppins,
                ),
              ],
            ),
          ),
          UIHelper.verticalSpace(16.h),
          InkWell(
            onTap: () {
              NavigationService.goBack;
              pickImage(imageNotifier, ImageSource.gallery);
            },
            child: Row(
              children: [
                SvgPicture.asset(Assets.icons.imageUpload),
                UIHelper.horizontalSpaceSmall,
                Text(
                  "Choose from Album".tr,
                  style: TextFontStyle.headline10w400c6B6B6BPoppins,
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Future<void> setInitValue() async {
  await appData.writeIfNull(kKeyIsLoggedIn, false);
  // await appData.writeIfNull(KKeyIsLangaugePage, true);
  // await appData.writeIfNull(KKeyIsFirstTime, true);
  // await appData.writeIfNull(KKeyIsAdminFirstTime, true);
  // await appData.writeIfNull(kKeyLanguage, kKeyEnglish);
  // appData.writeIfNull(kKeyCountryCode, countriesCode[kKeyEnglish]);
  // await appData.writeIfNull(kKeyIsExploring, false);
  // appData.writeIfNull(kKeyLanguage, kKeyPortuguese);
  // appData.writeIfNull(kKeyCountryCode, countriesCode[kKeyPortuguese]);
  // appData.writeIfNull(kKeySelectedLocation, false);
//lisbon
  // appData.writeIfNull(kKeySelectedLat, 38.74631383626653);
  // appData.writeIfNull(kKeySelectedLng, -9.130169921874991);
//codemen
  // await appData.writeIfNull(kKeySelectedLat, 22.818285677915657);
  // await appData.writeIfNull(kKeySelectedLng, 89.5535583794117);

  // var deviceInfo = DeviceInfoPlugin();
  // if (Platform.isIOS) {
  //   var iosDeviceInfo = await deviceInfo.iosInfo;
  //   appData.writeIfNull(
  //       kKeyDeviceID, iosDeviceInfo.identifierForVendor); // unique ID on iOS
  // } else if (Platform.isAndroid) {
  //   var androidDeviceInfo =
  //       await deviceInfo.androidInfo; // unique ID on Android
  //   appData.writeIfNull(kKeyDeviceID, androidDeviceInfo.id);
  // }
  await Future.delayed(const Duration(seconds: 3));
}

void rotation() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
