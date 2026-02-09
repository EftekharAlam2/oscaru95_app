import 'package:oscaru95/features/auth/data/otp_verify/rx.dart';
import 'package:oscaru95/features/auth/data/rx_user_login/rx.dart';
import 'package:oscaru95/features/auth/data/rx_user_signup/rx.dart';
import 'package:oscaru95/features/auth/model/user_login_response.dart';
import 'package:oscaru95/features/auth/model/user_signup_response.dart';
import 'package:oscaru95/features/auth/model/verifyOtp_model.dart';
import 'package:oscaru95/features/merchant/add_seasonal_offer/data/rx_add_sessonal_offer/rx.dart';
import 'package:oscaru95/features/merchant/add_special_offer/data/rx_add_special_offer/rx.dart';
import 'package:oscaru95/features/merchant/analytics/presentation/data/rating_rx/rx.dart';
import 'package:oscaru95/features/merchant/analytics/presentation/data/top_deals_rx/rx.dart';
import 'package:oscaru95/features/merchant/analytics/presentation/model/rating_model_response.dart';
import 'package:oscaru95/features/merchant/analytics/presentation/model/top_deals_model.dart';
import 'package:oscaru95/features/merchant/auth/data/rx_get_establishment/rx.dart';
import 'package:oscaru95/features/merchant/auth/data/rx_marchent_signup/rx.dart';
import 'package:oscaru95/features/merchant/edit_special_events/data/rx_edit_special_offer/rx.dart';
import 'package:oscaru95/features/merchant/merchant_delete_account/data/rx_delete_user/rx.dart';
import 'package:oscaru95/features/merchant/merchant_drinks_special/data/rx_get_drink_special/rx.dart';
import 'package:oscaru95/features/merchant/merchant_drinks_special/model/drink_special_response.dart';
import 'package:oscaru95/features/merchant/merchant_edit_password/data/rx_edit_password/rx.dart';
import 'package:oscaru95/features/merchant/merchant_food_special/data/rx_get_food_special/rx.dart';
import 'package:oscaru95/features/merchant/merchant_food_special/model/food_special_response.dart';
import 'package:oscaru95/features/merchant/merchant_profile/data/post_gallary_rx/rx.dart';
import 'package:oscaru95/features/merchant/merchant_profile/data/rx_business_profile/rx.dart';
import 'package:oscaru95/features/merchant/merchant_profile/data/rx_logout_marchent/rx.dart';
import 'package:oscaru95/features/merchant/merchant_profile/data/rx_menu/rx.dart';
import 'package:oscaru95/features/merchant/merchant_profile/model/busniess_profile_response.dart';
import 'package:oscaru95/features/merchant/merchant_profile/model/menu_model.dart';
import 'package:oscaru95/features/merchant/merchant_seasonal_offer/data/rx_cancel_sessonal_offer/rx.dart';
import 'package:oscaru95/features/merchant/merchant_seasonal_offer/data/rx_get_sessonal_offer/rx.dart';
import 'package:oscaru95/features/merchant/merchant_seasonal_offer/model/sessonal_offer_response.dart';
import 'package:oscaru95/features/merchant/merchant_special_evants/data/rx_event_details/rx.dart';
import 'package:oscaru95/features/merchant/merchant_special_evants/data/rx_get_special_offer/rx.dart';
import 'package:oscaru95/features/merchant/merchant_special_evants/model/event_details_response.dart';
import 'package:oscaru95/features/merchant/merchant_special_evants/model/special_offer_response.dart';
import 'package:oscaru95/features/merchant/merchant_venue_info/data/rx_edit_menu/rx.dart';
import 'package:oscaru95/features/merchant/registration/data/categories/rx.dart';
import 'package:oscaru95/features/merchant/registration/data/cuisine/rx.dart';
import 'package:oscaru95/features/merchant/registration/data/drinkRegistration/rx.dart';
import 'package:oscaru95/features/merchant/registration/model/categoires_model.dart';
import 'package:oscaru95/features/merchant/registration/model/drink_registarion_model.dart';
import 'package:oscaru95/features/splash/data/rx.dart';
import 'package:oscaru95/features/splash/model/splash_response.dart';
import 'package:oscaru95/features/user/discover/data/comment_Rx/rx.dart';
import 'package:oscaru95/features/user/discover/data/like_rx/rx.dart';
import 'package:oscaru95/features/user/favourite/data/rx_add_favourite/rx.dart';
import 'package:oscaru95/features/user/favourite/data/rx_get_favourite/rx.dart';
import 'package:oscaru95/features/user/favourite/model/favourite_response.dart';
import 'package:oscaru95/features/user/filter/data/rx.dart';
import 'package:oscaru95/features/user/home/data/rx_get_discover/rx.dart';
import 'package:oscaru95/features/user/home/data/rx_home/rx.dart';
import 'package:oscaru95/features/user/home/model/discover_response.dart';
import 'package:oscaru95/features/user/home/model/nearest_shop_response.dart';
import 'package:oscaru95/features/user/profile/data/edit_pass_rx/rx.dart';
import 'package:oscaru95/features/user/profile/data/feedback_rx/rx.dart';
import 'package:oscaru95/features/user/profile/data/list_venu_rx/rx.dart';
import 'package:oscaru95/features/user/profile/data/rx_delete_user/rx.dart';
import 'package:oscaru95/features/user/profile/data/rx_get_user_profile/rx.dart';
import 'package:oscaru95/features/user/profile/data/rx_logout_user/rx.dart';
import 'package:oscaru95/features/user/profile/data/update_profile_rx/rx.dart';
import 'package:oscaru95/features/user/profile/model/list_of_model.dart';
import 'package:oscaru95/features/user/profile/model/password_response.dart';
import 'package:oscaru95/features/user/profile/model/update_profile.dart';
import 'package:oscaru95/features/user/profile/model/user_profile_response.dart';
import 'package:oscaru95/features/user/review/data/rx_add_review/rx.dart';
import 'package:oscaru95/features/user/review/data/rx_get_review/rx.dart';
import 'package:oscaru95/features/user/review/model/review_response.dart';
import 'package:oscaru95/features/user/setting/data/my_notification_rx/rx.dart';
import 'package:oscaru95/features/user/setting/data/post_status_rx/rx.dart';
import 'package:oscaru95/features/user/setting/data/status_rx/rx.dart';
import 'package:oscaru95/features/user/setting/data/story_rx/rx.dart';
import 'package:oscaru95/features/user/setting/model/my_notification_model.dart';
import 'package:oscaru95/features/user/setting/model/status_model.dart';
import 'package:oscaru95/features/user/setting/model/story_model.dart';
import 'package:rxdart/subjects.dart';

GetSplashRx getSplashRx = GetSplashRx(
    empty: SplashResponse(), dataFetcher: BehaviorSubject<SplashResponse>());

UserLoginRX userLoginRX = UserLoginRX(
    empty: UserLoginResponse(),
    dataFetcher: BehaviorSubject<UserLoginResponse>());

UserLogoutRx userLogoutRx =
    UserLogoutRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetUserProfileRx getUserProfileRx = GetUserProfileRx(
    empty: UserProfileResponse(),
    dataFetcher: BehaviorSubject<UserProfileResponse>());

DeleteUserProfileRx deleteUserProfileRxObj =
    DeleteUserProfileRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetFavouriteRx getFavouriteRx = GetFavouriteRx(
    empty: FavouriteResponse(),
    dataFetcher: BehaviorSubject<FavouriteResponse>());

AddFavouriteRx addFavouriteRx =
    AddFavouriteRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetDiscoverRx getDiscoverRx = GetDiscoverRx(
    empty: DiscoverResponse(),
    dataFetcher: BehaviorSubject<DiscoverResponse>());

GetNearestRx getNearestRx = GetNearestRx(
    empty: NearestShopResponse(),
    dataFetcher: BehaviorSubject<NearestShopResponse>());

GetReviewRx getReviewRx = GetReviewRx(
    empty: ReviewResponse(), dataFetcher: BehaviorSubject<ReviewResponse>());

AddReviewRx addReviewRx =
    AddReviewRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetEstablishmentRx getEstablishment = GetEstablishmentRx(
    empty: CategoriesModel(), dataFetcher: BehaviorSubject<CategoriesModel>());

BusniessProfileRx busniessProfileRx = BusniessProfileRx(
    empty: BusinessProfileResponse(),
    dataFetcher: BehaviorSubject<BusinessProfileResponse>());

BusniessEditPassRx busniessEditPassRx =
    BusniessEditPassRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

MarchentLogoutRx marchentLogoutRx =
    MarchentLogoutRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

DeleteBusinessProfileRx deleteBusinessProfileRx =
    DeleteBusinessProfileRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetFoodSpecialRx getFoodSpecialRx = GetFoodSpecialRx(
    empty: FoodSpecialResponse(),
    dataFetcher: BehaviorSubject<FoodSpecialResponse>());

GetDrinkSpecialRx getDrinkSpecialRx = GetDrinkSpecialRx(
    empty: DrinkSpecialResponse(),
    dataFetcher: BehaviorSubject<DrinkSpecialResponse>());

GetSessonalOfferRx getSessonalOfferRx = GetSessonalOfferRx(
    empty: SeasonalOfferResponse(),
    dataFetcher: BehaviorSubject<SeasonalOfferResponse>());

CancelSessonalOfferRx cancelSessonalOfferRx =
    CancelSessonalOfferRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetSpecialOfferRx getSpecialOfferRx = GetSpecialOfferRx(
    empty: SpecialOfferResponse(),
    dataFetcher: BehaviorSubject<SpecialOfferResponse>());

AddSpecialEventRx addSpecialEventRx =
    AddSpecialEventRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

AddSessonalEventRx addSessonalEventRx =
    AddSessonalEventRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

EditSpecialEventRx editSpecialEventRx =
    EditSpecialEventRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetEventDetailsRx getEventDetailsRx = GetEventDetailsRx(
    empty: EventDetailsResponse(),
    dataFetcher: BehaviorSubject<EventDetailsResponse>());

EditMenuRx editMenuRx =
    EditMenuRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetCategoriesRx getCategoriesRxObj = GetCategoriesRx(
    empty: CategoriesModel(), dataFetcher: BehaviorSubject<CategoriesModel>());
AddItemRx addItemRxObj = AddItemRx(
    empty: AddItemModel(), dataFetcher: BehaviorSubject<AddItemModel>());
GetCusinRx getCusinRxObj = GetCusinRx(
    empty: CategoriesModel(), dataFetcher: BehaviorSubject<CategoriesModel>());
UserSignupRx userSignupRxObj = UserSignupRx(
    empty: UserSignupResponse(),
    dataFetcher: BehaviorSubject<UserSignupResponse>());
OtpVerifyRx otpVerifyRxObj = OtpVerifyRx(
    empty: VerifyOtpModel(), dataFetcher: BehaviorSubject<VerifyOtpModel>());
UserMarchentRx userMarchentRxObj = UserMarchentRx(
    empty: UserSignupResponse(),
    dataFetcher: BehaviorSubject<UserSignupResponse>());
GetMenuRx getMenuRxObj =
    GetMenuRx(empty: MenuModel(), dataFetcher: BehaviorSubject<MenuModel>());
CommentRx commentRxObj =
    CommentRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
LikePostRx likePostRxObj =
    LikePostRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

StatusRx statusRxObj =
    StatusRx(empty: StatusModel(), dataFetcher: BehaviorSubject<StatusModel>());

PostStatusRx postStatusRxObj =
    PostStatusRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

NotificationRx notificationRxObj = NotificationRx(
    empty: NotificationModel(),
    dataFetcher: BehaviorSubject<NotificationModel>());

FoodListRx foodListRxObj = FoodListRx(
    empty: FoodListModel(), dataFetcher: BehaviorSubject<FoodListModel>());

GetStoryRx storyRxObj =
    GetStoryRx(empty: StoryModel(), dataFetcher: BehaviorSubject<StoryModel>());

StoryUploadrRx storyUploadrRxObj =
    StoryUploadrRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

UpdateProfileRx updateProfileRxObj = UpdateProfileRx(
    empty: UpdateProfileModel(),
    dataFetcher: BehaviorSubject<UpdateProfileModel>());

UpdatePasswordRx updatePasswordRxObj = UpdatePasswordRx(
    empty: PasswordResponse(),
    dataFetcher: BehaviorSubject<PasswordResponse>());

FeedBackRx feedBackRxObj =
    FeedBackRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
AnlayticsRx anlayticsRx = AnlayticsRx(
    empty: TopDealsModel(), dataFetcher: BehaviorSubject<TopDealsModel>());

RatingRx ratingRxObj = RatingRx(
    empty: RatingSummaryModel(),
    dataFetcher: BehaviorSubject<RatingSummaryModel>());

DisoverFilterRx disoverFilterRxObj =
    DisoverFilterRx(empty: DiscoverResponse(), dataFetcher: BehaviorSubject<DiscoverResponse>());
