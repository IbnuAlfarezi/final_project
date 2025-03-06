class OnboardingPage {
  final String image;
  final String title;

  OnboardingPage({required this.image, required this.title});
}

final List<OnboardingPage> onboardingPages = [
  OnboardingPage(
    image: "assets/image/onboard1.png",
    title: "Find job offers from the most popular job listing sites ",
  ),
  OnboardingPage(
    image: "assets/image/onboard2.png",
    title: "Track all your job applicatons and don’t get lost in the process",
  ),
  OnboardingPage(
    image: "assets/image/onboard3.png",
    title: "Start appliying and get a Job Now!",
  ),
];
