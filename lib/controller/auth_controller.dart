import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      Get.snackbar("Error", "Email and password cannot be empty",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;

    try {
      if (isRegister.value) {
        if (password != confirmPassword) {
          Get.snackbar("Error", "Passwords do not match",
              snackPosition: SnackPosition.BOTTOM);
          isLoading.value = false;
          return;
        }

        await _auth.createUserWithEmailAndPassword(email: email, password: password);
        Get.snackbar("Success", "Account created successfully",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        Get.snackbar("Success", "Login successful",
            snackPosition: SnackPosition.BOTTOM);
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "An error occurred",
          snackPosition: SnackPosition.BOTTOM);
    }

    isLoading.value = false;
  }
}
