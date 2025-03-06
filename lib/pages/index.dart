import 'package:final_project/components/custom_button.dart';
import 'package:final_project/controller/onboarding_controller.dart';
import 'package:final_project/models/onboarding_model.dart';
import 'package:final_project/routes/app_routes.dart';
import 'package:final_project/style/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class SplashScreen extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Job",style: AppTextStyles.splashScreenHeading.copyWith(color: Colors.black)),
                Text("Now",style: AppTextStyles.splashScreenHeading),
              ],
            ),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: onboardingPages.length,
                onPageChanged: (index) => controller.currentPage.value = index,
                itemBuilder: (context, index) {
                  final page = onboardingPages[index];
                  return Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          child: Image.asset(
                            page.image,
                            fit: BoxFit.fill,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              page.title,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.splashScreenHeading2,
                              // style: AppTextStyles.heading,
                            ),
                            SizedBox(height: 24),
                            SmoothPageIndicator(
                              controller: controller.pageController,
                              count: onboardingPages.length,
                              effect: ExpandingDotsEffect(
                                dotHeight: 8,
                                dotWidth: 8,
                                activeDotColor: Colors.blue,
                                dotColor: Colors.grey.shade300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 37),
              child: Obx(() => CustomButton(
                    text: controller.currentPage.value == 0 ? "Get Started" : "Next",
                    onPressed: () {
                      if (controller.currentPage.value == onboardingPages.length - 1) {
                          Get.toNamed(AppRoutes.login);
                      } else {
                        controller.nextPage();
                      }
                    },
                  )),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
