import 'package:flutter/material.dart';

class LuxuryDivider extends StatelessWidget {
  const LuxuryDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      color: Colors.white.withOpacity(.08),
    );
  }
}
