import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/pages/auth/login.dart';
import 'package:final_project/pages/index.dart';
import 'package:final_project/pages/user/detail_page.dart';
import 'package:final_project/pages/user/home.dart';
import 'package:final_project/routes/app_routes.dart';
import 'package:final_project/config/job_api.dart'; // Import JobApi
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('users').get();
    print("✅ Firestore berhasil terhubung!");
  } catch (e) {
    print("❌ Gagal menghubungkan Firestore: $e");
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(  // Wrap with MultiProvider
      providers: [
        ChangeNotifierProvider(create: (context) => JobApi()), 
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.welcome,
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        getPages: AppRoutes.routes,
        home: SplashScreen(),
      ),
    );
  }
}
