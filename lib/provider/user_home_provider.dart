import 'package:flutter/material.dart';

class UserHomeProvider extends ChangeNotifier {
  int _selectedIndex = 1;
  int get selectedIndex => _selectedIndex;

  void tabIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
