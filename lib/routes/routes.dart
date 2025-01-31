import 'package:curve_navbar/screens/login/login_screen.dart';
import 'package:curve_navbar/screens/main/home_screen.dart';
import 'package:curve_navbar/screens/onboarding/onboarding_screen.dart';
import 'package:curve_navbar/screens/main/profile_screen.dart';
import 'package:curve_navbar/screens/main/search_screen.dart';
import 'package:curve_navbar/screens/onboarding/splash_screen.dart';
import 'package:curve_navbar/screens/sign%20up/sign_up_screen.dart';
import 'package:get/get.dart';

import '../screens/main/favorite_screen.dart';

class Routes {
  static String splashScreen = "/";
  static String onboardingScreen = "/onboardingScreen";
  static String loginScreen = "/loginScreen";
  static String signUpScreen = "/signUpScreen";

  static String homeScreen = "/homeScreen";
  static String favoriteScreen = "/favoriteScreen";
  static String searchScreen = "/searchScreen";
  static String ticketScreen = "/ticketScreen";
  static String profileScreen = "/profileScreen";
  static String detailScreen = "/detailScreen";
  static String reservationScreen = "/reservationScreen";

  static getSplashPage() => splashScreen;
  static getLoginPage() => loginScreen;
  static getSignUpPage() => signUpScreen;

  static getHomePage() => homeScreen;
  static getSearchPage() => searchScreen;
  static getTicketPage() => ticketScreen;
  static getProfilePage() => profileScreen;
  static getDetailPage() => detailScreen;
  static getReservationPage() => reservationScreen;
  static getOnboardingPage() => onboardingScreen;

  static List<GetPage> routes = [
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: loginScreen,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: signUpScreen,
      page: () => const SignupScreen(),
    ),

    GetPage(
      name: homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: favoriteScreen,
      page: () => const FavoriteScreen(),
    ),
    GetPage(
      name: searchScreen,
      page: () => const SearchScreen(),
    ),
    // GetPage(
    //   name: ticketScreen,
    //   page: () =>  const TicketFillScreen(),
    // ),
    GetPage(
      name: profileScreen,
      page: () => const ProfileScreen(),
    ),
    // GetPage(
    //   name: detailScreen,
    //   page: () =>  const DetailScreen(),
    // ),
    // GetPage(
    //   name: reservationScreen,
    //   page: () => const ResponsiveScreen(),
    // ),
    GetPage(
      name: onboardingScreen,
      page: () => const OnboardingScreen(),
    ),
  ];
}
