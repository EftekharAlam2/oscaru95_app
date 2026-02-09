// ignore_for_file: unused_element

import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:oscaru95/features/auth/presentation/forget_pass/forget_password_screen.dart';
import 'package:oscaru95/features/auth/presentation/login/login_screen.dart';
import 'package:oscaru95/features/auth/presentation/sign_up/register_screen.dart';
import 'package:oscaru95/features/auth/presentation/verify_otp/verify_otp_screen.dart';
import 'package:oscaru95/features/edit_drink_special/presentation/edit_drink_speacial_screen.dart';
import 'package:oscaru95/features/edit_food_special_screen/presentation/edit_food_speacial_screen.dart';
import 'package:oscaru95/features/merchant/add_seasonal_offer/presentation/add_seasonal_offer.dart';
import 'package:oscaru95/features/merchant/add_special_offer/presentation/add_special_offer_screen.dart';
import 'package:oscaru95/features/merchant/auth/presentation/login_screen.dart';
import 'package:oscaru95/features/merchant/auth/presentation/registraion_success_screen.dart';
import 'package:oscaru95/features/merchant/auth/presentation/registraion_venu_screen.dart';
import 'package:oscaru95/features/merchant/edit_seasonal_offers/presentation/edit_seasonal_offers_screen.dart';
import 'package:oscaru95/features/merchant/edit_special_events/presentation/edit_special_events_screen.dart';
import 'package:oscaru95/features/merchant/merchant_dash_board/presentation/merchant_desh_board_screen.dart';
import 'package:oscaru95/features/merchant/merchant_delete_account/presentation/merchant_delete_account.dart';
import 'package:oscaru95/features/merchant/merchant_drinks_special/presentation/merchant_drinks_screen.dart';
import 'package:oscaru95/features/merchant/merchant_edit_password/presentation/merchant_edit_password_screen.dart';
import 'package:oscaru95/features/merchant/merchant_food_special/presentation/merchant_food_special_screen.dart';
import 'package:oscaru95/features/merchant/merchant_help_and_support/presentation/merchant_help_and_support.dart';
import 'package:oscaru95/features/merchant/merchant_privacy_policy/presentation/merchant_privacy_policy.dart';
import 'package:oscaru95/features/merchant/merchant_profile/presentation/widget/edit_profile_screen.dart';
import 'package:oscaru95/features/merchant/merchant_seasonal_offer/presentation/merchant_seasonal_offer_screen.dart';
import 'package:oscaru95/features/merchant/merchant_special_evants/presentation/merchant_special_evants.dart';
import 'package:oscaru95/features/merchant/merchant_venue_info/presentation/merchant_venue_info.dart';
import 'package:oscaru95/features/merchant/navigaion_screen.dart';
import 'package:oscaru95/features/merchant/registration/presentation/drink_special.dart';
import 'package:oscaru95/features/merchant/registration/presentation/food_special_screen.dart';
import 'package:oscaru95/features/merchant/registration/presentation/special_offer.dart';
import 'package:oscaru95/features/personalized/presentation/personalised_screen.dart';
import 'package:oscaru95/features/user/filter/presentation/filter_screen.dart';
import 'package:oscaru95/features/user/home/presentation/change_my_location_screen.dart';
import 'package:oscaru95/features/user/home/presentation/home_tile_details_screen.dart';
import 'package:oscaru95/features/user/premium_user/premium_screen.dart';
import 'package:oscaru95/features/user/profile/presentation/widgets/account_delete_screen.dart';
import 'package:oscaru95/features/user/profile/presentation/widgets/edit_password_screen.dart';
import 'package:oscaru95/features/user/profile/presentation/widgets/help_support_screen.dart';
import 'package:oscaru95/features/user/profile/presentation/widgets/review_screen.dart';
import 'package:oscaru95/features/user/profile/presentation/widgets/update_profile_screen.dart';
import 'package:oscaru95/features/user/review/presentation/shop_profile_give_review_screen.dart';
import 'package:oscaru95/features/user/review/presentation/shop_profile_ratting_review_screen.dart';
import 'package:oscaru95/features/user/setting/presentation/notification_screen.dart';
import 'package:oscaru95/features/user/setting/presentation/setting_screen.dart';
import 'package:oscaru95/features/user/stroy/add_strory.dart';
import 'package:oscaru95/loading.dart';
import 'package:oscaru95/user_navigation_screen.dart';

final class Routes {
  static final Routes _routes = Routes._internal();
  Routes._internal();
  static Routes get instance => _routes;

  static const String userNavigationScreen = '/NavigationScreen';
  static const String loginScreen = '/login_screen';
  static const String signupRoute = '/signup_screen';
  static const String signupSecondScreenRoute = '/signup_second_screen';
  static const String forgetPaswordRoute = '/forget_password_screen';
  static const String verifyOtpRoute = '/verifY_otp_screen';
  static const String premiumScreen = '/premiumScreen';
  static const String changeMyLocationScreen = '/changeMyLocationScreen';
  static const String homeTileDetailsScreen = '/homeTileDetailsScreen';
  static const String loading="/loading";
  static const String shopProfileRattingReviewScreen =
      '/shopProfileRattingReviewScreen';
  static const String shopProfileGiveReviewScreen =
      '/shopProfileGiveReviewScreen';
  static const String updateProfileScreen = '/updateProfileScreen';
  static const String editPasswordScreen = '/editPasswordScreen';
  static const String accountDeleteScreen = '/accountDeleteScreen';
  static const String helpSupportScreen = '/helpSupportScreen';
  static const String merchantNavigation = '/merchantNavigation';
  static const String drinkScreen = '/drinkScreen';
  static const String foodScreen = '/foodScreen';
  static const String specialOffer = '/specialOffer';
  static const String upgrading = '/primumScreen';
  static const String registrionVenu = '/registrionVenu';
  static const String succeessScreen = '/successScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String loginMerchantScreen = '/loginMerchantScreen';
  static const String merchantDashBorad = '/merchantDashBorad';
  static const String filterScreen = '/filterScreen';
  static const String addStory = '/addStory';
  static const String addSpecialEvants = '/add_special_evants_screen';
  static const String addSeasonalOffer = '/add_seasonal_offer_screen';
  static const String setttingScreen = '/setting_Screen';
  static const String notificationScreen = '/notificationScreen';

  // // static const String bottomNabRoute = '/bottom_nav_screen';
  // static const String registrationSetup = '/registrationSetup';

  // static const String restaurantSetup = '/restaurantSetup';

  // static const String profileScreen = '/profile_screen';
  // static const String personalInformationScreen =
  //     '/personal_information_screen';
  // static const String settingsScreen = '/settings_screen';
  // static const String contactUsScreen = '/Contact_us_screen';
  // static const String privacyPolicyScreen = '/privacy_policy_screen';
  // static const String supportfaqscreen = '/support_faq_screen';
  // static const String termsandcondition = '/terms_and_condition_screen';
  // static const String onboardingscreen = '/onboarding_screen';
  // static const String orderConfirmRoute = '/order_confirm_screen';
  // static const String bookingInfoScreenRoute = '/booking-info_screeen';
  // static const String ownerBottomNavigatinRoute =
  //     '/owner_bottom_navigation_screen';
  // static const String ownerBookingConfirmRoute =
  //     '/Owner_booking_confirm_screen';
  // static const String offerScreen = '/offer_screen';
  // static const String createOfferScreen = '/create_offer_screen';
  // static const String offerdetailsRoute = '/offer_details_screen';
  // static const String offerPriviewRoute = '/offer_preview_screen';

  /////////////// Merchant Profile Route/////////////
  static const String merchantEditPasswordScreen =
      '/merchant_edit_password_screen';
  static const String merchantDeleteAccountScreen =
      '/merchant_delete_password_screen';
  static const String merchanthelpandsupportScreen =
      '/merchant_help_and_support_screen';
  static const String merchantprivacyPolicyScreen =
      '/merchant_privacy_policy_screen';
  static const String merchantVenueInformationScreen =
      '/merchant_venue_information_screen';
  static const String merchantDrincksSpecialScreen =
      '/merchant_dricks_special_screen';
  static const String merchantFoodSpecialScreen =
      '/merchant_food_special_screen';
  static const String merchantSeasonalOfferScreen =
      '/merchant_seasonal_offer_screen';
  static const String merchantSpeacialEvantsScreen =
      '/merchant_speacial_evants_screen';
  static const String editSpecialEventsScreen = '/edit_special_evants_screen';
  static const String editSeasonalOffersScreen = '/edit_seasonal_offers_screen';
  static const String editDrinkSpeacialScreen = '/edit_drink_spcial_screen';
  static const String editFoodSpecialScreen = '/edit_food_spcial_screen';
  static const String personalizedScreen = '/personalizedScreen';
  static const String reviewScreen = '/reviewScreen';
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();
  RouteGenerator._internal();
  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const LoginScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const LoginScreen(),
              );
      case Routes.signupRoute:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const RegisterScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const RegisterScreen(),
              );

      case Routes.verifyOtpRoute:
        final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: VerifyOtpScreen(
                  email: args["email"],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => VerifyOtpScreen(
                  email: args["email"],
                ),
              );

      case Routes.merchantNavigation:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const MarchentNavigationScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const MarchentNavigationScreen(),
              );

      case Routes.notificationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const NotificationScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const NotificationScreen(),
              );

        case Routes.loading:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const Loading(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const Loading(),
              );
        

      case Routes.forgetPaswordRoute:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ForgetPasswordScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const ForgetPasswordScreen(),
              );

      case Routes.premiumScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const PremiumScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const PremiumScreen(),
              );
      case Routes.setttingScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const SettingScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const SettingScreen(),
              );
      case Routes.changeMyLocationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ChangeMyLocationScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const ChangeMyLocationScreen(),
              );
      case Routes.homeTileDetailsScreen:
        final args = settings.arguments as Map;

        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: HomeTileDetailsScreen(
                  
                  id: args['id'],
                  isWishlisted: args['isWishlisted'],
                  profileImage: args['image'],
                  title: args['title'],
                  type: args['type'],
                  location: args['location'],
                  distance: args['distance'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => HomeTileDetailsScreen(
                  isWishlisted: args['isWishlisted'],
                  id: args['id'],
                   profileImage: args['image'],
                  title: args['title'],
                  type: args['type'],
                  location: args['location'],
                  distance: args['distance'],
                ),
              );
      case Routes.shopProfileRattingReviewScreen:
              final args = settings.arguments as Map;

        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget:  ShopProfileRattingReviewScreen(profileId: args['id'],),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) =>  ShopProfileRattingReviewScreen(profileId: args['id'],),
              );
      case Routes.shopProfileGiveReviewScreen:
                    final args = settings.arguments as Map;

        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget:  ShopProfileGiveReviewScreen(profileId: args['id'],), settings: settings)
            : CupertinoPageRoute(
                builder: (context) =>  ShopProfileGiveReviewScreen(profileId: args['id'],),
              );
      case Routes.updateProfileScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const UpdateProfileScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const UpdateProfileScreen(),
              );
      case Routes.editPasswordScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const EditPasswordScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const EditPasswordScreen(),
              );
      case Routes.accountDeleteScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const AccountDeleteScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const AccountDeleteScreen(),
              );
      case Routes.helpSupportScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const HelpSupportScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const HelpSupportScreen(),
              );
      case Routes.drinkScreen:
        final args = settings.arguments as Map;

        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: DrinkSpecialScreen(
                  status: args['status'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const DrinkSpecialScreen(),
              );

      case Routes.foodScreen:
        final args = settings.arguments as Map;

        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: FoodSpecialScreen(
                  status: args['status'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => FoodSpecialScreen(
                  status: args['status'],
                ),
              );
      case Routes.specialOffer:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const SpecialOfferScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const SpecialOfferScreen(),
              );
      case Routes.merchantEditPasswordScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const MerchantEditPasswordScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const MerchantEditPasswordScreen(),
              );
      case Routes.addStory:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const StoryPage(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const StoryPage(),
              );

      case Routes.merchantDashBorad:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const MerchantDeshBoardScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const MerchantDeshBoardScreen(),
              );
      case Routes.merchantDeleteAccountScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const MerchantDeleteAccount(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const MerchantDeleteAccount(),
              );
      case Routes.merchanthelpandsupportScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const MerchantHelpAndSupport(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const MerchantHelpAndSupport(),
              );
      case Routes.merchantprivacyPolicyScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const MerchantPrivacyPolicy(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const MerchantPrivacyPolicy(),
              );
      case Routes.merchantVenueInformationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const MerchantVenueInfo(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const MerchantVenueInfo(),
              );
      case Routes.merchantDrincksSpecialScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const MerchantDrinksScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const MerchantDrinksScreen(),
              );
      case Routes.merchantFoodSpecialScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const MerchantFoodSpecialScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const MerchantFoodSpecialScreen(),
              );


       case Routes.reviewScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ReviewScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const ReviewScreen(),
              );        

      case Routes.editProfileScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const EditProfileScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const EditProfileScreen(),
              );

      case Routes.loginMerchantScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const LoginMerchantScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const LoginMerchantScreen(),
              );
      case Routes.merchantSeasonalOfferScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const MerchantSeasonalOfferScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const MerchantSeasonalOfferScreen(),
              );
      case Routes.merchantSpeacialEvantsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const MerchantSpeacialevantsScreenn(),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const MerchantSpeacialevantsScreenn(),
              );
      case Routes.filterScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const FilterScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const FilterScreen(),
              );
      case Routes.editSpecialEventsScreen:
        final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: EditSpecialEventsScreen(
                  id: args['id'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => EditSpecialEventsScreen(id: args['id']),
              );
      case Routes.editSeasonalOffersScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const EditSeasonalOffersScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const EditSeasonalOffersScreen(),
              );
      case Routes.editDrinkSpeacialScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const EditDrinkSpecialScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const EditDrinkSpecialScreen(),
              );
      case Routes.personalizedScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const PersonalizedScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const PersonalizedScreen(),
              );
      case Routes.editFoodSpecialScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const EditFoodSpecialScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const EditFoodSpecialScreen(),
              );

      case Routes.addSpecialEvants:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const AddSpecialOfferScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const AddSpecialOfferScreen(),
              );
      case Routes.addSeasonalOffer:
        final args = settings.arguments as Map;

        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: AddSeasonalOfferSccren(
                  status: args['status'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => AddSeasonalOfferSccren(
                  status: args['status'],
                ),
              );

      // case Routes.bottomNabRoute:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: const BottomNavScreen(), settings: settings)
      //       : CupertinoPageRoute(
      //           builder: (context) => const BottomNavScreen(),
      //         );

      case Routes.userNavigationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const UserNavigationScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const UserNavigationScreen(),
              );
      case Routes.succeessScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const RegistraionSuccessScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const RegistraionSuccessScreen(),
              );

      case Routes.registrionVenu:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const RegistrationVenuScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const RegistrationVenuScreen(),
              );

      default:
        return null;
    }
  }
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({required this.widget, required this.settings})
      : super(
          settings: settings,
          reverseTransitionDuration: const Duration(milliseconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 1),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.ease,
              ),
              child: child,
            );
          },
        );
}

class ScreenTitle extends StatelessWidget {
  final Widget widget;

  const ScreenTitle({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: .5, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: widget,
    );
  }
}
