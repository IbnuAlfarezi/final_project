import 'package:final_project/pages/auth/login.dart';
import 'package:final_project/pages/index.dart';
import 'package:final_project/pages/user/detail_page.dart';
import 'package:final_project/pages/user/home.dart';
import 'package:final_project/pages/user/profile.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String daftar = '/daftar';
  static const String welcome = '/';
  static const String splashScreen = '/splashScreen';
  static const String home = '/home';
  static const String detailPage = '/detail';
  static const String profile = '/profile';

static final routes = [
  GetPage(name: splashScreen, page: () => SplashScreen()),
  GetPage(name: login, page: () => AuthScreen()),
  GetPage(name: home, page: () => HomePage()),
  GetPage(name: detailPage, page: () => DetailPage()),
  GetPage(name: profile, page: () => ProfilePage()),
];

}