import 'package:flutter/material.dart';

class DiscoverProvider extends ChangeNotifier {
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
  final List<String> _comments = [
    "Great post!",
    "I agree with this.",
    "Nice photo!",
  ];

  List<String> get comments => _comments;

  // Add a new comment to the list
  void addComment(String comment) {
    _comments.add(comment);
    notifyListeners();  // Notify listeners that the data has changed
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
}
