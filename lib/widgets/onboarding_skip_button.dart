import 'package:flutter/material.dart';

class OnboardingSkipButton
    extends StatelessWidget {

  final VoidCallback onTap;

  const OnboardingSkipButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,

      child: TextButton(
        onPressed: onTap,

        style: TextButton.styleFrom(
          foregroundColor:
              Colors.white70,
        ),

        child: const Text(
          'Skip',
          style: TextStyle(
            fontSize: 14,
            letterSpacing: .4,
          ),
        ),
      ),
    );
  }
}
