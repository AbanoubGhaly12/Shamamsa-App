import 'package:flutter/material.dart';
import 'package:shamamsa_app/presentation/screen/home_setting/home_setting_screen.dart';
import 'package:shamamsa_app/presentation/screen/section/scan_screen.dart';
import '../../core/service_locator/service_locator.dart';
import '../../presentation/screen/department/department_screen.dart';
import '../../presentation/screen/details/details_screen.dart';
import '../../presentation/screen/login/login_screen.dart';
import '../../presentation/screen/section/section_screen.dart';

class Routes {
  static const String splashRoute = "/splash";
  static const String mainRoute = "/mainRoute";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/auth/login";
  static const String registerRoute = "/auth/register";
  static const String forgetPasswordRoute = "/auth/forget_password";
  static const String resetPasswordRoute =
      "/auth/forget_password/reset_password";
  static const String demoRoute = "/auth/demoRoute/demoRoute";

  static const String departmentRoute = "/auth/departmentRoute/departmentRoute";
  static const String scanRoute = "/auth/sectionRoute/scanRoute";
  static const String sectionRoute = "/auth/sectionRoute/sectionRoute";
  static const String homeSettingRoute = "/auth/homeSettingRoute/homeSettingRoute";
  static const String detailsRoute = "/auth/detailsRoute/detailsRoute";
}

class RouteGenerator {
  static Route<dynamic>? getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.loginRoute:
        initLoginViewModel();
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case Routes.departmentRoute:
        initDepartmentViewModel();
        return MaterialPageRoute(builder: (_) => const DepartmentScreen());

        case Routes.homeSettingRoute:
        initHomeSettingViewModel();
        String argument = routeSettings.arguments as String;
        return MaterialPageRoute(builder: (_) =>  HomeSettingScreen(collectionReferenceId: argument,));

        case Routes.detailsRoute:
        initDetailsViewModel();
        String argument = routeSettings.arguments as String;
        return MaterialPageRoute(builder: (_) =>  DetailsScreen(collectionReferenceId: argument,));
      case Routes.scanRoute:
        initSectionViewModel();
        String argument = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => ScanScreen(collectionReferenceId: argument));
      case Routes.sectionRoute:
        initSectionViewModel();
        List<String?> list = routeSettings.arguments as List<String?>;
        String? username = list[1];
        String? collectionId = list[0];
        return MaterialPageRoute(
            builder: (_) => SectionsScreen(
                  collectionReferenceId: collectionId??"",
                  username: username??"",
                ));
    }
    return null;
  }
}
