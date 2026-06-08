import 'package:flutter/material.dart';

import 'onboarding_flow_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    super.key,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();

  int currentPage = 0;

  final List<_IntroSlide> slides = const [
    _IntroSlide(
      title: 'Welcome to Ciantis',
      subtitle:
          'Your luxury life operating system for spaces, documents, goals, money, wellness, and everything you are building.',
      imagePath: 'assets/images/onboarding/intro_1.png',
    ),
    _IntroSlide(
      title: 'Built Around You',
      subtitle:
          'Before you enter, Ciantis will ask a few setup questions so your system feels personal from the beginning.',
      imagePath: 'assets/images/onboarding/intro_2.png',
    ),
    _IntroSlide(
      title: 'Your Life, Organized',
      subtitle:
          'Set up your theme, spaces, privacy, dashboard style, rhythm, and preferences next.',
      imagePath: 'assets/images/onboarding/intro_3.png',
    ),
  ];

  void next() {
    if (currentPage == slides.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const OnboardingFlowScreen(),
        ),
      );
      return;
    }

    controller.nextPage(
      duration: const Duration(milliseconds: 360),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    for (final slide in slides) {
      precacheImage(
        AssetImage(slide.imagePath),
        context,
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        itemCount: slides.length,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          final slide = slides[index];

          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  slide.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(.04),
                        Colors.black.withOpacity(.16),
                        Colors.black.withOpacity(.42),
                      ],
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(26),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Text(
                              slide.title,
                              style: const TextStyle(
                                fontSize: 42,
                                height: 1,
                                fontWeight: FontWeight.w300,
                                letterSpacing: -1,
                                color: Color(0xFFF8F4EF),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              slide.subtitle,
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.75,
                                fontWeight: FontWeight.w300,
                                letterSpacing: .1,
                                color: Colors.white.withOpacity(.82),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          slides.length,
                          (dotIndex) {
                            final selected = currentPage == dotIndex;

                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 240),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              height: 6,
                              width: selected ? 26 : 6,
                              decoration: BoxDecoration(
                                color: selected
                                    ? Colors.white
                                    : Colors.white.withOpacity(.32),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 28),
                      GestureDetector(
                        onTap: next,
                        child: Container(
                          height: 64,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.92),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            currentPage == slides.length - 1
                                ? 'Start Setup'
                                : 'Continue',
                            style: const TextStyle(
                              color: Color(0xFF2D241D),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -.1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _IntroSlide {
  final String title;
  final String subtitle;
  final String imagePath;

  const _IntroSlide({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
}