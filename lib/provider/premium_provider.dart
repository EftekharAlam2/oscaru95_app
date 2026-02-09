import 'package:flutter/material.dart';

class PremiumProvider extends ChangeNotifier {
  final Map<String, bool> _checkboxStates = {
    "Free Plan": false,
    "Premium Plan": false,
  };

  bool isChecked(String title) {
    return _checkboxStates[title] ?? false;
  }

  void toggleCheckbox(String title) {
    _checkboxStates[title] = !_checkboxStates[title]!;
    notifyListeners();
  }
}
