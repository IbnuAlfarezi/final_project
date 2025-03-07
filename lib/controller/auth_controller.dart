import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/components/custom_snackbar.dart';
import 'package:final_project/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isRegister = true.obs;
  var isLoading = false.obs;
  var userName = "".obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Tambahkan controller untuk input tambahan
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

        User? user = userCredential.user;

        if (user != null) {
          await user.updateDisplayName(name);

          try {
            // Simpan data pengguna ke Firestore
            await _firestore.collection('users').doc(user.uid).set({
              'name': name,
              'email': email,
              'imageUrl': '', 
              'CountryRegion': '',
              'Birth': '',
              'createdAt': FieldValue.serverTimestamp(),
            });

            CustomSnackbar.show("Success", "Akun berhasil dibuat dan data disimpan", isSuccess: true);
          } catch (e) {
            CustomSnackbar.show("Error", "Gagal menyimpan data ke Firestore: $e", isSuccess: false);
          }
        }

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
