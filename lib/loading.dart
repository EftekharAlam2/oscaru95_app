import 'package:flutter/material.dart';
import 'package:oscaru95/constants/app_constants.dart';
import 'package:oscaru95/constants/app_constants.dart';
import 'package:oscaru95/features/auth/presentation/role/presentation/role_select_screen.dart';
import 'package:oscaru95/features/merchant/navigaion_screen.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/user_navigation_screen.dart';
import 'package:oscaru95/helpers/helpers_method.dart'; // for setInitValue
import 'package:oscaru95/helpers/di.dart'; // for appData

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    await setInitValue();

    bool data = appData.read(kKeyIsLoggedIn) ?? false;
    if (data) {
      String token = appData.read(kKeyAccessToken);
      DioSingleton.instance.update(token);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
     return const RoleSelectScreen();
    }

    final bool isLoggedIn = appData.read(kKeyIsLoggedIn) ?? false;
    final String? accountType = appData.read(kKeyAccountType);

    if (isLoggedIn) {
      if (accountType == 'user') {
        return const UserNavigationScreen();
      } else {
        return const MarchentNavigationScreen();
      }
    } else {
      return const RoleSelectScreen();
    }
  }
}
