import 'package:final_project/components/custom_snackbar.dart';
import 'package:final_project/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AuthController extends GetxController {
  var isRegister = true.obs;
  var isLoading = false.obs;
  var userName = "".obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Tambahkan controller untuk nama
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void toggleAuthMode() {
    isRegister.value = !isRegister.value;
  }

  Future<void> handleAuth() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      CustomSnackbar.show("Error", "Email dan password tidak boleh kosong", isSuccess: false);
      return;
    }

    isLoading.value = true;

    try {
      if (isRegister.value) {
        if (name.isEmpty) {
          CustomSnackbar.show("Error", "Nama tidak boleh kosong", isSuccess: false);
          isLoading.value = false;
          return;
        }
        if (password != confirmPassword) {
          CustomSnackbar.show("Error", "Password tidak cocok", isSuccess: false);
          isLoading.value = false;
          return;
        }

        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password
        );

        // Update nama pengguna setelah registrasi
        await userCredential.user?.updateDisplayName(name);

        CustomSnackbar.show("Success", "Akun berhasil dibuat", isSuccess: true);
        emailController.clear();
        passwordController.clear();
        nameController.clear();
        isRegister.value = false;
        
      } else {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        CustomSnackbar.show("Success", "Login berhasil", isSuccess: true);
        Get.offAllNamed(AppRoutes.home);
      }
    } on FirebaseAuthException catch (e) {
      CustomSnackbar.show("Error", e.message ?? "Terjadi kesalahan", isSuccess: false);
    }

    isLoading.value = false;
  }
}
