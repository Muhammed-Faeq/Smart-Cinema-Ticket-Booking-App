import 'package:curve_navbar/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utilities/onboarding_images.dart';
import 'utilities/onboarding_texts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<Map<String, String>> onboardingData = [
    {
      "image": ONBImages.onboardingImage1,
      "title": ONBTexts.onboardingTitle1,
      "subtitle": ONBTexts.onboardingSubTitle1
    },
    {
      "image": ONBImages.onboardingImage2,
      "title": ONBTexts.onboardingTitle2,
      "subtitle": ONBTexts.onboardingSubTitle2
    },
    {
      "image": ONBImages.onboardingImage3,
      "title": ONBTexts.onboardingTitle3,
      "subtitle": ONBTexts.onboardingSubTitle3
    },
  ];

  late PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void skipToLastPage() {
    pageController.jumpToPage(onboardingData.length - 1);
    setState(() {
      pageIndex = onboardingData.length - 1;
    });
  }

  void goToLoginScreen() {
    Get.offNamed(Routes.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          children: [
            /// Skip Button
            Positioned(
              top: 50,
              right: 10,
              child: TextButton(
                //style: TextButton.styleFrom(backgroundColor: Colors.black12),
                onPressed: skipToLastPage,
                child: const Text(
                  "Skip",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),

            Column(
              children: [
                /// PageView for Onboarding
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    onPageChanged: (index) {
                      setState(() {
                        pageIndex = index;
                      });
                    },
                    itemCount: onboardingData.length,
                    itemBuilder: (context, index) {
                      final data = onboardingData[index];
                      return OnboardingPage(
                        image: data["image"]!,
                        title: data["title"]!,
                        subtitle: data["subtitle"]!,
                      );
                    },
                  ),
                ),

                /// Dot Indicators and Next Button
                Row(
                  children: [
                    Row(
                      children: List.generate(
                        onboardingData.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: DotIndicator(isActive: index == pageIndex),
                        ),
                      ),
                    ),
                    const Spacer(),

                    /// Next / Continue Button
                    GestureDetector(
                      onTap: () {
                        if (pageIndex < onboardingData.length - 1) {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          goToLoginScreen();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              pageIndex < onboardingData.length - 1
                                  ? "Next"
                                  : "Continue",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Colors.white,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Dot Indicator Widget
class DotIndicator extends StatelessWidget {
  final bool isActive;
  const DotIndicator({
    super.key,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 16 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

/// Onboarding Page Widget
class OnboardingPage extends StatelessWidget {
  final String title, subtitle, image;
  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: screenWidth * 0.9,
            height: screenHeight * 0.4,
          ),
          SizedBox(height: screenHeight * 0.05),
          Text(
            title,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
