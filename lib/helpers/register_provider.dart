import 'package:oscaru95/provider/auth_provider.dart';
import 'package:oscaru95/provider/discover_provider.dart';
import 'package:oscaru95/provider/filter_provider.dart';
import 'package:oscaru95/provider/offer_provider.dart';
import 'package:oscaru95/provider/personalize_provider.dart';
import 'package:oscaru95/provider/premium_provider.dart';
import 'package:oscaru95/provider/user_home_provider.dart';
import 'package:oscaru95/provider/venue_information_provider.dart';
import 'package:provider/provider.dart';

import '../provider/reset_password_provider.dart';
import '../provider/upload_profile_picture_provider.dart';

var providers = [
  ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
  ChangeNotifierProvider<OfferProvider>(create: (context) => OfferProvider()),
  ChangeNotifierProvider<PremiumProvider>(
      create: (context) => PremiumProvider()),
  ChangeNotifierProvider<VenueInformationProvider>(
      create: (context) => VenueInformationProvider()),
  ChangeNotifierProvider<FilterProvider>(create: (context) => FilterProvider()),
  ChangeNotifierProvider<UploadProfilePictureProvider>(
      create: (context) => UploadProfilePictureProvider()),
  ChangeNotifierProvider<ResetPasswordProvider>(
      create: (context) => ResetPasswordProvider()),
  ChangeNotifierProvider<UserHomeProvider>(
      create: (context) => UserHomeProvider()),
  ChangeNotifierProvider<DiscoverProvider>(
      create: (context) => DiscoverProvider()),
  ChangeNotifierProvider<PersonalizedProvider>(
      create: (context) => PersonalizedProvider())
];
