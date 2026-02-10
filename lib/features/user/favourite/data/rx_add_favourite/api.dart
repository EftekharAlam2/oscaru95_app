import 'package:oscaru95/features/user/favourite/data/rx_get_favourite/api.dart';

final class AddFavouriteApi {
  static final AddFavouriteApi _singleton = AddFavouriteApi._internal();
  AddFavouriteApi._internal();
  static AddFavouriteApi get instance => _singleton;

  Future<Map> addToFavourite({required String id}) async {
    try {
      // Toggle favorite in local memory instead of API call
      final favApi = GetFavouriteApi.instance;
      favApi.toggleFavorite(id);
      
      // Return success response
      return {
        "success": true,
        "message": "Favorite updated successfully",
        "code": 200
      };
    } catch (error) {
      rethrow;
    }
  }
}
