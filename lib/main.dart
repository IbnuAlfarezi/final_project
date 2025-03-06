import 'package:final_project/pages/index.dart';
import 'package:final_project/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.welcome, 
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white
      ),
      getPages: AppRoutes.routes, 
      home: SplashScreen(),
    );
  }
}
