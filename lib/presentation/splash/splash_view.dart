import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tut_app_with_clean_architecture/app/app_prefs.dart';
import 'package:tut_app_with_clean_architecture/app/di.dart';
import 'package:tut_app_with_clean_architecture/presentation/resources/assets_manager.dart';
import 'package:tut_app_with_clean_architecture/presentation/resources/color_manager.dart';
import 'package:tut_app_with_clean_architecture/presentation/resources/constants_manager.dart';
import 'package:tut_app_with_clean_architecture/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() async {
    // navigate to main screen
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) {
      if (isUserLoggedIn) {
        Navigator.pushReplacementNamed(context, Routes.homeRoute);
      } else {
        // navigate to login screen
        _appPreferences
            .isOnBoardingScreenViewed()
            .then((isOnBoardingScreenViewed) {
          if (isOnBoardingScreenViewed) {
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          } else {
            // navigate to onBoarding screen
            Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
