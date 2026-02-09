import 'package:flutter/material.dart';

class PersonalizedProvider extends ChangeNotifier {
  List<Map<String, dynamic>> personalized = [
    {
      "day": "Monday",
      "selected": false,
      "from": "09:00 AM",
      "to": "05:00 PM",
    },
    {
      "day": "Tuesday",
      "selected": false,
      "from": "09:00 AM",
      "to": "05:00 PM",
    },
    // Add more days as needed...
  ];

  void toggleAvailability(int index, bool value) {
    personalized[index]["selected"] = value;
    notifyListeners();
  }

  void updateFromTime(int index, String time) {
    personalized[index]["from"] = time;
    notifyListeners();
  }

  void updateToTime(int index, String time) {
    personalized[index]["to"] = time;
    notifyListeners();
  }
}
