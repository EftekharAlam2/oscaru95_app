import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VenueInformationProvider extends ChangeNotifier {
  List<XFile> images = [];

  addImage(XFile image) {
    images.add(image);
    notifyListeners();
  }
}
