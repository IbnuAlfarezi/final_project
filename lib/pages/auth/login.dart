import 'package:final_project/components/custom_button.dart';
import 'package:final_project/components/custom_text_field.dart';
import 'package:final_project/components/tab_button.dart';
import 'package:final_project/controller/auth_controller.dart';
import 'package:final_project/style/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../style/color_style.dart';

class AuthScreen extends StatelessWidget {
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            RichText(
              text: TextSpan(
                style: AppTextStyles.splashScreenHeading,
                children: [
                  const TextSpan(text: "Job"),
                  TextSpan(text: "Now", style: TextStyle(color: AppColors.splashHeading2)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => TabButton(
                        text: "Register",
                        isSelected: controller.isRegister.value,
                        onTap: () => controller.toggleAuthMode(),
                      )),
                  Obx(() => TabButton(
                        text: "Login",
                        isSelected: !controller.isRegister.value,
                        onTap: () => controller.toggleAuthMode(),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Input Fields
            CustomInput(
              hintText: "Email",
              controller: controller.emailController,
            ),
            const SizedBox(height: 15),
            CustomInput(
              hintText: "Password",
              isPassword: true,
              controller: controller.passwordController,
            ),
            const SizedBox(height: 15),
            Obx(() => controller.isRegister.value
                ? CustomInput(
                    hintText: "Confirm Password",
                    isPassword: true,
                    controller: controller.confirmPasswordController,
                  )
                : Container()),
            const SizedBox(height: 20),
            // Sign Up / Login Button
            Obx(() => CustomButton(
                  text: controller.isRegister.value ? "Sign Up" : "Login",
                  onPressed: () => controller.handleAuth(),
                )),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
