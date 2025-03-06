import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void show(String title, String message, {bool isSuccess = true}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      colorText: Colors.white,
      icon: Icon(
        isSuccess ? Icons.check_circle : Icons.error,
        color: Colors.white,
      ),
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 3),
    );
  }
}
