// ignore_for_file: prefer_final_fields

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OfferProvider extends ChangeNotifier {
  int? _selectedvalue;
  String _selectedfilled = '';
  String get selectedfilled => _selectedfilled;
  int? get selectedValue => _selectedvalue;
  bool? _switchProvider = true;
  bool? _location = true;
  bool? get location => _location;
  bool? get switchProvider => _switchProvider;
  // ignore: prefer_final_fields
  List<int> _formList1 = [];
  List<int> _formList2 = [];
  final List<String> specialTitles = [
    "Weekend Special",
    "Ladies’ Night Specials",
    "Happy Hour",
  ];

  List<int> get formList1 => _formList1;
  List<int> get formList2 => _formList2;
  File? _selectedFile;
  File? _selectProfile;

  File? _preimumImage;

  final ImagePicker _picker = ImagePicker();

  File? get selectedFile => _selectedFile;
  File? get selectProfile => _selectProfile;
  File? get selectpreimumImage => _preimumImage;
  String? _selectedTitle;

  String? get selectedTitle => _selectedTitle;
  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  void setSelectedImage(File? image) {
    _selectedImage = image;
    notifyListeners();
  }

  void setSelectedTitle(String? newValue) {
    _selectedTitle = newValue;
    notifyListeners(); // Notify listeners to rebuild UI
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectedFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> pickProfile() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectProfile = File(pickedFile.path);
    }
    notifyListeners();
  }

  Future<void> pickFile() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _preimumImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  void update(bool value) {
    _switchProvider = value;
    notifyListeners();
  }

  void updateLocation(bool value) {
    _location = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> personalized = [
    {
      "day": "Breakfast",
      "selected": true,
      "from": const TimeOfDay(hour: 18, minute: 0),
      "to": const TimeOfDay(hour: 20, minute: 0)
    },
    {
      "day": "Lunch",
      "selected": true,
      "from": const TimeOfDay(hour: 18, minute: 0),
      "to": const TimeOfDay(hour: 20, minute: 0)
    },
    {
      "day": "Dinner",
      "selected": true,
      "from": const TimeOfDay(hour: 18, minute: 0),
      "to": const TimeOfDay(hour: 20, minute: 0)
    },
  ];

  List<Map<String, dynamic>> availability = [
    {
      "day": "Sun",
      "selected": true,
      "from": const TimeOfDay(hour: 18, minute: 0),
      "to": const TimeOfDay(hour: 20, minute: 0)
    },
    {
      "day": "Mon",
      "selected": true,
      "from": const TimeOfDay(hour: 18, minute: 0),
      "to": const TimeOfDay(hour: 20, minute: 0)
    },
    {
      "day": "Tue",
      "selected": true,
      "from": const TimeOfDay(hour: 18, minute: 0),
      "to": const TimeOfDay(hour: 20, minute: 0)
    },
    {
      "day": "Wed",
      "selected": true,
      "from": const TimeOfDay(hour: 18, minute: 0),
      "to": const TimeOfDay(hour: 20, minute: 0)
    },
    {
      "day": "Thu",
      "selected": true,
      "from": const TimeOfDay(hour: 18, minute: 0),
      "to": const TimeOfDay(hour: 20, minute: 0)
    },
    {
      "day": "Fri",
      "selected": true,
      "from": const TimeOfDay(hour: 18, minute: 0),
      "to": const TimeOfDay(hour: 20, minute: 0)
    },
    {
      "day": "Sat",
      "selected": true,
      "from": const TimeOfDay(hour: 18, minute: 0),
      "to": const TimeOfDay(hour: 20, minute: 0)
    },
  ];

  bool _isSeasonalOffer = true;

  bool get isSeasonalOffer => _isSeasonalOffer;

  void toggleOffer() {
    _isSeasonalOffer = !_isSeasonalOffer;
    notifyListeners();
  }

  /// 🔹 Toggle selected availability
  void toggleAvailability(int index, bool isSelected) {
    availability[index]["selected"] = isSelected;
    notifyListeners();
  }

  /// 🔹 Update 'from' time
  void updateFromTime(int index, TimeOfDay newTime) {
    availability[index]["from"] = newTime;
    notifyListeners();
  }

  /// 🔹 Update 'to' time
  void updateToTime(int index, TimeOfDay newTime) {
    availability[index]["to"] = newTime;
    notifyListeners();
  }

  void addNewForm1() {
    _formList1.add(_formList1.length);
    notifyListeners(); // Notify UI about the update
  }

  void addNewForm2() {
    _formList2.add(_formList2.length);
    notifyListeners(); // Notify UI about the update
  }

  void toggleSelectedRadio(int vlaue) {
    _selectedvalue = vlaue;
    notifyListeners();
  }

  void updateValue(String value) {
    _selectedfilled = value;
    notifyListeners();
  }
}
