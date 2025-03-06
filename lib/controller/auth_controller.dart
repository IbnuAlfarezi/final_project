import 'package:final_project/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/custom_snackbar.dart'; // Import CustomSnackbar

class AuthController extends GetxController {
  var isRegister = true.obs;
  var isLoading = false.obs;

  // Firebase Auth Instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Controllers for text input fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void toggleAuthMode() {
    isRegister.value = !isRegister.value;
  }

  // Handle Authentication
  Future<void> handleAuth() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      CustomSnackbar.show("Error", "Email and password cannot be empty", isSuccess: false);
      return;
    }

    isLoading.value = true;

    try {
      if (isRegister.value) {
        if (password != confirmPassword) {
          CustomSnackbar.show("Error", "Passwords do not match", isSuccess: false);
          isLoading.value = false;
          return;
        }

        await _auth.createUserWithEmailAndPassword(email: email, password: password);
        CustomSnackbar.show("Success", "Account created successfully", isSuccess: true);
        emailController.clear();
        passwordController.clear();
        isRegister.value = false;
        
      } else {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        CustomSnackbar.show("Success", "Login successful", isSuccess: true);
        Get.offAllNamed(AppRoutes.home);
      }
    } on FirebaseAuthException catch (e) {
      CustomSnackbar.show("Error", e.message ?? "An error occurred", isSuccess: false);
    }

    isLoading.value = false;
  }
}
