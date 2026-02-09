// ignore_for_file: constant_identifier_names

// const String url = String.fromEnvironment("BASE_URL");
// const String url = "http://192.168.40.77:8000";

// const String url = "https://oscaru.softvencefsd.xyz";
const String url = "https://motiveeltd.com";

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class EndPoints {
  EndPoints._();
  static String splash() => "/api/splash";
  static String userSignUp() => "/api/register";
  static String BusinessSignUp() => "/api/business/register";
  static String login() => "/api/login";
  static String logout() => "/api/logout";
  static String userProfile() => "/api/me";
  static String deleteUserProfile() => "/api/delete-profile";

  static String getBusniessProfile() => "/api/business/business-profile";
  static String editBusinessPassword() =>
      "/api/business/business-password/update";
  static String marchentLogout() => "/api/business/logout";
  static String deleteBusinessProfile() =>
      "/api/business/business-profile/delete";

  static String sendOtp() => "/api/password/request-otp";
  static String favourite() => "/api/favourites";
  static String addToFavourite() => "/api/store-favourite";
  static String getNearest() => "/api/home/nearby/location";
  static String getDiscover() => "/api/discover";
  static String addReview() => "/api/store-review";
  static String getReview(int id) => "/api/reviews/$id";

  static String getEstablishment() => "/api/establishment";
  static String getFoodSpecial() => "/api/business/food-list";
  static String getDrinkSpecial() => "/api/business/drink-list";
  static String getSessonalOffer() => "/api/business/seasonal-offer-list";
  static String cancelSessonalOffer(int id) => "/api/business/delete-event/$id";

  static String getSpecialOffer() => "/api/business/special-offer-list";
  static String getEventDetails(int id) => "/api/business/event-details/$id";
  static String addEvent() => "/api/business/store-event";
  static String editEvent(int id) => "/api/business/edit-event/$id";
  static String categoriesInfo() => "/api/category";
  static String addItemInfo() => "/api/business/store-item";
  static String cusinInfo() => "/api/cuisine";
  static String editMenu() => "/api/business/business-menu/update";
  static String verifyOtp() => "/api/register-otp-verify";
  static String menuInfo() => "/api/business/business-menu";
  static String userLike() => "/api/community/like";
  static String commentInfo() => "/api/community/comment";
  static String status() => "/api/notification-status";
  static String statusAdd() => "/api/notification-setting";
  static String myNotification() => "/api/my-notifications";
  static String story() => "/api/story";
  static String homeShopProfile(String id) => "/api/business/profile/$id";
  static String gallery() => "/api/business/store-gallary";
  static String updateProfile() => "/api/update-profile";
  static String updatePassword() => "/api/update-password";
  static String feed() => "/api/send-feedback";
  static String anlaytics() => "/api/business/analytics";
  static String filter(String filter) => "/api/filter?";
  static String topDeals(String monthId) =>
      "/api//business/analytics/top-deals?month=$monthId";
  static String discover() => "/api/discover/filter";
}
