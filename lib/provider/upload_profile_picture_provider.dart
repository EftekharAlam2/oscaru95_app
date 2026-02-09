import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oscaru95/helpers/toast.dart';

class UploadProfilePictureProvider extends ChangeNotifier {


  bool isUpdated = false;
  File? imageFile;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickImage != null) {
      File file = File(pickImage.path);

      /// Get file Size in Byte
      int fileSize = await file.length();

      //Convert to MB
      double fileSizeInMB = fileSize / (1024 * 1024);

      /// File Extension Checker
      String fileExtension = pickImage.path.split('.').last.toLowerCase();
      List<String> allowedExtensions = ['jpg', 'jpeg', 'png'];

      if (!allowedExtensions.contains(fileExtension)) {
        ToastUtil.showShortToast(
            'Invalid File Type. Only JPEG, JPG, and PNG files are allowed.');
        return;
      }

      if (fileSizeInMB > 5) {
        ToastUtil.showShortToast(
            'File Size Exceeds 5MB. Please choose a smaller file.');
        return;
      }

      imageFile = file;
      notifyListeners();
    }
  }
}
