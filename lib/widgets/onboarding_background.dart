import 'package:flutter/material.dart';

class OnboardingBackground
    extends StatelessWidget {

  final Widget child;

  const OnboardingBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(

        image: DecorationImage(

          image: AssetImage(
            'assets/images/onboarding_bg.jpg',
          ),

          fit: BoxFit.cover,
        ),
      ),

      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            colors: [

              Colors.black.withOpacity(.15),

              Colors.black.withOpacity(.45),

              Colors.black.withOpacity(.72),
            ],
          ),
        ),

        child: child,
      ),
    );
  }
}
