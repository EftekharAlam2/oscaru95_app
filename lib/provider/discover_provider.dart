import 'package:flutter/material.dart';

class DiscoverProvider extends ChangeNotifier {
  // Per-item like and favorite state management using maps
  final Map<String, bool> _itemLikedMap = {};
  final Map<String, int> _itemLikeCountMap = {};
  final Map<String, bool> _itemFavoriteMap = {};

  // Legacy properties (kept for backward compatibility if needed)
  bool _isLiked = false;
  final int _favCount = 0;
  int get favCount => _favCount;
  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;
  bool get isLiked => _isLiked;
  int _likeCount = 0;
  int get likeCount => _likeCount;
  List<bool> isFavoriteList = []; 
  List<int> favCountList = [];

  // Search and filter properties
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  String _selectedType = '';
  String get selectedType => _selectedType;

  final List<String> _comments = [
    "Great post!",
    "I agree with this.",
    "Nice photo!",
  ];

  List<String> get comments => _comments;

  // Add a new comment to the list
  void addComment(String comment) {
    _comments.add(comment);
    notifyListeners();
  }

  FavoriteStatus(int itemCount) {
    isFavoriteList = List.generate(
        itemCount, (_) => false);
    favCountList =
        List.generate(itemCount, (_) => 0);
  }

  bool isFavoriteCount(int index) {
    return isFavoriteList[index];
  }

  int getFavCount(int index) {
    return favCountList[index];
  }

  // Per-item like methods
  bool isItemLiked(String itemId) {
    return _itemLikedMap[itemId] ?? false;
  }

  void toggleItemLike(String itemId) {
    final currentState = _itemLikedMap[itemId] ?? false;
    _itemLikedMap[itemId] = !currentState;

    // Update like count
    int currentCount = _itemLikeCountMap[itemId] ?? 0;
    if (!currentState) {
      _itemLikeCountMap[itemId] = currentCount + 1;
    } else {
      _itemLikeCountMap[itemId] = (currentCount - 1).clamp(0, double.infinity).toInt();
    }

    notifyListeners();
  }

  int getItemLikeCount(String itemId) {
    return _itemLikeCountMap[itemId] ?? 0;
  }

  // Per-item favorite methods
  bool isItemFavorite(String itemId) {
    return _itemFavoriteMap[itemId] ?? false;
  }

  void toggleItemFavorite(String itemId) {
    final currentState = _itemFavoriteMap[itemId] ?? false;
    _itemFavoriteMap[itemId] = !currentState;
    notifyListeners();
  }

  // Legacy toggle methods (kept for backward compatibility)
  void toggleLike() {
    _isLiked = !isLiked;
    if (isLiked) {
      _likeCount++;
    } else {
      _likeCount--;
    }
    notifyListeners();
  }

  void fav() {
    _isFavorite = !isFavorite;
    notifyListeners();
  }

  // Search functionality
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  // Type filter functionality
  void setSelectedType(String type) {
    _selectedType = type;
    notifyListeners();
  }

  void clearTypeFilter() {
    _selectedType = '';
    notifyListeners();
  }
}
