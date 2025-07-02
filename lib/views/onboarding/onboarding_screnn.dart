import 'package:flutter/material.dart';
import 'package:my_clean_city/core/services/authServices/auth_gates.dart';
import 'package:my_clean_city/core/utils/helpers.dart';
import 'package:my_clean_city/models/onboarding_model.dart';
import 'package:my_clean_city/widgets/animated_contenu.dart';
import 'package:my_clean_city/widgets/onboarding_container.dart';
import 'package:my_clean_city/widgets/text_custom.dart';

class OnboardingScrenn extends StatefulWidget {
  const OnboardingScrenn({super.key});

  @override
  State<OnboardingScrenn> createState() => _OnboardingState();
}

class _OnboardingState extends State<OnboardingScrenn> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  int index = 0;

  void pageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.all(20),
          child: Column(
            children: [
              SizedBox(height: 100),
              Expanded(
                child: PageView.builder(
                  onPageChanged: pageChanged,
                  controller: _pageController,
                  itemCount: onboardingData.length,
                  itemBuilder: (context, index) {
                    final onboarding = onboardingData[index];
                    return OnboardingContainer(
                      imageUrl: onboarding['imageUrl'],
                      title: onboarding['title'],
                      description: onboarding['description'],
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              AnimatedContenu(
                nbre: onboardingData.length,
                index: index,
                currentIndex: currentIndex,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap:
                    currentIndex == 2
                        ? () => navigatePushReplacement(context, AuthGates())
                        : null,
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color:
                        currentIndex == 0
                            ? Colors.lightGreenAccent
                            : currentIndex == 1
                            ? Colors.lightGreen
                            : Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: TextCustom(
                      data: 'Continuer',
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
