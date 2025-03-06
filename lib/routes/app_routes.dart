import 'package:final_project/pages/auth/login.dart';
import 'package:final_project/pages/index.dart';
import 'package:final_project/pages/user/home.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String daftar = '/daftar';
  static const String welcome = '/';
  static const String splashScreen = '/splashScreen';
  static const home = '/home';

static final routes = [
  GetPage(name: splashScreen, page: () => SplashScreen()),
  GetPage(name: login, page: () => AuthScreen()),
  GetPage(name: home, page: () => HomePage()),
];

}