import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app_with_clean_architecture/app/di.dart';
import 'package:tut_app_with_clean_architecture/presentation/forgot_password/view/forgot_password_view.dart';
import 'package:tut_app_with_clean_architecture/presentation/login/view/login_view.dart';
import 'package:tut_app_with_clean_architecture/presentation/main/main_view.dart';
import 'package:tut_app_with_clean_architecture/presentation/onBoarding/view/onBoarding_view.dart';
import 'package:tut_app_with_clean_architecture/presentation/register/view/register_view.dart';
import 'package:tut_app_with_clean_architecture/presentation/resources/strings_manager.dart';
import 'package:tut_app_with_clean_architecture/presentation/splash/splash_view.dart';
import 'package:tut_app_with_clean_architecture/presentation/store_detail/view/store_detail_view.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgetPasswordRoute = '/forgetPassword';
  static const String homeRoute = '/main';
  static const String storeDetailsRoute = '/storeDetail';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgetPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.homeRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        initStoreDetailsModule();
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(AppStrings.noRouteFound.tr()),
              ),
              body: Center(child: Text(AppStrings.noRouteFound.tr()),),
            ));
  }
}
