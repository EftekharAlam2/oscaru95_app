import 'dart:developer';
import 'dart:io';

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oscaru95/constants/custome_theme.dart';
import 'package:oscaru95/features/splash/presentation/welcome_screen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/di.dart';
import 'package:oscaru95/helpers/helpers_method.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/register_provider.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  diSetUp();
  initInternetChecker();
  DioSingleton.instance.create();

  bool isSimulator = false;
  if (Platform.isIOS && Platform.environment.containsKey('SIMULATOR_DEVICE_NAME')) {
    isSimulator = true;
    log('Running on an iOS simulator. Skipping high refresh rate setting.');
  }

  if (!isSimulator && Platform.isAndroid) {
    try {
      await FlutterDisplayMode.setHighRefreshRate();
      log('High refresh rate mode set successfully.');
    } catch (e) {
      log('Error setting high refresh rate at main: $e');
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    rotation();
    setInitValue();
    return MultiProvider(
      providers: providers,
      child: AnimateIfVisibleWrapper(
        showItemInterval: const Duration(milliseconds: 150),
        child: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) async {
            showMaterialDialog(context);
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return const UtillScreenMobile();
            },
          ),
        ),
      ),
    );
  }
}

class UtillScreenMobile extends StatelessWidget {
  const UtillScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context),
              child: widget!,
            );
          },
          theme: ThemeData(
            primarySwatch: CustomTheme.kToDark,
            primaryColor: AppColors.allPrimaryColor,
            useMaterial3: false,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.scaffoldColor,
              elevation: 0,
              foregroundColor: AppColors.c000000,
            ),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: AppColors.cFFFFFF,
            ),
            scaffoldBackgroundColor: AppColors.scaffoldColor,
          ),
          navigatorKey: NavigationService.navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,
          home: const WelcomeScreen(),
        );
      },
    );
  }
}
