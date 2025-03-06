import 'package:final_project/pages/index.dart';
import 'package:final_project/pages/user/home.dart';
import 'package:final_project/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
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
      home: HomePage(),
    );
  }
}
