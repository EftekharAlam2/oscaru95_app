import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  final List<FilterItem> _filterItems = [
    FilterItem(category: "Special Type", subcategories: [
      "food",
      "Drinks",
    ]),
    FilterItem(
        category: "Cuisine",
        subcategories: ["Italian ", "European", "Japanese", "Thai"]),
    FilterItem(
        category: "Deal type", subcategories: ["Inside", "Outside", "Rooftop"]),
    FilterItem(
        category: "Rating",
        subcategories: ["European", "Indian", "Italian", "British"]),
    FilterItem(
        category: "Type of establishment",
        subcategories: ["Wifi", "Air conditioning", "Pet friendly"]),
  ];

  List<FilterItem> get filterItems => _filterItems;

  void toggleSubcategory(String category, String subcategory) {
    int categoryIndex =
        _filterItems.indexWhere((item) => item.category == category);

    if (categoryIndex != -1) {
      if (_filterItems[categoryIndex]
          .selectedSubcategories
          .contains(subcategory)) {
        _filterItems[categoryIndex].selectedSubcategories.remove(subcategory);
      } else {
        _filterItems[categoryIndex].selectedSubcategories.add(subcategory);
      }
      notifyListeners();
    }
  }

  // Get selected filters
  List<Map<String, dynamic>> getSelectedFilters() {
    return _filterItems
        .where((item) => item.selectedSubcategories.isNotEmpty)
        .map((item) => {
              "category": item.category,
              "selectedSubcategories": item.selectedSubcategories,
            })
        .toList();
  }
}

class FilterItem {
  String category;
  List<String> subcategories;
  List<String> selectedSubcategories;

  FilterItem({
    required this.category,
    required this.subcategories,
    List<String>? selectedSubcategories,
  }) : selectedSubcategories = selectedSubcategories ?? [];
}
